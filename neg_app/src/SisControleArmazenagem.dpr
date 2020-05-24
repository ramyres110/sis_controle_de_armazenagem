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
  uSrvDatabase in 'services\uSrvDatabase.pas',
  uMdlUser in 'models\uMdlUser.pas',
  uMdlStorage in 'models\uMdlStorage.pas',
  uFrmLogin in 'forms\uFrmLogin.pas' {FrmLogin};

{$R *.res}

begin
{$IFDEF DEBUG}
  ReportMemoryLeaksOnShutdown := DebugHook <> 0;
{$ENDIF}

  Application.Initialize;
  Application.Title := 'Sistema de Controle de Armazenagem de Grãos';
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmLogin, FrmLogin);
  Application.CreateForm(TFrmMain, FrmMain);
  Application.Run;

end.
