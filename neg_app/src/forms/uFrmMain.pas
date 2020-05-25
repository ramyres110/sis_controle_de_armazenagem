unit uFrmMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, Vcl.ExtCtrls, Vcl.Buttons, Vcl.StdCtrls, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Phys.IBBase,
  FireDAC.Phys.FB, Data.DB, FireDAC.Comp.Client, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.VCLUI.Wait, FireDAC.Comp.UI, uFrmLogin, uEntUser, uMdlUser, uFrmUser, uFrmStorage, uMdlContract, uEntContract;

type
  TFrmMain = class(TForm)
    MmMain: TMainMenu;
    Registros1: TMenuItem;
    Help1: TMenuItem;
    RegistrodeGros1: TMenuItem;
    RegistrodeProdutor1: TMenuItem;
    N1: TMenuItem;
    Sistema1: TMenuItem;
    Contratos1: TMenuItem;
    Manual1: TMenuItem;
    N2: TMenuItem;
    Sobre1: TMenuItem;
    Sair1: TMenuItem;
    N3: TMenuItem;
    NovoContrato1: TMenuItem;
    GridPanel1: TGridPanel;
    ScrollBox1: TScrollBox;
    ScrollBox2: TScrollBox;
    ScrollBox3: TScrollBox;
    ScrollBox4: TScrollBox;
    Panel1: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    Panel6: TPanel;
    Panel7: TPanel;
    Panel8: TPanel;
    Panel9: TPanel;
    Panel11: TPanel;
    Panel10: TPanel;
    SpeedButton3: TSpeedButton;
    Label1: TLabel;
    PpMnOption: TPopupMenu;
    Editar1: TMenuItem;
    Excluir1: TMenuItem;
    Button1: TButton;
    Panel16: TPanel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Panel17: TPanel;
    SpeedButton6: TSpeedButton;
    Label16: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Edit1: TEdit;
    BtnFilterDone: TSpeedButton;
    PpMnFilter: TPopupMenu;
    btnFilterToday: TMenuItem;
    btnFilterWeek: TMenuItem;
    btnFilterMonth: TMenuItem;
    btnFilterAll: TMenuItem;
    PnlFull: TPanel;
    Panel12: TPanel;
    LblUserInfo: TLabel;
    N4: TMenuItem;
    Usurio1: TMenuItem;
    ArmazmSilo1: TMenuItem;
    Panel2: TPanel;
    Label2: TLabel;
    BtnNew: TButton;
    procedure FormCreate(Sender: TObject);
    procedure Sair1Click(Sender: TObject);
    procedure RegistrodeProdutor1Click(Sender: TObject);
    procedure RegistrodeGros1Click(Sender: TObject);
    procedure NovoContrato1Click(Sender: TObject);
    procedure Contratos1Click(Sender: TObject);
    procedure Manual1Click(Sender: TObject);
    procedure Sobre1Click(Sender: TObject);
    procedure BtnFilterDoneClick(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Usurio1Click(Sender: TObject);
    procedure ArmazmSilo1Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure BtnNewClick(Sender: TObject);
  private
    { Private declarations }
    FUserLogged: TUser;

    procedure init;
    procedure loadUserInfo(AUserId: Integer);

    procedure newContract;
  public
    { Public declarations }
    property userLogged: TUser read FUserLogged;
  end;

var
  FrmMain: TFrmMain;

implementation

{$R *.dfm}

uses uFrmProducer, uFrmGrain, uFrmContract, uFrmAbout, uFrmManual;

procedure TFrmMain.Contratos1Click(Sender: TObject);
begin
  FrmContract := TFrmContract.Create(Self);
  try
    FrmContract.ShowModal();
  finally
    FrmContract.Free;
  end;
end;

procedure TFrmMain.FormCreate(Sender: TObject);
begin
  Caption := Application.Title;
  PnlFull.Visible := False;
end;

procedure TFrmMain.FormDestroy(Sender: TObject);
begin
  if (Self.FUserLogged <> nil) then
  begin
    FreeAndNil(Self.FUserLogged);
  end;
end;

procedure TFrmMain.FormShow(Sender: TObject);
begin
  FrmLogin := TFrmLogin.Create(Self);
  try
    FrmLogin.ShowModal();
    if (FrmLogin.userLoggedId > 0) then
    begin
      loadUserInfo(FrmLogin.userLoggedId);
      init();
    end;
  finally
    if (FrmLogin.userLoggedId < 0) then
    begin
      Application.Terminate;
    end;
    FrmLogin.Free;
  end;
end;

procedure TFrmMain.init();
begin
  PnlFull.Visible := True;
end;

procedure TFrmMain.loadUserInfo(AUserId: Integer);
begin
  TUserModel.loadUserById(AUserId, Self.FUserLogged);
  LblUserInfo.Caption := IntToStr(Self.FUserLogged.id) + ' - ' + Self.FUserLogged.username;
end;

procedure TFrmMain.Manual1Click(Sender: TObject);
begin
  FrmManual := TFrmManual.Create(Self);
  try
    FrmManual.ShowModal();
  finally
    FrmManual.Free;
  end;
end;

procedure TFrmMain.newContract;
begin
  FrmContract := TFrmContract.Create(Self);
  try
    FrmContract.Tag := 2; // Only Register
    FrmContract.ShowModal();
  finally
    FrmContract.Free;
  end;
end;

procedure TFrmMain.NovoContrato1Click(Sender: TObject);
begin
  Self.newContract;
end;

procedure TFrmMain.RegistrodeGros1Click(Sender: TObject);
begin
  FrmGrain := TFrmGrain.Create(Self);
  try
    FrmGrain.userLogged := FUserLogged;
    FrmGrain.ShowModal();
  finally
    FrmGrain.Free;
  end;
end;

procedure TFrmMain.RegistrodeProdutor1Click(Sender: TObject);
begin
  FrmProducer := TFrmProducer.Create(Self);
  try
    FrmProducer.ShowModal();
  finally
    FrmProducer.Free;
  end;

end;

procedure TFrmMain.Sair1Click(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TFrmMain.Sobre1Click(Sender: TObject);
begin
  FrmAbout := TFrmAbout.Create(Self);
  try
    FrmAbout.ShowModal();
  finally
    FrmAbout.Free;
  end;
end;

procedure TFrmMain.SpeedButton1Click(Sender: TObject);
begin
  Self.newContract;
end;

procedure TFrmMain.SpeedButton3Click(Sender: TObject);
var
  vPoint: TPoint;
begin
  vPoint := SpeedButton3.ClientToScreen(Point(0, SpeedButton3.Height));
  PpMnOption.Popup(vPoint.X, vPoint.Y);

end;

procedure TFrmMain.Usurio1Click(Sender: TObject);
begin
  FrmUser := TFrmUser.Create(Self);
  try
    FrmUser.ShowModal();
  finally
    FrmUser.Free;
  end;
end;

procedure TFrmMain.ArmazmSilo1Click(Sender: TObject);
begin
  FrmStorage := TFrmStorage.Create(Self);
  try
    FrmStorage.ShowModal();
  finally
    FrmStorage.Free;
  end;
end;

procedure TFrmMain.BtnFilterDoneClick(Sender: TObject);
var
  vPoint: TPoint;
begin
  vPoint := BtnFilterDone.ClientToScreen(Point(0, BtnFilterDone.Height));
  PpMnFilter.Popup(vPoint.X, vPoint.Y);
end;

procedure TFrmMain.BtnNewClick(Sender: TObject);
begin
  Self.newContract;
end;

end.
