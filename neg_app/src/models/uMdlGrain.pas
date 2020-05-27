unit uMdlGrain;

interface

uses
  System.SysUtils, FireDAC.Comp.Client, Data.DB, uSrvDatabase, uEntUser, uEntGrain;

type

  TGrainModel = class(TObject)
  private
    FDB: TSrvDatabase;
    FQry: TFDQuery;
    FDS: TDataSource;
    FGrain: TGrain;
  public
    constructor Create;
    destructor Destroy; override;

    procedure save;
    procedure update;
    procedure delete;
    procedure findAll(AQuery: string);
    procedure getById(AId: Integer);
    procedure freeGrain;

    property qry: TFDQuery read FQry; // -Qry Select
    property ds: TDataSource read FDS;
    property grain: TGrain read FGrain write FGrain;
  end;

implementation

const
  cFullSql = 'SELECT GR.ID, GR.DESCRIPTION, GR.PRICE_KG, '
  + ' GR.CREATED_BY, GR.CREATED_AT, GR.CHANGED_BY, GR.CHANGED_AT, '
  + ' US1.USERNAME AS CREATED_BY_NAME, '
  + ' US2.USERNAME AS CHANGED_BY_NAME '
  + ' FROM TB_GRAINS GR '
  + ' LEFT JOIN TB_USERS US1 ON GR.CREATED_BY = US1.ID '
  + ' LEFT JOIN TB_USERS US2 ON GR.CHANGED_BY = US2.ID '
  + ' WHERE GR.ID IS NOT NULL '
  + ' ';

{ TGrainModel }

constructor TGrainModel.Create;
begin
  Self.FDB := TSrvDatabase.Create;
  Self.FDB.connect;
  Self.FDB.initDataSource(Self.FDS, Self.FQry);
end;

procedure TGrainModel.delete;
var
  vQry: TFDQuery;
begin
  if (FGrain = nil) then
    raise Exception.Create('Grão não encontado!');

  Self.FDB.initQuery(vQry);
  try
    vQry.sql.Text := 'DELETE FROM TB_GRAINS WHERE ID = :id;';
    vQry.ParamByName('id').AsInteger := FGrain.id;
    try
      vQry.ExecSQL;
    except
      on E: Exception do
        raise E;
    end;
  finally
    FreeAndNil(vQry);
    FreeAndNil(FGrain);
  end;
end;

destructor TGrainModel.Destroy;
begin
  FreeAndNil(Self.FDS);
  FreeAndNil(Self.FQry);
  FreeAndNil(Self.FDB);

  Self.freeGrain;

  Inherited;
end;

procedure TGrainModel.findAll(AQuery: string);
var
  vSql: string;
begin
  if (FDS = nil) or (FQry = nil) then
    exit;

  FQry.Active := False;
  vSql := cFullSql;

  if (AQuery <> EmptyStr) then
  begin
    vSql := vSql + 'AND UPPER(GR.DESCRIPTION) LIKE ' + QuotedStr('%' + UpperCase(AQuery) + '%');
  end;

  vSql := vSql + ' ORDER BY GR.DESCRIPTION, GR.ID ASC;';
  FQry.sql.Text := vSql;
  FQry.Active := True;
end;

procedure TGrainModel.freeGrain;
begin
  if(FGrain <> nil)then
    FreeAndNil(FGrain);
end;

procedure TGrainModel.getById(AId: Integer);
var
  vQry: TFDQuery;
begin
  if(Self.FGrain <> nil)then
    FreeAndNil(Self.FGrain);

  Self.FDB.initQuery(vQry);
  try
    vQry.sql.Text := cFullSql + ' AND GR.ID = :id;';
    vQry.ParamByName('id').AsInteger := AId;
    try
      vQry.Open;
      if(not vQry.IsEmpty)then
      begin
        Self.FGrain := TGrain.Create;
        Self.FGrain.id := vQry.FieldByName('ID').AsInteger;
        Self.FGrain.description := vQry.FieldByName('DESCRIPTION').AsString;
        Self.FGrain.priceKG := vQry.FieldByName('PRICE_KG').AsFloat;
        Self.FGrain.createdAt := vQry.FieldByName('CREATED_AT').AsDateTime;
        Self.FGrain.changedAt := vQry.FieldByName('CHANGED_AT').AsDateTime;

        Self.FGrain.createdBy := TUser.Create;
        Self.FGrain.createdBy.id := vQry.FieldByName('CREATED_BY').AsInteger;
        Self.FGrain.createdBy.username := vQry.FieldByName('CREATED_BY_NAME').AsString;

        Self.FGrain.changedBy := TUser.Create;
        Self.FGrain.changedBy.id := vQry.FieldByName('CHANGED_BY').AsInteger;
        Self.FGrain.changedBy.username := vQry.FieldByName('CHANGED_BY_NAME').AsString;
      end;
    except
      on E: Exception do
        raise E;
    end;
  finally
    FreeAndNil(vQry);
  end;
end;

procedure TGrainModel.save;
var
  vQry: TFDQuery;
begin
  if (FGrain = nil) then
    raise Exception.Create('Grão não encontado!');

  Self.FDB.initQuery(vQry);
  try
    vQry.sql.Text := 'INSERT INTO TB_GRAINS(DESCRIPTION,PRICE_KG,CREATED_BY)VALUES (:desc,:price,:user);';
    vQry.ParamByName('desc').AsString := FGrain.description;
    vQry.ParamByName('price').AsFloat := FGrain.priceKG;
    vQry.ParamByName('user').AsInteger := FGrain.createdBy.id;
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

procedure TGrainModel.update;
var
  vQry: TFDQuery;
begin
  if (FGrain = nil) then
    raise Exception.Create('Grão não encontado!');

  Self.FDB.initQuery(vQry);
  try
    vQry.sql.Text := 'UPDATE TB_GRAINS G SET '
    +' G.DESCRIPTION = :desc,'
    +' G.PRICE_KG = :price,'
    +' G.CHANGED_BY = :user,'
    +' G.CHANGED_AT = CURRENT_TIMESTAMP'
    +' WHERE ID = :id;';
    vQry.ParamByName('id').AsInteger := FGrain.id;
    vQry.ParamByName('desc').AsString := FGrain.description;
    vQry.ParamByName('price').AsFloat := FGrain.priceKG;
    vQry.ParamByName('user').AsInteger := FGrain.changedBy.id;
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
