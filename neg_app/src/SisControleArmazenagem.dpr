program SisControleArmazenagem;

uses
  Vcl.Forms,
  uFrmMain in 'forms\uFrmMain.pas' {FrmMain},
  uFrmProducer in 'forms\uFrmProducer.pas' {FrmProducer},
  uFrmGrain in 'forms\uFrmGrain.pas' {FrmGrain},
  uFrmContract in 'forms\uFrmContract.pas' {FrmContract},
  uFrmManual in 'forms\uFrmManual.pas' {FrmManual},
  uFrmAbout in 'forms\uFrmAbout.pas' {FrmAbout},
  uMdlContract in 'models\uMdlContract.pas',
  uMdlGrain in 'models\uMdlGrain.pas',
  uMdlProducer in 'models\uMdlProducer.pas',
  uSrvAPI in 'services\uSrvAPI.pas',
  uSrvDatabase in 'services\uSrvDatabase.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.Title := ':: Sistema de Controle de Armazenagem de Grãos ::';
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmMain, FrmMain);
  Application.CreateForm(TFrmManual, FrmManual);
  Application.CreateForm(TFrmAbout, FrmAbout);
  Application.Run;

end.
