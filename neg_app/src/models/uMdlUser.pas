unit uMdlUser;

interface

uses System.SysUtils, FireDAC.Comp.Client, uSrvDatabase, IdHashMessageDigest, uUtlCrypto, uEntUser;

type

  TUserModel = class(TObject)
  private
    FUser: TUser;
    FDB: TSrvDatabase;
    FQry: TFDQuery;
  public
    constructor Create;
    destructor Destroy; override;

    class procedure loadUserById(AId:Integer; var AUser: TUSer);

    class function validateLogin(username: string; password: string): Integer;

    property qry: TFDQuery read FQry;
  end;

implementation

{ TUser }

constructor TUserModel.Create;
begin
  Self.FDB := TSrvDatabase.Create();
  Self.FDB.connect;
  Self.FDB.initQuery(Self.FQry);
end;

destructor TUserModel.Destroy;
begin
  FreeAndNil(Self.FQry);
  FreeAndNil(Self.FDB);
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
      AUser.createdBy := vUsMd.qry.FieldByName('CREATED_BY').AsInteger;
      AUser.createdAt := vUsMd.qry.FieldByName('CREATED_AT').AsDateTime;
      AUser.changedBy := vUsMd.qry.FieldByName('CHANGED_BY').AsInteger;
      AUser.changedAt := vUsMd.qry.FieldByName('CHANGED_AT').AsDateTime;
    end;
  finally
    FreeAndNil(vUsMd);
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
