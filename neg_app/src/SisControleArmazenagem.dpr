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
  uFrmLogin in 'forms\uFrmLogin.pas' {FrmLogin},
  uUtlCrypto in 'utils\uUtlCrypto.pas',
  uEntUser in 'entities\uEntUser.pas',
  uEntProducer in 'entities\uEntProducer.pas',
  uEntGeneric in 'entities\uEntGeneric.pas',
  uEntGrain in 'entities\uEntGrain.pas',
  uEntStorage in 'entities\uEntStorage.pas',
  uEntContract in 'entities\uEntContract.pas',
  uFrmUser in 'forms\uFrmUser.pas' {FrmUser},
  uFrmStorage in 'forms\uFrmStorage.pas' {FrmStorage},
  uUtlAlert in 'utils\uUtlAlert.pas',
  uUtlGrid in 'utils\uUtlGrid.pas',
  uUtlInputFields in 'utils\uUtlInputFields.pas',
  uUtlForm in 'utils\uUtlForm.pas',
  uUtlCalculator in 'utils\uUtlCalculator.pas';

{$R *.res}

begin
{$IFDEF DEBUG}
  ReportMemoryLeaksOnShutdown := DebugHook <> 0;
{$ENDIF}

  Application.Initialize;
  Application.Title := 'Sistema de Controle de Armazenagem de Grãos';
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmMain, FrmMain);
  Application.Run;

end.
