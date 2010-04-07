program LifeGL;

uses
  Forms, Math,
  uMainForm in 'uMainForm.pas' {MainForm},
  uResources in 'uResources.pas',
  CFunctions in 'CFunctions.pas',
  XDFUtils in 'XDFUtils.pas',
  uLifeSimulator in 'uLifeSimulator.pas',
  uHistoryDialog in 'uHistoryDialog.pas' {DLGHistory},
  uDLGPreferences in 'uDLGPreferences.pas' {DLGPreferences};

{$R *.res}

begin
  SetRoundMode(rmDown);
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'Life v3.0 by Glex';
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TDLGHistory, DLGHistory);
  Application.CreateForm(TDLGPreferences, DLGPreferences);
  Application.Run;
end.
