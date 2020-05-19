unit uFrmMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, Vcl.ExtCtrls;

type
  TFrmMain = class(TForm)
    MainMenu1: TMainMenu;
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
    procedure FormCreate(Sender: TObject);
    procedure Sair1Click(Sender: TObject);
    procedure RegistrodeProdutor1Click(Sender: TObject);
    procedure RegistrodeGros1Click(Sender: TObject);
    procedure NovoContrato1Click(Sender: TObject);
    procedure Contratos1Click(Sender: TObject);
    procedure Manual1Click(Sender: TObject);
    procedure Sobre1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
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

procedure TFrmMain.NovoContrato1Click(Sender: TObject);
begin
  FrmContract := TFrmContract.Create(Self);
  try
    FrmContract.ShowModal();
  finally
    FrmContract.Free;
  end;
end;

procedure TFrmMain.RegistrodeGros1Click(Sender: TObject);
begin
  FrmGrain := TFrmGrain.Create(Self);
  try
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

end.
