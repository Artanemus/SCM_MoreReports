program SCM_MoreReports;

uses
  Vcl.Forms,
  frmMain in 'frmMain.pas' {Main},
  dlgBasicLogin in 'dlgBasicLogin.pas' {BasicLogin},
  Utility in 'Utility.pas',
  exeinfo in 'exeinfo.pas',
  dlgAbout in 'dlgAbout.pas' {About},
  dmSCM in 'dmSCM.pas' {SCM: TDataModule},
  Vcl.Themes,
  Vcl.Styles,
  dmRPTS in 'dmRPTS.pas' {RPTS: TDataModule},
  dlgMembership in 'dlgMembership.pas' {Membership},
  dlgPickMember in 'dlgPickMember.pas' {PickMember},
  dlgPodiumCertif in 'dlgPodiumCertif.pas' {PodiumCertif},
  dlgPodiumPreview in 'dlgPodiumPreview.pas' {PodiumPreview};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'SCM_MoreReports';
  TStyleManager.TrySetStyle('Windows10 SlateGray');
  Application.CreateForm(TMain, Main);
  Application.Run;
end.
