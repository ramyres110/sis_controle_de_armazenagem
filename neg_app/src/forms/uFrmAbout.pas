unit uFrmAbout;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls;

type
  TFrmAbout = class(TForm)
    PnlFull: TPanel;
    Panel1: TPanel;
    Label1: TLabel;
    LblAbout: TLabel;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmAbout: TFrmAbout;

implementation

{$R *.dfm}

procedure TFrmAbout.FormShow(Sender: TObject);
var
  txt: string;
begin
  txt := ''+#13
  +'Sistem de Controle de Armazengem de Grãos'+#13+#13
  +'Fornecido por: DEVELOPER'+#13
  +'Desenvolvido por: DEVELOPER'+#13
  +'Resguardado Sobre: EULA'+#13+#13
  +'Versão: 1.0.0'+#13
  +'© 2020'+#13
  +'';
  LblAbout.Caption := txt;
end;

end.
