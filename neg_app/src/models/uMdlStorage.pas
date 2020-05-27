unit uMdlStorage;

interface

uses
  System.SysUtils, FireDAC.Comp.Client, Data.DB, uSrvDatabase, uEntUser, uEntStorage;

type

  TStorageModel = class(TObject)
  private
    FDB: TSrvDatabase;
    FQry: TFDQuery;
    FDS: TDataSource;
    FStorage: TStorage;
  public
    constructor Create;
    destructor Destroy; override;

    procedure save;
    procedure update;
    procedure delete;
    procedure findAll(AQuery: string);
    procedure getById(AId: Integer);
    procedure freeStorage;

    property qry: TFDQuery read FQry; // -Qry Select
    property ds: TDataSource read FDS;
    property storage: TStorage read FStorage write FStorage;
  end;

implementation

const
  cFullSql = 'SELECT ST.ID, ST."NAME",'
  +' ST.CREATED_AT, ST.CREATED_BY, ST.CHANGED_AT, ST.CHANGED_BY,'
  +' US1.USERNAME AS CREATED_BY_NAME,'
  +' US2.USERNAME AS CHANGED_BY_NAME'
  +' FROM TB_STORAGES ST'
  +' LEFT JOIN TB_USERS US1 ON US1.ID = ST.CREATED_BY'
  +' LEFT JOIN TB_USERS US2 ON US2.ID = ST.CHANGED_BY'
  +' WHERE ST.ID IS NOT NULL ';

{ TStorageModel }

constructor TStorageModel.Create;
begin
  Self.FDB := TSrvDatabase.Create;
  Self.FDB.connect;
  Self.FDB.initDataSource(Self.FDS, Self.FQry);
end;

procedure TStorageModel.delete;
var
  vQry: TFDQuery;
begin
  if (FStorage = nil) then
    raise Exception.Create('Armazém não encontado!');

  Self.FDB.initQuery(vQry);
  try
    vQry.sql.Text := 'DELETE FROM TB_STORAGES WHERE ID = :ID;';
    vQry.ParamByName('ID').AsInteger := FStorage.id;
    try
      vQry.ExecSQL;
    except
      on E: Exception do
        raise E;
    end;
  finally
    FreeAndNil(vQry);
    FreeAndNil(FStorage);
  end;
end;

destructor TStorageModel.Destroy;
begin
  FreeAndNil(Self.FDS);
  FreeAndNil(Self.FQry);
  FreeAndNil(Self.FDB);

  Self.freeStorage;

  inherited;
end;

procedure TStorageModel.findAll(AQuery: string);
var
  vSql: string;
begin
  if (FDS = nil) or (FQry = nil) then
    exit;

  FQry.Active := False;
  vSql := cFullSql;

  if (AQuery <> EmptyStr) then
  begin
    vSql := vSql + 'AND UPPER(ST."NAME") LIKE ' + QuotedStr('%' + UpperCase(AQuery) + '%');
  end;

  vSql := vSql + ' ORDER BY ST."NAME", ST.ID ASC;';
  FQry.sql.Text := vSql;
  FQry.Active := True;
end;

procedure TStorageModel.freeStorage;
begin
  if (FStorage <> nil) then
    FreeAndNil(FStorage);
end;

procedure TStorageModel.getById(AId: Integer);
var
  vQry: TFDQuery;
begin
  if(Self.FStorage <> nil)then
    FreeAndNil(Self.FStorage);

  Self.FDB.initQuery(vQry);
  try
    vQry.sql.Text := cFullSql + ' AND ST.ID = :ID;';
    vQry.ParamByName('ID').AsInteger := AId;
    try
      vQry.Open;
      if(not vQry.IsEmpty)then
      begin
        Self.FStorage := TStorage.Create;
        Self.FStorage.id := vQry.FieldByName('ID').AsInteger;
        Self.FStorage.name := vQry.FieldByName('NAME').AsString;
        Self.FStorage.createdAt := vQry.FieldByName('CREATED_AT').AsDateTime;
        Self.FStorage.changedAt := vQry.FieldByName('CHANGED_AT').AsDateTime;

        Self.FStorage.createdBy := TUser.Create;
        Self.FStorage.createdBy.id := vQry.FieldByName('CREATED_BY').AsInteger;
        Self.FStorage.createdBy.username := vQry.FieldByName('CREATED_BY_NAME').AsString;

        Self.FStorage.changedBy := TUser.Create;
        Self.FStorage.changedBy.id := vQry.FieldByName('CHANGED_BY').AsInteger;
        Self.FStorage.changedBy.username := vQry.FieldByName('CHANGED_BY_NAME').AsString;
      end;
    except
      on E: Exception do
        raise E;
    end;
  finally
    FreeAndNil(vQry);
  end;
end;

procedure TStorageModel.save;
var
  vQry: TFDQuery;
begin
  if (FStorage = nil) then
    raise Exception.Create('Armazém não encontado!');

  Self.FDB.initQuery(vQry);
  try
    vQry.sql.Text := 'INSERT INTO TB_STORAGES("NAME", CREATED_BY) VALUES (:NAME, :CREATED_BY);';
    vQry.ParamByName('NAME').AsString := FStorage.name;
    vQry.ParamByName('CREATED_BY').AsInteger := FStorage.createdBy.id;
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

procedure TStorageModel.update;
var
  vQry: TFDQuery;
begin
  if (FStorage = nil) then
    raise Exception.Create('Armazém não encontado!');

  Self.FDB.initQuery(vQry);
  try
    vQry.sql.Text := 'UPDATE TB_STORAGES SET '
    +' "NAME" = :NAME,'
    +' CHANGED_BY = :CHANGED_BY,'
    +' CHANGED_AT = CURRENT_TIMESTAMP'
    +' WHERE ID = :ID;';
    vQry.ParamByName('ID').AsInteger := FStorage.id;
    vQry.ParamByName('NAME').AsString := FStorage.name;
    vQry.ParamByName('CHANGED_BY').AsInteger := FStorage.changedBy.id;
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
