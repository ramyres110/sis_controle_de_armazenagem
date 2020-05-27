unit uMdlContract;

interface

uses
  System.SysUtils, FireDAC.Comp.Client, Data.DB, uSrvDatabase, uEntUser, uEntContract;

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
    procedure freeContract;

    property qry: TFDQuery read FQry; // -Qry Select
    property ds: TDataSource read FDS;
    property contract: TContract read FContract write FContract;
  end;

implementation

uses
  uUtlInputFields, uEntStorage, uEntProducer, uEntGrain;

const
  cFullSql = 'SELECT CO.ID, CO.EXTERNAL_ID, '
  + ' CO.INITIAL_WEIGHT, CO.INITIAL_WEIGHTED_BY, US3.USERNAME AS INITIAL_WEIGHTED_BY_NAME, CO.INITIAL_WEIGHTED_AT, '
  + ' CO.MOISTURE_PERCENT, CO.MOISTURE_BY, US4.USERNAME AS MOISTURE_BY_NAME, CO.MOISTURE_AT, '
  + ' CO.FINAL_WEIGHT, CO.FINAL_WEIGHTED_BY, US5.USERNAME AS FINAL_WEIGHTED_BY_NAME, CO.FINAL_WEIGHTED_AT, '
  + ' CO.IS_VALIDATED, CO.VALIDATED_BY, CO.VALIDATED_AT, '
  + ' CO.CREATED_BY, US1.USERNAME AS CREATED_BY_NAME, CO.CREATED_AT, '
  + ' CO.CHANGED_BY, US2.USERNAME AS CHANGED_BY_NAME, CO.CHANGED_AT, '
  + ' CO.STORAGE_ID, ST."NAME" AS STORAGE_NAME, '
  + ' CO.PRODUCER_ID, PR."NAME" AS PRODUCER_NAME, '
  + ' CO.GRAIN_ID, GR.DESCRIPTION AS GRAIN_DESC '
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

destructor TContractModel.Destroy;
begin
  FreeAndNil(Self.FDS);
  FreeAndNil(Self.FQry);
  FreeAndNil(Self.FDB);

  Self.freeContract;

  inherited;
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
        Self.FContract.id := vQry.FieldByName('ID').AsInteger;

        Self.FContract.storage := TStorage.Create;
        Self.FContract.storage.id := vQry.FieldByName('STORAGE_ID').AsInteger;
        Self.FContract.storage.name := vQry.FieldByName('STORAGE_NAME').AsString;

        Self.FContract.producer := TProducer.Create;
        Self.FContract.producer.id := vQry.FieldByName('PRODUCER_ID').AsInteger;
        Self.FContract.producer.name := vQry.FieldByName('PRODUCER_NAME').AsString;

        Self.FContract.grain := TGrain.Create;
        Self.FContract.grain.id := vQry.FieldByName('GRAIN_ID').AsInteger;
        Self.FContract.grain.description := vQry.FieldByName('GRAIN_DESC').AsString;

        //INITIAL_WEIGHT
        Self.FContract.initialWeight := vQry.FieldByName('INITIAL_WEIGHT').AsFloat;
        Self.FContract.initialWeightedBy := TUser.Create;
        Self.FContract.initialWeightedBy.id := vQry.FieldByName('INITIAL_WEIGHTED_BY').AsInteger;
        Self.FContract.initialWeightedBy.username := vQry.FieldByName('INITIAL_WEIGHTED_BY_NAME').AsString;
        Self.FContract.initialWeightedAt := vQry.FieldByName('INITIAL_WEIGHTED_AT').AsDateTime;

        //MOISTURE_PERCENT
        Self.FContract.moisturePercent := vQry.FieldByName('MOISTURE_PERCENT').AsFloat;
        Self.FContract.moistureBy := TUser.Create;
        Self.FContract.moistureBy.id := vQry.FieldByName('MOISTURE_BY').AsInteger;
        Self.FContract.moistureBy.username := vQry.FieldByName('MOISTURE_BY_NAME').AsString;
        Self.FContract.moistureAt := vQry.FieldByName('MOISTURE_AT').AsDateTime;

        //FINAL_WEIGHT
        Self.FContract.finalWeight := vQry.FieldByName('FINAL_WEIGHT').AsInteger;
        Self.FContract.finalWeightedBy := TUser.Create;
        Self.FContract.finalWeightedBy.id := vQry.FieldByName('FINAL_WEIGHTED_BY').AsInteger;
        Self.FContract.finalWeightedBy.username := vQry.FieldByName('FINAL_WEIGHTED_BY_NAME').AsString;
        Self.FContract.finalWeightedAt := vQry.FieldByName('FINAL_WEIGHTED_AT').AsDateTime;

        Self.FContract.isValidated := vQry.FieldByName('IS_VALIDATED').AsBoolean;
        Self.FContract.validatedBy := vQry.FieldByName('VALIDATED_BY').AsString;
        Self.FContract.validatedAt := vQry.FieldByName('VALIDATED_AT').AsDateTime;

        Self.FContract.externalId := vQry.FieldByName('EXTERNAL_ID').AsInteger;

        Self.FContract.createdBy := TUser.Create;
        Self.FContract.createdBy.id := vQry.FieldByName('CREATED_BY').AsInteger;
        Self.FContract.createdBy.username := vQry.FieldByName('CREATED_BY_NAME').AsString;
        Self.FContract.createdAt := vQry.FieldByName('CREATED_AT').AsDateTime;

        Self.FContract.changedBy := TUser.Create;
        Self.FContract.changedBy.id := vQry.FieldByName('CHANGED_BY').AsInteger;
        Self.FContract.changedBy.username := vQry.FieldByName('CHANGED_BY_NAME').AsString;
        Self.FContract.changedAt := vQry.FieldByName('CHANGED_AT').AsDateTime;
      end;
    except
      on E: Exception do
        raise E;
    end;
  finally
    FreeAndNil(vQry);
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
    + ' IS_VALIDATED, VALIDATED_BY, VALIDATED_AT, CREATED_BY'
    + ' ) VALUES ('
    + ' :STORAGE_ID, :PRODUCER_ID, :GRAIN_ID,'
    + ' :INITIAL_WEIGHT, :INITIAL_WEIGHTED_BY, :INITIAL_WEIGHTED_AT,'
    + ' :FINAL_WEIGHT, :FINAL_WEIGHTED_BY, :FINAL_WEIGHTED_AT,'
    + ' :MOISTURE_PERCENT, :MOISTURE_BY, :MOISTURE_AT,'
    + ' :IS_VALIDATED, :VALIDATED_BY, :VALIDATED_AT, :CREATED_BY'
    + ' );';

    //TODO: Check Insert Memory Access and Data on Database
    vQry.ParamByName('STORAGE_ID').AsInteger := FContract.storage.id;
    vQry.ParamByName('PRODUCER_ID').AsInteger := FContract.producer.id;
    vQry.ParamByName('GRAIN_ID').AsInteger := FContract.grain.id;

    vQry.ParamByName('INITIAL_WEIGHT').AsFloat := FContract.initialWeight;
    vQry.ParamByName('INITIAL_WEIGHTED_BY').AsInteger := FContract.initialWeightedBy.id;
    vQry.ParamByName('INITIAL_WEIGHTED_AT').AsDate := FContract.initialWeightedAt;

    vQry.ParamByName('MOISTURE_PERCENT').AsFloat := FContract.moisturePercent;
    vQry.ParamByName('MOISTURE_BY').AsInteger := FContract.moistureBy.id;
    vQry.ParamByName('MOISTURE_AT').AsDate := FContract.moistureAt;

    vQry.ParamByName('FINAL_WEIGHT').AsFloat := FContract.finalWeight;
    vQry.ParamByName('FINAL_WEIGHTED_BY').AsInteger := FContract.finalWeightedBy.id;
    vQry.ParamByName('FINAL_WEIGHTED_AT').AsDate := FContract.finalWeightedAt;


    vQry.ParamByName('IS_VALIDATED').AsInteger := iif(FContract.isValidated,1,0);
    vQry.ParamByName('VALIDATED_BY').AsString := FContract.validatedBy;
    vQry.ParamByName('VALIDATED_AT').AsDate := FContract.validatedAt;

    vQry.ParamByName('CREATED_BY').AsInteger := FContract.createdBy.id;

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

    vQry.ParamByName('INITIAL_WEIGHT').AsFloat := FContract.initialWeight;
    vQry.ParamByName('INITIAL_WEIGHTED_BY').AsInteger := FContract.initialWeightedBy.id;
    vQry.ParamByName('INITIAL_WEIGHTED_AT').AsDate := FContract.initialWeightedAt;

    vQry.ParamByName('MOISTURE_PERCENT').AsFloat := FContract.moisturePercent;
    vQry.ParamByName('MOISTURE_BY').AsInteger := FContract.moistureBy.id;
    vQry.ParamByName('MOISTURE_AT').AsDate := FContract.moistureAt;

    vQry.ParamByName('FINAL_WEIGHT').AsFloat := FContract.finalWeight;
    vQry.ParamByName('FINAL_WEIGHTED_BY').AsInteger := FContract.finalWeightedBy.id;
    vQry.ParamByName('FINAL_WEIGHTED_AT').AsDate := FContract.finalWeightedAt;

    vQry.ParamByName('IS_VALIDATED').AsInteger := iif(FContract.isValidated,1,0);
    vQry.ParamByName('VALIDATED_BY').AsString := FContract.validatedBy;
    vQry.ParamByName('VALIDATED_AT').AsDate := FContract.validatedAt;

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

end.
