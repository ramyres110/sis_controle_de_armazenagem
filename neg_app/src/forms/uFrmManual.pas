unit uFrmManual;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.FileCtrl, Vcl.OleCtrls, SHDocVw;

type
  TFrmManual = class(TForm)
    PnlFull: TPanel;
    Panel1: TPanel;
    Label1: TLabel;
    WebBrowser1: TWebBrowser;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmManual: TFrmManual;

implementation

{$R *.dfm}

procedure TFrmManual.FormShow(Sender: TObject);
var
  vUrl: string;
begin
  vUrl := 'file:///'+GetCurrentDir+'/../docs/manual/index.html';
  WebBrowser1.Navigate(vUrl);
end;

end.
