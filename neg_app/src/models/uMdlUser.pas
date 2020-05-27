unit uMdlUser;

interface

uses
  System.SysUtils, FireDAC.Comp.Client, Data.DB, uSrvDatabase, uEntUser, uUtlCrypto;

type

  TUserModel = class(TObject)
  private
    FDB: TSrvDatabase;
    FQry: TFDQuery;
    FDS: TDataSource;
    FUser: TUser;
  public
    constructor Create;
    destructor Destroy; override;

    procedure save;
    procedure update;
    procedure delete;
    procedure findAll(AQuery: string);
    procedure getById(AId: Integer);
    procedure freeUser;

    property qry: TFDQuery read FQry; // -Qry Select
    property ds: TDataSource read FDS;
    property user: TUser read FUser write FUser;

    class procedure loadUserById(AId:Integer; var AUser: TUSer);
    class function validateLogin(username: string; password: string): Integer;
  end;

implementation

const
  cFullSql = 'SELECT US.ID, US.USERNAME,'
  +' US.CREATED_AT, US.CREATED_BY, US.CHANGED_AT, US.CHANGED_BY,'
  +' US1.USERNAME AS CREATED_BY_NAME,'
  +' US2.USERNAME AS CHANGED_BY_NAME'
  +' FROM TB_USERS US'
  +' LEFT JOIN TB_USERS US1 ON US1.ID = US.CREATED_BY'
  +' LEFT JOIN TB_USERS US2 ON US2.ID = US.CHANGED_BY'
  +' WHERE US.ID IS NOT NULL ';

{TUserModel}
constructor TUserModel.Create;
begin
  Self.FDB := TSrvDatabase.Create;
  Self.FDB.connect;
  Self.FDB.initDataSource(Self.FDS, Self.FQry);
end;

procedure TUserModel.delete;
var
  vQry: TFDQuery;
begin
  if (FUser = nil) then
    raise Exception.Create('Usuário não encontado!');

  Self.FDB.initQuery(vQry);
  try
    vQry.sql.Text := 'DELETE FROM TB_USERS WHERE ID = :ID;';
    vQry.ParamByName('ID').AsInteger := FUser.id;
    try
      vQry.ExecSQL;
    except
      on E: Exception do
        raise E;
    end;
  finally
    FreeAndNil(vQry);
    FreeAndNil(FUser);
  end;
end;

destructor TUserModel.Destroy;
begin
  FreeAndNil(Self.FDS);
  FreeAndNil(Self.FQry);
  FreeAndNil(Self.FDB);

  Self.freeUser;

  inherited;
end;

procedure TUserModel.findAll(AQuery: string);
var
  vSql: string;
begin
  if (FDS = nil) or (FQry = nil) then
    exit;

  FQry.Active := False;
  vSql := cFullSql;

  if (AQuery <> EmptyStr) then
  begin
    vSql := vSql + 'AND UPPER(US.USERNAME) LIKE ' + QuotedStr('%' + UpperCase(AQuery) + '%');
  end;

  vSql := vSql + ' ORDER BY US.USERNAME, US.ID ASC;';
  FQry.sql.Text := vSql;
  FQry.Active := True;
end;

procedure TUserModel.freeUser;
begin
  if (FUser <> nil) then
    FreeAndNil(FUser);
end;

procedure TUserModel.getById(AId: Integer);
var
  vQry: TFDQuery;
begin
  if(Self.FUser <> nil)then
    FreeAndNil(Self.FUser);

  Self.FDB.initQuery(vQry);
  try
    vQry.sql.Text := cFullSql + ' AND US.ID = :ID;';
    vQry.ParamByName('ID').AsInteger := AId;
    try
      vQry.Open;
      if(not vQry.IsEmpty)then
      begin
        Self.FUser := TUser.Create;
        Self.FUser.id := vQry.FieldByName('ID').AsInteger;
        Self.FUser.username := vQry.FieldByName('USERNAME').AsString;
        Self.FUser.password := vQry.FieldByName('PASSWORD').AsString;
        Self.FUser.createdAt := vQry.FieldByName('CREATED_AT').AsDateTime;
        Self.FUser.changedAt := vQry.FieldByName('CHANGED_AT').AsDateTime;

        Self.FUser.createdBy := TUser.Create;
        Self.FUser.createdBy.id := vQry.FieldByName('CREATED_BY').AsInteger;
        Self.FUser.createdBy.username := vQry.FieldByName('CREATED_BY_NAME').AsString;

        Self.FUser.changedBy := TUser.Create;
        Self.FUser.changedBy.id := vQry.FieldByName('CHANGED_BY').AsInteger;
        Self.FUser.changedBy.username := vQry.FieldByName('CHANGED_BY_NAME').AsString;
      end;
    except
      on E: Exception do
        raise E;
    end;
  finally
    FreeAndNil(vQry);
  end;
end;

class procedure TUserModel.loadUserById(AId: Integer; var AUser: TUSer);
var
  vUsMd: TUserModel;
begin
  if(AUser <> nil)then
  begin
    exit;
  end;

  vUsMd := TUserModel.Create();
  try
    vUsMd.qry.Active := False;
    vUsMd.qry.SQL.Text := ''
    + ' SELECT * '
    + ' FROM TB_USERS '
    + ' WHERE ID = ' + IntToStr(AId)
    + ';';
    vUsMd.qry.Active := True;
    if (not vUsMd.qry.IsEmpty) then
    begin
      AUser := TUser.Create;
      AUser.id := vUsMd.qry.FieldByName('ID').AsInteger;
      AUser.username := vUsMd.qry.FieldByName('USERNAME').AsString;
      AUser.createdAt := vUsMd.qry.FieldByName('CREATED_AT').AsDateTime;
      AUser.changedAt := vUsMd.qry.FieldByName('CHANGED_AT').AsDateTime;

      AUser.createdBy := TUser.Create;
      AUser.createdBy.id := vUsMd.qry.FieldByName('CREATED_BY').AsInteger;

      AUser.changedBy := TUser.Create;
      AUser.changedBy.id := vUsMd.qry.FieldByName('CHANGED_BY').AsInteger;
    end;
  finally
    FreeAndNil(vUsMd);
  end;
end;

procedure TUserModel.save;
var
  vQry: TFDQuery;
begin
  if (FUser = nil) then
    raise Exception.Create('Usuário não encontado!');

  Self.FDB.initQuery(vQry);
  try
    vQry.sql.Text := 'INSERT INTO TB_USERS(USERNAME, "PASSWORD", CREATED_BY) VALUES (:USERNAME, :PASSWORD, :CREATED_BY);';
    vQry.ParamByName('USERNAME').AsString := FUser.username;
    vQry.ParamByName('PASSWORD').AsString := MD5(FUser.password);
    vQry.ParamByName('CREATED_BY').AsInteger := FUser.createdBy.id;
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

procedure TUserModel.update;
var
  vQry: TFDQuery;
begin
  if (FUser = nil) then
    raise Exception.Create('Usuário não encontado!');

  Self.FDB.initQuery(vQry);
  try
    vQry.sql.Text := 'UPDATE TB_USERS  SET'
    +' USERNAME = :USERNAME,'
    +' "PASSWORD" = :PASSWORD,'
    +' CHANGED_BY = :CHANGED_BY,'
    +' CHANGED_AT = CURRENT_TIMESTAMP'
    +' WHERE ID = :ID;';
    vQry.ParamByName('ID').AsInteger := FUser.id;
    vQry.ParamByName('USERNAME').AsString := FUser.username;
    vQry.ParamByName('PASSWORD').AsString := MD5(FUser.password);
    vQry.ParamByName('CHANGED_BY').AsInteger := FUser.changedBy.id;
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

class function TUserModel.validateLogin(username, password: string): Integer;
var
  vUsMd: TUserModel;
begin
  vUsMd := TUserModel.Create();
  try
    Result := -1;
    vUsMd.qry.Active := False;
    // SELECT COUNT(ID) FROM TB_USERS WHERE USERNAME LIKE 'admin' AND "PASSWORD" LIKE '21232f297a57a5a743894a0e4a801fc3';
    vUsMd.qry.SQL.Text := ''
    + ' SELECT ID '
    + ' FROM TB_USERS '
    + ' WHERE USERNAME LIKE ' + QuotedStr(username)
    + ' AND "PASSWORD" LIKE ' + QuotedStr(MD5(password))
    + ';';
    vUsMd.qry.Active := True;
    if (not vUsMd.qry.IsEmpty) then
    begin
        Result := vUsMd.qry.FieldByName('ID').AsInteger;
    end;
  finally
    FreeAndNil(vUsMd);
  end;
end;

end.
