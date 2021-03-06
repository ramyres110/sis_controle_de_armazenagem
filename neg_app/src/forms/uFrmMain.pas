unit uFrmMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, Vcl.ExtCtrls, Vcl.Buttons, Vcl.StdCtrls, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Phys.IBBase,
  FireDAC.Phys.FB, Data.DB, FireDAC.Comp.Client, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.VCLUI.Wait, FireDAC.Comp.UI, uFrmLogin, uEntUser, uMdlUser, uFrmUser, uFrmStorage, uMdlContract, uEntContract, uCmpPanelContract,
  IPPeerClient, REST.Client, Data.Bind.Components, Data.Bind.ObjectScope, dxGDIPlusClasses, uSrvAPI, System.Generics.Collections;

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
    ScBxInitialScale: TScrollBox;
    ScBxMoisture: TScrollBox;
    ScBxFinalScale: TScrollBox;
    ScBxFinalized: TScrollBox;
    Panel1: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    PnlTotalInitialScale: TPanel;
    PnlTotalMoisture: TPanel;
    PnlTotalFinalScale: TPanel;
    PnlTotalFinalized: TPanel;
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
    BtnFilterDone: TSpeedButton;
    Image1: TImage;
    LblFooterMsg: TLabel;
    TimerCheckValidation: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Sair1Click(Sender: TObject);
    procedure RegistrodeProdutor1Click(Sender: TObject);
    procedure RegistrodeGros1Click(Sender: TObject);
    procedure NovoContrato1Click(Sender: TObject);
    procedure Contratos1Click(Sender: TObject);
    procedure Manual1Click(Sender: TObject);
    procedure Sobre1Click(Sender: TObject);
    procedure BtnFilterDoneClick(Sender: TObject);
    procedure Usurio1Click(Sender: TObject);
    procedure ArmazmSilo1Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure BtnNewClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure scrollBoxWheelDown(Sender: TObject; Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
    procedure scrollBoxWheelUp(Sender: TObject; Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
    procedure TimerCheckValidationTimer(Sender: TObject);
  private
    { Private declarations }
    FUserLogged: TUser;
    FContractModel: TContractModel;
    FContractList: TObjectList<TContract>;

    FTotalInitialScale: Integer;
    FTotalMoisture: Integer;
    FTotalFinalScale: Integer;
    FTotalFinalized: Integer;

    FCheckThread: TThread;
    FCheckThreadLocked: Boolean;

    procedure init;
    procedure loadUserInfo(AUserId: Integer);

    procedure newContract;
    procedure clearContracts;

    procedure runCheckValidations;

    procedure onPanelUpdate(Sender: TObject);

    procedure incrementTotal(const APnl: TPanel; var ATotal: Integer);
    function getContractList: TObjectList<TContract>;
  public
    { Public declarations }
    procedure loadContracts;

    property userLogged: TUser read FUserLogged;
    property contractList: TObjectList<TContract> read getContractList;
    property checkThreadLocked: Boolean read FCheckThreadLocked write FCheckThreadLocked;
  end;

var
  FrmMain: TFrmMain;

implementation

{$R *.dfm}

uses uFrmProducer, uFrmGrain, uFrmContract, uFrmAbout, uFrmManual, uUtlInputFields;

procedure TFrmMain.Contratos1Click(Sender: TObject);
begin
  FrmContract := TFrmContract.Create(Self);
  try
    FrmContract.userLogged := FUserLogged;
    FrmContract.ShowModal();

    loadContracts;
  finally
    FrmContract.Free;
  end;
end;

procedure TFrmMain.FormCreate(Sender: TObject);
begin
  Caption := Application.Title;
  PnlFull.Visible := False;

  FContractModel := TContractModel.Create;
end;

procedure TFrmMain.FormDestroy(Sender: TObject);
begin
  if (FCheckThread <> nil) then
  begin
    FCheckThread.Terminate;
    FCheckThread.Free
  end;

  if (Self.FContractList <> nil) then
  begin
    FreeAndNil(Self.FContractList);
  end;

  if (Self.FUserLogged <> nil) then
  begin
    FreeAndNil(Self.FUserLogged);
  end;

  if (Self.FContractModel <> nil) then
  begin
    FreeAndNil(Self.FContractModel);
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

function TFrmMain.getContractList: TObjectList<TContract>;
begin
  Result := FContractList;
end;

procedure TFrmMain.incrementTotal(const APnl: TPanel; var ATotal: Integer);
begin
  inc(ATotal);
  APnl.Caption := IntToStr(ATotal);
end;

procedure TFrmMain.init();
begin
{$IFDEF DEBUG}
  TimerCheckValidation.Interval := 5000;
{$ELSE}
  TimerCheckValidation.Interval := 10000;
{$ENDIF}
  TimerCheckValidation.Enabled := True;

  FCheckThreadLocked := False;

  LblFooterMsg.Caption := '';
  PnlFull.Visible := True;

  Self.loadContracts;
end;

procedure TFrmMain.loadContracts;
var
  vPanelContract: TPanelContract;
  vContract: TContract;
begin
  clearContracts;
  FContractList := TObjectList<TContract>.Create;
  try
    TContractModel.loadList(FContractList);
    for vContract in FContractList do
    begin
      vPanelContract := TPanelContract.Create(Self);
      vPanelContract.contract := vContract;
      vPanelContract.userLogged := FUserLogged;
      vPanelContract.onUpdate := onPanelUpdate;

      if (vContract.initialWeight = 0) then
      begin
        vPanelContract.Parent := ScBxInitialScale;
        vPanelContract.colIndex := 0;
        Self.incrementTotal(PnlTotalInitialScale, FTotalInitialScale);
      end
      else if (vContract.moisturePercent = 0) then
      begin
        vPanelContract.Parent := ScBxMoisture;
        vPanelContract.colIndex := 1;
        Self.incrementTotal(PnlTotalMoisture, FTotalMoisture);
      end
      else if vContract.finalWeight = 0 then
      begin
        vPanelContract.Parent := ScBxFinalScale;
        vPanelContract.colIndex := 2;
        Self.incrementTotal(PnlTotalFinalScale, FTotalFinalScale);
      end
      else
      begin
        vPanelContract.Parent := ScBxFinalized;
        vPanelContract.colIndex := 3;
        Self.incrementTotal(PnlTotalFinalized, FTotalFinalized);
      end;

    end;
  finally
  end;
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
    FrmContract.userLogged := FUserLogged;
    FrmContract.ShowModal();

    loadContracts;
  finally
    FrmContract.Free;
  end;
end;

procedure TFrmMain.NovoContrato1Click(Sender: TObject);
begin
  Self.newContract;
end;

procedure TFrmMain.onPanelUpdate(Sender: TObject);
begin
  loadContracts;
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
    FrmProducer.userLogged := FUserLogged;
    FrmProducer.ShowModal();
  finally
    FrmProducer.Free;
  end;
end;

procedure TFrmMain.runCheckValidations;
begin
  if FCheckThreadLocked then
    Exit;

  if FCheckThread <> nil then
  begin
    FCheckThread.Terminate;
    FCheckThread.Free;
  end;

  FCheckThread := TThread.CreateAnonymousThread(
    procedure
    var
      vContract: TContract;
      vSomeTrue, vResult: Boolean;
      vList: TObjectList<TContract>;
    begin
      if (FrmMain = nil) then
        Exit;

      FrmMain.checkThreadLocked := True;

      TThread.Synchronize(TThread.CurrentThread,
        procedure
        begin
          FrmMain.LblFooterMsg.Caption := 'Verificando valida��es na API...';
        end);

      vList := TObjectList<TContract>.Create;
      try
        TContractModel.loadList(vList);
        for vContract in vList do
        begin
          if (vContract.isValidated) then
            Continue;

          if (vContract.externalId = EmptyStr) then
            Continue;

          vResult := TApi.GetContractValidation(vContract.externalId);
          if (vResult) then
          begin
            TContractModel.updateValidated(vContract.id, True, 'API');
            vSomeTrue := True;
          end;
        end;
      finally
        FreeAndNil(vList);
      end;

      TThread.Synchronize(TThread.CurrentThread,
        procedure
        begin
          if (vSomeTrue) then
            FrmMain.loadContracts;
          FrmMain.LblFooterMsg.Caption := '';
        end);

      FrmMain.checkThreadLocked := False;

    end);

  FCheckThread.FreeOnTerminate := False;
  FCheckThread.Start;
end;

procedure TFrmMain.Sair1Click(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TFrmMain.scrollBoxWheelDown(Sender: TObject; Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
begin
  checkAndFixMouseWheelOnSrollBox(ScBxInitialScale, -8, MousePos, Handled);
  checkAndFixMouseWheelOnSrollBox(ScBxMoisture, -8, MousePos, Handled);
  checkAndFixMouseWheelOnSrollBox(ScBxFinalScale, -8, MousePos, Handled);
  checkAndFixMouseWheelOnSrollBox(ScBxFinalized, -8, MousePos, Handled);
end;

procedure TFrmMain.scrollBoxWheelUp(Sender: TObject; Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
begin
  checkAndFixMouseWheelOnSrollBox(ScBxInitialScale, 8, MousePos, Handled);
  checkAndFixMouseWheelOnSrollBox(ScBxMoisture, 8, MousePos, Handled);
  checkAndFixMouseWheelOnSrollBox(ScBxFinalScale, 8, MousePos, Handled);
  checkAndFixMouseWheelOnSrollBox(ScBxFinalized, 8, MousePos, Handled);
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

procedure TFrmMain.TimerCheckValidationTimer(Sender: TObject);
begin
  Self.runCheckValidations;
end;

procedure TFrmMain.Usurio1Click(Sender: TObject);
begin
  FrmUser := TFrmUser.Create(Self);
  try
    FrmUser.userLogged := FUserLogged;
    FrmUser.ShowModal();
  finally
    FrmUser.Free;
  end;
end;

procedure TFrmMain.ArmazmSilo1Click(Sender: TObject);
begin
  FrmStorage := TFrmStorage.Create(Self);
  try
    FrmStorage.userLogged := FUserLogged;
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

procedure TFrmMain.Button1Click(Sender: TObject);
var
  vP: string;
begin
  vP := InputBox('Lan�ar Peso 1', 'Pesagem Inicial', '0');
end;

procedure TFrmMain.clearContracts;
var
  i: Integer;
begin
  FTotalInitialScale := 0;
  FTotalMoisture := 0;
  FTotalFinalScale := 0;
  FTotalFinalized := 0;

  PnlTotalInitialScale.Caption := IntToStr(FTotalInitialScale);
  PnlTotalMoisture.Caption := IntToStr(FTotalMoisture);
  PnlTotalFinalScale.Caption := IntToStr(FTotalFinalScale);
  PnlTotalFinalized.Caption := IntToStr(FTotalFinalized);

  if (FContractList <> nil) then
    FreeAndNil(FContractList);

  i := 0;
  while i < Self.ComponentCount do
  begin
    if Self.Components[i] is TPanelContract then
    begin
      Self.Components[i].Free;
      i := 0;
    end;
    inc(i);
  end;

end;

end.
