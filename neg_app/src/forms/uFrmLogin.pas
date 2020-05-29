unit uFrmLogin;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Buttons, uMdlUser, dxGDIPlusClasses;

type
  TFrmLogin = class(TForm)
    EdUsername: TLabeledEdit;
    EdPassword: TLabeledEdit;
    PnlFull: TPanel;
    Panel1: TPanel;
    BtnLogin: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Panel2: TPanel;
    LblInfo: TLabel;
    SpBtnAbout: TSpeedButton;
    SpBtnManual: TSpeedButton;
    LblLoginError: TLabel;
    Image1: TImage;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure SpBtnManualClick(Sender: TObject);
    procedure SpBtnAboutClick(Sender: TObject);
    procedure BtnLoginClick(Sender: TObject);
    procedure EdUsernameKeyPress(Sender: TObject; var Key: Char);
    procedure EdPasswordKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    FUserLoggedId: Integer;

    procedure login;
  public
    { Public declarations }
    property userLoggedId: Integer read FUserLoggedId;
  end;

var
  FrmLogin: TFrmLogin;

implementation

{$R *.dfm}

uses uFrmManual, uFrmAbout;

procedure TFrmLogin.BtnLoginClick(Sender: TObject);
begin
  Self.login;
end;

procedure TFrmLogin.EdPasswordKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = #13) then
  begin
    Self.login;
  end;
end;

procedure TFrmLogin.EdUsernameKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = #13) then
  begin
    Self.login;
  end;
end;

procedure TFrmLogin.FormCreate(Sender: TObject);
begin
  Self.Caption := Application.Title;
  Self.ModalResult := -1;
  Self.FUserLoggedId := -1;
  LblInfo.Caption := '© 2020 -‎1.0.0';
end;

procedure TFrmLogin.FormShow(Sender: TObject);
begin
  EdUsername.SetFocus;
end;

procedure TFrmLogin.login;
begin
  if (EdUsername.Text = '') or (EdPassword.Text = '') then
  begin
    LblLoginError.Visible := True;
    exit;
  end;
  LblLoginError.Visible := False;
  Self.FUserLoggedId := TUserModel.validateLogin(EdUsername.Text, EdPassword.Text);
  if (Self.FUserLoggedId > 0) then
  begin
    ModalResult := Self.FUserLoggedId;
    CloseModal;
  end
  else
  begin
    LblLoginError.Visible := True;
  end;
end;

procedure TFrmLogin.SpBtnAboutClick(Sender: TObject);
begin
  FrmAbout := TFrmAbout.Create(Self);
  try
    FrmAbout.ShowModal();
  finally
    FrmAbout.Free;
  end;
end;

procedure TFrmLogin.SpBtnManualClick(Sender: TObject);
begin
  FrmManual := TFrmManual.Create(Self);
  try
    FrmManual.ShowModal();
  finally
    FrmManual.Free;
  end;
end;

end.
