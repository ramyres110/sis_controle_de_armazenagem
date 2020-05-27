unit uMdlProducer;

interface

uses
  System.SysUtils, FireDAC.Comp.Client, Data.DB, uSrvDatabase, uEntUser,uEntProducer;

type

  TProducerModel = class(TObject)
  private
    FDB: TSrvDatabase;
    FQry: TFDQuery;
    FDS: TDataSource;
    FProducer: TProducer;
  public
    constructor Create;
    destructor Destroy; override;

    procedure save;
    procedure update;
    procedure delete;
    procedure findAll(AQuery: string);
    procedure getById(AId: Integer);
    procedure freeProducer;

    property qry: TFDQuery read FQry; // -Qry Select
    property ds: TDataSource read FDS;
    property producer: TProducer read FProducer write FProducer;
  end;

implementation

const
  cFullSql = ''
  +' SELECT PR.ID, PR."NAME", PR.DOCUMENT, PR.PHONE, PR.EMAIL,'
  +' PR.CREATED_BY, PR.CREATED_AT, PR.CHANGED_BY, PR.CHANGED_AT,'
  +' US1.USERNAME AS CREATED_BY_NAME, US2.USERNAME AS CHANGED_BY_NAME'
  +' FROM TB_PRODUCERS PR'
  +' LEFT JOIN TB_USERS US1 ON US1.ID = PR.CREATED_BY'
  +' LEFT JOIN TB_USERS US2 ON US2.ID = PR.CHANGED_BY'
  +' WHERE PR.ID IS NOT NULL ';

  { TProducerModel }

constructor TProducerModel.Create;
begin
  Self.FDB := TSrvDatabase.Create;
  Self.FDB.connect;
  Self.FDB.initDataSource(Self.FDS, Self.FQry);
end;

procedure TProducerModel.delete;
var
  vQry: TFDQuery;
begin
  if (FProducer = nil) then
    raise Exception.Create('Produtor não encontado!');

  Self.FDB.initQuery(vQry);
  try
    vQry.sql.Text := 'DELETE FROM TB_PRODUCERS WHERE ID = :id;';
    vQry.ParamByName('id').AsInteger := FProducer.id;
    try
      vQry.ExecSQL;
    except
      on E: Exception do
        raise E;
    end;
  finally
    FreeAndNil(vQry);
    FreeAndNil(FProducer);
  end;
end;

destructor TProducerModel.Destroy;
begin
  FreeAndNil(Self.FDS);
  FreeAndNil(Self.FQry);
  FreeAndNil(Self.FDB);

  Self.freeProducer;

  inherited;
end;

procedure TProducerModel.findAll(AQuery: string);
var
  vSql: string;
begin
  if (FDS = nil) or (FQry = nil) then
    exit;

  FQry.Active := False;
  vSql := cFullSql;

  if (AQuery <> EmptyStr) then
  begin
    vSql := vSql + ' AND ('
	  +' UPPER(PR."NAME")LIKE UPPER('+ QuotedStr('%' + UpperCase(AQuery) + '%')+')'
    +' OR UPPER(PR.DOCUMENT)LIKE UPPER('+ QuotedStr('%' + UpperCase(AQuery) + '%')+')'
    +' OR UPPER(PR.EMAIL)LIKE UPPER('+ QuotedStr('%' + UpperCase(AQuery) + '%')+')'
    +' OR UPPER(PR.PHONE)LIKE UPPER('+ QuotedStr('%' + UpperCase(AQuery) + '%')+')'
    +' ) ';
  end;

  vSql := vSql + ' ORDER BY PR."NAME", PR.ID ASC;';
  FQry.sql.Text := vSql;
  FQry.Active := True;
end;

procedure TProducerModel.freeProducer;
begin
  if (FProducer <> nil) then
    FreeAndNil(FProducer);
end;

procedure TProducerModel.getById(AId: Integer);
var
  vQry: TFDQuery;
begin
  if(Self.FProducer <> nil)then
    FreeAndNil(Self.FProducer);

  Self.FDB.initQuery(vQry);
  try
    vQry.sql.Text := cFullSql + ' AND PR.ID = :ID;';
    vQry.ParamByName('ID').AsInteger := AId;
    try
      vQry.Open;
      if(not vQry.IsEmpty)then
      begin
        Self.FProducer := TProducer.Create;
        Self.FProducer.id := vQry.FieldByName('ID').AsInteger;
        Self.FProducer.name := vQry.FieldByName('NAME').AsString;
        Self.FProducer.document := vQry.FieldByName('DOCUMENT').AsString;
        Self.FProducer.email := vQry.FieldByName('EMAIL').AsString;
        Self.FProducer.phone := vQry.FieldByName('PHONE').AsString;
        Self.FProducer.createdAt := vQry.FieldByName('CREATED_AT').AsDateTime;
        Self.FProducer.changedAt := vQry.FieldByName('CHANGED_AT').AsDateTime;

        Self.FProducer.createdBy := TUser.Create;
        Self.FProducer.createdBy.id := vQry.FieldByName('CREATED_BY').AsInteger;
        Self.FProducer.createdBy.username := vQry.FieldByName('CREATED_BY_NAME').AsString;

        Self.FProducer.changedBy := TUser.Create;
        Self.FProducer.changedBy.id := vQry.FieldByName('CHANGED_BY').AsInteger;
        Self.FProducer.changedBy.username := vQry.FieldByName('CHANGED_BY_NAME').AsString;
      end;
    except
      on E: Exception do
        raise E;
    end;
  finally
    FreeAndNil(vQry);
  end;
end;

procedure TProducerModel.save;
var
  vQry: TFDQuery;
begin
  if (FProducer = nil) then
    raise Exception.Create('Produtor não encontado!');

  Self.FDB.initQuery(vQry);
  try
    vQry.sql.Text := 'INSERT INTO TB_PRODUCERS("NAME",DOCUMENT,PHONE,EMAIL,CREATED_BY) VALUES (:NAME,:DOCUMENT,:PHONE,:EMAIL,:CREATED_BY);';
    vQry.ParamByName('NAME').AsString := FProducer.name;
    vQry.ParamByName('DOCUMENT').AsString := FProducer.document;
    vQry.ParamByName('PHONE').AsString := FProducer.phone;
    vQry.ParamByName('EMAIL').AsString := FProducer.email;
    vQry.ParamByName('CREATED_BY').AsInteger := FProducer.createdBy.id;
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

procedure TProducerModel.update;
var
  vQry: TFDQuery;
begin
  if (FProducer = nil) then
    raise Exception.Create('Produtor não encontado!');

  Self.FDB.initQuery(vQry);
  try
    vQry.sql.Text := 'UPDATE TB_PRODUCERS SET'
    +' "NAME" = :NAME,'
    +' DOCUMENT = :DOCUMENT,'
    +' PHONE = :PHONE,'
    +' EMAIL = :EMAIL,'
    +' CHANGED_BY = :CHANGED_BY,'
    +' CHANGED_AT = CURRENT_TIMESTAP'
    +' WHERE ID = :ID;';
    vQry.ParamByName('ID').AsInteger := FProducer.id;
    vQry.ParamByName('NAME').AsString := FProducer.name;
    vQry.ParamByName('DOCUMENT').AsString := FProducer.document;
    vQry.ParamByName('PHONE').AsString := FProducer.phone;
    vQry.ParamByName('EMAIL').AsString := FProducer.email;
    vQry.ParamByName('CHANGED_BY').AsInteger := FProducer.changedBy.id;
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
