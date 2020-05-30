unit uFrmManual;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.FileCtrl, Vcl.OleCtrls, SHDocVw, Vcl.Buttons;

type
  TFrmManual = class(TForm)
    PnlFull: TPanel;
    Panel1: TPanel;
    Label1: TLabel;
    WebBrowser1: TWebBrowser;
    Panel2: TPanel;
    SpeedButton1: TSpeedButton;
    procedure FormShow(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
  private
    { Private declarations }
  public
    procedure goToHome;
    { Public declarations }
  end;

var
  FrmManual: TFrmManual;

implementation

{$R *.dfm}

procedure TFrmManual.FormShow(Sender: TObject);
begin
  goToHome;
end;

procedure TFrmManual.goToHome;
var
  vUrl: string;
begin
  vUrl := 'file:///' + GetCurrentDir + '/../docs/manual/index.html';
  WebBrowser1.Navigate(vUrl);
end;

procedure TFrmManual.SpeedButton1Click(Sender: TObject);
begin
  goToHome;
end;

end.
