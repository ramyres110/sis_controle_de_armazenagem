unit uSrvDatabase;

interface

uses FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error,
  FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool,
  FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.IBBase, FireDAC.Phys.FB,
  Data.DB, FireDAC.Comp.Client, FireDAC.VCLUI.Wait, FireDAC.Comp.UI, System.Classes;

type
  TSrvDatabase = class(TComponent)
    FDConnection: TFDConnection;
    FDPhysFBDriverLink: TFDPhysFBDriverLink;
    FDGUIxWaitCursor: TFDGUIxWaitCursor;
  public
    constructor Create;
    destructor Destroy;

    procedure connect;
    procedure initQuery(var qry: TFDQuery);
    procedure initDataSource(var ds: TDataSource; var qry: TFDQuery);

    property connection: TFDConnection read FDConnection;
  end;

implementation

uses
  System.SysUtils;

{ TSrvDatabase }

procedure TSrvDatabase.connect;
begin
  FDConnection.Open();
end;

constructor TSrvDatabase.Create;
const
  cDatabaseName = 'DATABASE.FDB';
var
  vDatabasePath: string;
begin
  FDPhysFBDriverLink := TFDPhysFBDriverLink.Create(Self);
  FDGUIxWaitCursor := TFDGUIxWaitCursor(Self);
  FDConnection := TFDConnection.Create(Self);

  FDPhysFBDriverLink.VendorLib := 'fbclient.dll';
  vDatabasePath := GetCurrentDir() + '\..\data\' + cDatabaseName;
  with FDConnection do
  begin
    with Params do
    begin
      Clear;
      Add('DriverID=FB');
      Add('Server=localhost');
      Add('Database=' + vDatabasePath);
      Add('User_Name=sysdba');
      Add('Password=masterkey');
    end;
  end;

  Self.connect;
end;

destructor TSrvDatabase.Destroy;
begin
  FreeAndNil(FDConnection);
  FreeAndNil(FDGUIxWaitCursor);
  FreeAndNil(FDPhysFBDriverLink);
end;

procedure TSrvDatabase.initDataSource(var ds: TDataSource; var qry: TFDQuery);
begin
  if qry = nil then
  begin
    Self.initQuery(qry);
  end;
  ds := TDataSource.Create(nil);
  ds.DataSet := qry;
end;

procedure TSrvDatabase.initQuery(var qry: TFDQuery);
begin
  qry := TFDQuery.Create(nil);
  qry.connection := Self.FDConnection;
  qry.SQL.Clear;
end;

end.
