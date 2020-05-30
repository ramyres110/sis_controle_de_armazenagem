unit uMdlContract;

interface

uses
  System.SysUtils, FireDAC.Comp.Client, Data.DB, uSrvDatabase, uEntUser, uEntContract,
  System.Generics.Collections;

type

  TContractModel = class
  private
    FDB: TSrvDatabase;
    FQry: TFDQuery;
    FDS: TDataSource;
    FContract: TContract;
  public
    constructor Create;
    destructor Destroy; override;

    procedure save;
    procedure update;
    procedure delete;
    procedure findAll(AQuery: string);
    procedure getById(AId: Integer);

    procedure syncSaveWithAPI;
    procedure syncValidateWithAPI(AId:Integer);

    procedure fillContractByQuery(const AQry:TFDQuery; var AContract:TContract);
    procedure freeContract;

    property qry: TFDQuery read FQry; // -Qry Select
    property ds: TDataSource read FDS;
    property contract: TContract read FContract write FContract;

    class procedure loadList(var AList:TObjectList<TContract>);
    class procedure deleteById(AId:Integer);

    class procedure updateInitialWeight(AId: Integer; AValue: Double; const AUser: TUser);
    class procedure updateMoisture(AId: Integer; AValue: Double; const AUser: TUser);
    class procedure updateFinalWeight(AId: Integer; AValue: Double; const AUser: TUser);
    class procedure updateValidated(AId: Integer; AIsValidated: Boolean; AValidatedBy: string);
  end;

implementation

uses
  uUtlInputFields, uEntStorage, uEntProducer, uEntGrain, uSrvAPI;

const
  cFullSql = 'SELECT CO.ID, CO.EXTERNAL_ID, '
  + ' CO.INITIAL_WEIGHT, CO.INITIAL_WEIGHTED_BY, US3.USERNAME AS INITIAL_WEIGHTED_BY_NAME, CO.INITIAL_WEIGHTED_AT, '
  + ' CO.MOISTURE_PERCENT, CO.MOISTURE_BY, US4.USERNAME AS MOISTURE_BY_NAME, CO.MOISTURE_AT, '
  + ' CO.FINAL_WEIGHT, CO.FINAL_WEIGHTED_BY, US5.USERNAME AS FINAL_WEIGHTED_BY_NAME, CO.FINAL_WEIGHTED_AT, '
  + ' CO.IS_VALIDATED, CO.VALIDATED_BY, CO.VALIDATED_AT, '
  + ' CASE CO.IS_VALIDATED WHEN 1 THEN '+'''VALIDADO'''+' ELSE '+'''AGUARDANDO'''+' END AS VALIDATED, '
  + ' CO.CREATED_BY, US1.USERNAME AS CREATED_BY_NAME, CO.CREATED_AT, '
  + ' CO.CHANGED_BY, US2.USERNAME AS CHANGED_BY_NAME, CO.CHANGED_AT, '
  + ' CO.STORAGE_ID, ST."NAME" AS STORAGE_NAME, '
  + ' CO.PRODUCER_ID, PR."NAME" AS PRODUCER_NAME, '
  + ' CO.GRAIN_ID, GR.DESCRIPTION AS GRAIN_DESC, GR.PRICE_KG AS GRAIN_PRICE '
  + ' FROM TB_CONTRACTS CO '
  + ' LEFT JOIN TB_USERS US1 ON US1.ID = CO.CREATED_BY '
  + ' LEFT JOIN TB_USERS US2 ON US2.ID = CO.CHANGED_BY '
  + ' LEFT JOIN TB_USERS US3 ON US3.ID = CO.INITIAL_WEIGHTED_BY '
  + ' LEFT JOIN TB_USERS US4 ON US4.ID = CO.MOISTURE_BY '
  + ' LEFT JOIN TB_USERS US5 ON US5.ID = CO.FINAL_WEIGHTED_BY, '
  + ' TB_STORAGES ST, '
  + ' TB_PRODUCERS PR, '
  + ' TB_GRAINS GR '
  + ' WHERE CO.STORAGE_ID = ST.ID '
  + ' AND CO.PRODUCER_ID = PR.ID '
  + ' AND CO.GRAIN_ID = GR.ID ';

{ TContractModel }

constructor TContractModel.Create;
begin
  Self.FDB := TSrvDatabase.Create;
  Self.FDB.connect;
  Self.FDB.initDataSource(Self.FDS, Self.FQry);
end;

procedure TContractModel.delete;
var
  vQry: TFDQuery;
begin
  if (FContract = nil) then
    raise Exception.Create('Contrato não encontado!');

  Self.FDB.initQuery(vQry);
  try
    vQry.sql.Text := 'DELETE FROM TB_CONTRACTS WHERE ID = :ID;';
    vQry.ParamByName('ID').AsInteger := FContract.id;
    try
      vQry.ExecSQL;
    except
      on E: Exception do
        raise E;
    end;
  finally
    FreeAndNil(vQry);
    FreeAndNil(FContract);
  end;
end;

class procedure TContractModel.deleteById(AId: Integer);
var
  vMdl: TContractModel;
begin
  vMdl := TContractModel.Create;
  try
    try
      vMdl.contract := TContract.Create;
      vMdl.contract.id := AId;
      vMdl.delete;
    except
      on E: Exception do
        raise E;
    end;
  finally
    FreeAndNil(vMdl);
  end;
end;

destructor TContractModel.Destroy;
begin
  FreeAndNil(Self.FDS);
  FreeAndNil(Self.FQry);
  FreeAndNil(Self.FDB);

  Self.freeContract;

  inherited;
end;

procedure TContractModel.fillContractByQuery(const AQry: TFDQuery; var AContract: TContract);
begin
  if(AQry = nil) then
    raise Exception.Create('Create a query before fill contract');

  if (AContract = nil) then
    raise Exception.Create('Create a contract before fill');

  if(AQry.IsEmpty)then
    Exit;

  AContract.id := AQry.FieldByName('ID').AsInteger;

  AContract.storage := TStorage.Create;
  AContract.storage.id := AQry.FieldByName('STORAGE_ID').AsInteger;
  AContract.storage.name := AQry.FieldByName('STORAGE_NAME').AsString;

  AContract.producer := TProducer.Create;
  AContract.producer.id := AQry.FieldByName('PRODUCER_ID').AsInteger;
  AContract.producer.name := AQry.FieldByName('PRODUCER_NAME').AsString;

  AContract.grain := TGrain.Create;
  AContract.grain.id := AQry.FieldByName('GRAIN_ID').AsInteger;
  AContract.grain.description := AQry.FieldByName('GRAIN_DESC').AsString;
  AContract.grain.priceKG := AQry.FieldByName('GRAIN_PRICE').AsFloat;


  // INITIAL_WEIGHT
  AContract.initialWeight := AQry.FieldByName('INITIAL_WEIGHT').AsFloat;
  AContract.initialWeightedBy := TUser.Create;
  AContract.initialWeightedBy.id := AQry.FieldByName('INITIAL_WEIGHTED_BY').AsInteger;
  AContract.initialWeightedBy.username := AQry.FieldByName('INITIAL_WEIGHTED_BY_NAME').AsString;
  AContract.initialWeightedAt := AQry.FieldByName('INITIAL_WEIGHTED_AT').AsDateTime;

  // MOISTURE_PERCENT
  AContract.moisturePercent := AQry.FieldByName('MOISTURE_PERCENT').AsFloat;
  AContract.moistureBy := TUser.Create;
  AContract.moistureBy.id := AQry.FieldByName('MOISTURE_BY').AsInteger;
  AContract.moistureBy.username := AQry.FieldByName('MOISTURE_BY_NAME').AsString;
  AContract.moistureAt := AQry.FieldByName('MOISTURE_AT').AsDateTime;

  // FINAL_WEIGHT
  AContract.finalWeight := AQry.FieldByName('FINAL_WEIGHT').AsInteger;
  AContract.finalWeightedBy := TUser.Create;
  AContract.finalWeightedBy.id := AQry.FieldByName('FINAL_WEIGHTED_BY').AsInteger;
  AContract.finalWeightedBy.username := AQry.FieldByName('FINAL_WEIGHTED_BY_NAME').AsString;
  AContract.finalWeightedAt := AQry.FieldByName('FINAL_WEIGHTED_AT').AsDateTime;

  AContract.isValidated := iif(AQry.FieldByName('IS_VALIDATED').AsInteger = 1, True, False);
  AContract.validatedBy := AQry.FieldByName('VALIDATED_BY').AsString;
  AContract.validatedAt := AQry.FieldByName('VALIDATED_AT').AsDateTime;

  AContract.externalId := AQry.FieldByName('EXTERNAL_ID').AsString;

  AContract.createdBy := TUser.Create;
  AContract.createdBy.id := AQry.FieldByName('CREATED_BY').AsInteger;
  AContract.createdBy.username := AQry.FieldByName('CREATED_BY_NAME').AsString;
  AContract.createdAt := AQry.FieldByName('CREATED_AT').AsDateTime;

  AContract.changedBy := TUser.Create;
  AContract.changedBy.id := AQry.FieldByName('CHANGED_BY').AsInteger;
  AContract.changedBy.username := AQry.FieldByName('CHANGED_BY_NAME').AsString;
  AContract.changedAt := AQry.FieldByName('CHANGED_AT').AsDateTime;
end;

procedure TContractModel.findAll(AQuery: string);
var
  vSql: string;
begin
  if (FDS = nil) or (FQry = nil) then
    exit;

  FQry.Active := False;
  vSql := cFullSql;

  if (AQuery <> EmptyStr) then
  begin
    //TODO:
    vSql := vSql + '';
  end;

  vSql := vSql + ' ORDER BY CO.ID ASC;';
  FQry.sql.Text := vSql;
  FQry.Active := True;
end;

procedure TContractModel.freeContract;
begin
  if (FContract <> nil) then
    FreeAndNil(FContract);
end;

procedure TContractModel.getById(AId: Integer);
var
  vQry: TFDQuery;
begin
  if(Self.FContract <> nil)then
    FreeAndNil(Self.FContract);

  Self.FDB.initQuery(vQry);
  try
    vQry.sql.Text := cFullSql + ' AND CO.ID = :ID;';
    vQry.ParamByName('ID').AsInteger := AId;
    try
      vQry.Open;
      if(not vQry.IsEmpty)then
      begin
        Self.FContract := TContract.Create;
        Self.fillContractByQuery(vQry,FContract);
      end;
    except
      on E: Exception do
        raise E;
    end;
  finally
    FreeAndNil(vQry);
  end;
end;

class procedure TContractModel.loadList(var AList: TObjectList<TContract>);
var
  vQry: TFDQuery;
  vMdl: TContractModel;
  vAuxObj: TContract;
begin
  if(AList = nil)then
    raise Exception.Create('List must be created before');

  vMdl := TContractModel.Create;
  vMdl.FDB.initQuery(vQry);
  try
    vQry.sql.Text := cFullSql;
    try
      vQry.Open;
      if not vQry.IsEmpty then
      begin
        while not vQry.Eof do
        begin
          vAuxObj := TContract.Create;
          vMdl.fillContractByQuery(vQry, vAuxObj);
          AList.Add(vAuxObj);
          vQry.Next;
        end;
      end;
    except
      on E: Exception do
        raise E;
    end;
  finally
    FreeAndNil(vQry);
    FreeAndNil(vMdl);
  end;
end;

procedure TContractModel.save;
var
  vQry: TFDQuery;
begin
  if (FContract = nil) then
    raise Exception.Create('Contrato não encontado!');

  Self.FDB.initQuery(vQry);
  try
    vQry.sql.Text := 'INSERT INTO TB_CONTRACTS('
    + ' STORAGE_ID, PRODUCER_ID, GRAIN_ID,'
    + ' INITIAL_WEIGHT, INITIAL_WEIGHTED_BY, INITIAL_WEIGHTED_AT,'
    + ' FINAL_WEIGHT, FINAL_WEIGHTED_BY, FINAL_WEIGHTED_AT,'
    + ' MOISTURE_PERCENT, MOISTURE_BY, MOISTURE_AT,'
    + ' IS_VALIDATED, VALIDATED_BY, VALIDATED_AT, CREATED_BY, CHANGED_BY'
    + ' ) VALUES ('
    + ' :STORAGE_ID, :PRODUCER_ID, :GRAIN_ID,'
    + ' :INITIAL_WEIGHT, :INITIAL_WEIGHTED_BY, :INITIAL_WEIGHTED_AT,'
    + ' :FINAL_WEIGHT, :FINAL_WEIGHTED_BY, :FINAL_WEIGHTED_AT,'
    + ' :MOISTURE_PERCENT, :MOISTURE_BY, :MOISTURE_AT,'
    + ' :IS_VALIDATED, :VALIDATED_BY, :VALIDATED_AT, :CREATED_BY, :CHANGED_BY'
    + ' );';

    //TODO: Check Insert Memory Access and Data on Database
    vQry.ParamByName('STORAGE_ID').AsInteger := FContract.storage.id;
    vQry.ParamByName('PRODUCER_ID').AsInteger := FContract.producer.id;
    vQry.ParamByName('GRAIN_ID').AsInteger := FContract.grain.id;

    if (FContract.initialWeightedBy <> nil)then
    begin
      vQry.ParamByName('INITIAL_WEIGHT').AsFloat := FContract.initialWeight;
      vQry.ParamByName('INITIAL_WEIGHTED_BY').AsInteger := FContract.initialWeightedBy.id;
      vQry.ParamByName('INITIAL_WEIGHTED_AT').AsDate := FContract.initialWeightedAt;
    end;

    if (FContract.moistureBy <> nil) then
    begin
      vQry.ParamByName('MOISTURE_PERCENT').AsFloat := FContract.moisturePercent;
      vQry.ParamByName('MOISTURE_BY').AsInteger := FContract.moistureBy.id;
      vQry.ParamByName('MOISTURE_AT').AsDate := FContract.moistureAt;
    end;

    if (FContract.finalWeightedBy <> nil) then
    begin
      vQry.ParamByName('FINAL_WEIGHT').AsFloat := FContract.finalWeight;
      vQry.ParamByName('FINAL_WEIGHTED_BY').AsInteger := FContract.finalWeightedBy.id;
      vQry.ParamByName('FINAL_WEIGHTED_AT').AsDate := FContract.finalWeightedAt;
    end;

    vQry.ParamByName('IS_VALIDATED').AsInteger := iif(FContract.isValidated,1,0);
    vQry.ParamByName('VALIDATED_BY').AsString := FContract.validatedBy;
    vQry.ParamByName('VALIDATED_AT').AsDate := FContract.validatedAt;

    vQry.ParamByName('CREATED_BY').AsInteger := FContract.createdBy.id;
    vQry.ParamByName('CHANGED_BY').AsInteger := FContract.createdBy.id;

    try
      vQry.ExecSQL;
      FContract.id := Self.FDB.connection.GetLastAutoGenValue('TB_CONTRACTS_ID_GEN');
    except
      on E: Exception do
        raise E;
    end;
  finally

    try
      Self.syncSaveWithAPI;
    except
      on E: Exception do
    end;

    FreeAndNil(vQry);
  end;
end;

procedure TContractModel.syncSaveWithAPI;
var
  vId:Integer;
begin
  Self.getById(FContract.id);

  TApi.PostContract(FContract);
  if(FContract.externalId <> EmptyStr)then
  begin
    Self.update;
  end;
end;

procedure TContractModel.syncValidateWithAPI(AId:Integer);
begin
  if (FContract = nil) then
    getById(AId);

  TApi.PostValidateContract(FContract);
  freeContract;
end;

procedure TContractModel.update;
var
  vQry: TFDQuery;
begin
  if (FContract= nil) then
    raise Exception.Create('Contrato não encontado!');

  Self.FDB.initQuery(vQry);
  try
    vQry.sql.Text := 'UPDATE TB_CONTRACTS  SET'
    +' STORAGE_ID = :STORAGE_ID,'
    +' PRODUCER_ID = :PRODUCER_ID,'
    +' GRAIN_ID = :GRAIN_ID,'
    +' INITIAL_WEIGHT = :INITIAL_WEIGHT,'
    +' INITIAL_WEIGHTED_BY = :INITIAL_WEIGHTED_BY,'
    +' INITIAL_WEIGHTED_AT = :INITIAL_WEIGHTED_AT,'
    +' MOISTURE_PERCENT = :MOISTURE_PERCENT,'
    +' MOISTURE_BY = :MOISTURE_BY,'
    +' MOISTURE_AT = :MOISTURE_AT,'
    +' FINAL_WEIGHT = :FINAL_WEIGHT,'
    +' FINAL_WEIGHTED_BY = :FINAL_WEIGHTED_BY,'
    +' FINAL_WEIGHTED_AT = :FINAL_WEIGHTED_AT,'
    +' IS_VALIDATED = :IS_VALIDATED,'
    +' VALIDATED_BY = :VALIDATED_BY,'
    +' VALIDATED_AT = :VALIDATED_AT,'
    +' EXTERNAL_ID = :EXTERNAL_ID,'
    +' CHANGED_BY = :CHANGED_BY,'
    +' CHANGED_AT = CURRENT_TIMESTAMP '
    +' WHERE ID = :ID;';
    vQry.ParamByName('ID').AsInteger := FContract.id;

    vQry.ParamByName('STORAGE_ID').AsInteger := FContract.storage.id;
    vQry.ParamByName('PRODUCER_ID').AsInteger := FContract.producer.id;
    vQry.ParamByName('GRAIN_ID').AsInteger := FContract.grain.id;

    if FContract.initialWeight > 0 then
    begin
      vQry.ParamByName('INITIAL_WEIGHT').AsFloat := FContract.initialWeight;
      vQry.ParamByName('INITIAL_WEIGHTED_BY').AsInteger := FContract.initialWeightedBy.id;
      vQry.ParamByName('INITIAL_WEIGHTED_AT').AsDate := FContract.initialWeightedAt;
    end
    else
    begin
      vQry.ParamByName('INITIAL_WEIGHT').Clear;
      vQry.ParamByName('INITIAL_WEIGHTED_BY').Clear;
      vQry.ParamByName('INITIAL_WEIGHTED_AT').Clear;
    end;

    if (FContract.moisturePercent > 0) then
    begin
      vQry.ParamByName('MOISTURE_PERCENT').AsFloat := FContract.moisturePercent;
      vQry.ParamByName('MOISTURE_BY').AsInteger := FContract.moistureBy.id;
      vQry.ParamByName('MOISTURE_AT').AsDate := FContract.moistureAt;
    end
    else
    begin
      vQry.ParamByName('MOISTURE_PERCENT').Clear;
      vQry.ParamByName('MOISTURE_BY').Clear;
      vQry.ParamByName('MOISTURE_AT').Clear;
    end;

    if FContract.finalWeight > 0 then
    begin
      vQry.ParamByName('FINAL_WEIGHT').AsFloat := FContract.finalWeight;
      vQry.ParamByName('FINAL_WEIGHTED_BY').AsInteger := FContract.finalWeightedBy.id;
      vQry.ParamByName('FINAL_WEIGHTED_AT').AsDate := FContract.finalWeightedAt;
    end
    else
    begin
      vQry.ParamByName('FINAL_WEIGHT').Clear;
      vQry.ParamByName('FINAL_WEIGHTED_BY').Clear;
      vQry.ParamByName('FINAL_WEIGHTED_AT').Clear;
    end;

    vQry.ParamByName('IS_VALIDATED').AsInteger := iif(FContract.isValidated,1,0);
    vQry.ParamByName('VALIDATED_BY').AsString := FContract.validatedBy;
    vQry.ParamByName('VALIDATED_AT').AsDate := FContract.validatedAt;

    if(FContract.externalId <> EmptyStr)then
      vQry.ParamByName('EXTERNAL_ID').AsString := FContract.externalId;

    vQry.ParamByName('CHANGED_BY').AsInteger := FContract.changedBy.id;
    try
      vQry.ExecSQL;
    except
      on E: Exception do
        raise E;
    end;
  finally
    FreeAndNil(vQry);
  end;
end;

class procedure TContractModel.updateFinalWeight(AId: Integer; AValue: Double; const AUser: TUser);
var
  vQry: TFDQuery;
  vMdl: TContractModel;
begin
  vMdl := TContractModel.Create;
  vMdl.FDB.initQuery(vQry);
  try
    vQry.sql.Text := 'UPDATE TB_CONTRACTS SET '
    + ' FINAL_WEIGHT = :FINAL_WEIGHT, '
    + ' FINAL_WEIGHTED_BY = :FINAL_WEIGHTED_BY, '
    + ' FINAL_WEIGHTED_AT = :FINAL_WEIGHTED_AT '
    + ' WHERE ID = :ID;';
    vQry.ParamByName('ID').AsInteger := AId;
    vQry.ParamByName('FINAL_WEIGHT').AsFloat := AValue;
    vQry.ParamByName('FINAL_WEIGHTED_BY').AsInteger := AUser.id;
    vQry.ParamByName('FINAL_WEIGHTED_AT').AsDate := Now();
    try
      vQry.ExecSQL;
    except
      on E: Exception do
        raise E;
    end;
  finally
    FreeAndNil(vQry);
    FreeAndNil(vMdl);
  end;
end;

class procedure TContractModel.updateInitialWeight(AId: Integer; AValue: Double; const AUser: TUser);
var
  vQry: TFDQuery;
  vMdl: TContractModel;
begin
  vMdl := TContractModel.Create;
  vMdl.FDB.initQuery(vQry);
  try
    vQry.sql.Text := 'UPDATE TB_CONTRACTS SET '
    + ' INITIAL_WEIGHT = :INITIAL_WEIGHT,'
    + ' INITIAL_WEIGHTED_BY = :INITIAL_WEIGHTED_BY,'
    + ' INITIAL_WEIGHTED_AT = :INITIAL_WEIGHTED_AT '
    + ' WHERE ID = :ID;';
    vQry.ParamByName('ID').AsInteger := AId;
    vQry.ParamByName('INITIAL_WEIGHT').AsFloat := AValue;
    vQry.ParamByName('INITIAL_WEIGHTED_BY').AsInteger := AUser.id;
    vQry.ParamByName('INITIAL_WEIGHTED_AT').AsDate := Now();
    try
      vQry.ExecSQL;
    except
      on E: Exception do
        raise E;
    end;
  finally
    FreeAndNil(vQry);
    FreeAndNil(vMdl);
  end;
end;

class procedure TContractModel.updateMoisture(AId: Integer; AValue: Double; const AUser: TUser);
var
  vQry: TFDQuery;
  vMdl: TContractModel;
begin
  vMdl := TContractModel.Create;
  vMdl.FDB.initQuery(vQry);
  try
    vQry.sql.Text := 'UPDATE TB_CONTRACTS SET '
    + '  MOISTURE_PERCENT = :MOISTURE_PERCENT, '
    + '  MOISTURE_BY = :MOISTURE_BY, '
    + '  MOISTURE_AT = :MOISTURE_AT '
    + ' WHERE ID = :ID;';
    vQry.ParamByName('ID').AsInteger := AId;
    vQry.ParamByName('MOISTURE_PERCENT').AsFloat := AValue;
    vQry.ParamByName('MOISTURE_BY').AsInteger := AUser.id;
    vQry.ParamByName('MOISTURE_AT').AsDate := Now();
    try
      vQry.ExecSQL;
    except
      on E: Exception do
        raise E;
    end;
  finally
    FreeAndNil(vQry);
    FreeAndNil(vMdl);
  end;
end;

class procedure TContractModel.updateValidated(AId: Integer; AIsValidated: Boolean; AValidatedBy: string);
var
  vQry: TFDQuery;
  vMdl: TContractModel;
begin
  vMdl := TContractModel.Create;
  vMdl.FDB.initQuery(vQry);
  try
    vQry.sql.Text := 'UPDATE TB_CONTRACTS SET '
    + '  IS_VALIDATED = :IS_VALIDATED, '
    + '  VALIDATED_BY = :VALIDATED_BY, '
    + '  VALIDATED_AT = :VALIDATED_AT '
    + ' WHERE ID = :ID;';
    vQry.ParamByName('ID').AsInteger := AId;
    vQry.ParamByName('IS_VALIDATED').AsInteger := iif(AIsValidated,1,0);
    vQry.ParamByName('VALIDATED_BY').AsString := AValidatedBy;
    vQry.ParamByName('VALIDATED_AT').AsDate := Now();
    try
      vQry.ExecSQL;
      vMdl.syncValidateWithAPI(AId);
    except
      on E: Exception do
        raise E;
    end;
  finally
    FreeAndNil(vQry);
    FreeAndNil(vMdl);
  end;

end;

end.
