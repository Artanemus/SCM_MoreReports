program SCM_MoreReports;

uses
  Vcl.Forms,
  frmMain in 'frmMain.pas' {Main},
  dlgAbout in 'dlgAbout.pas' {About},
  dmSCM in 'dmSCM.pas' {SCM: TDataModule},
  Vcl.Themes,
  Vcl.Styles,
  dmRPTS in 'dmRPTS.pas' {RPTS: TDataModule},
  dlgMembership in 'dlgMembership.pas' {Membership},
  dlgPickMember in 'dlgPickMember.pas' {PickMember},
  dlgPickCertif in 'dlgPickCertif.pas' {PickCertif},
  dlgDesignCertif in 'dlgDesignCertif.pas' {DesignCertif},
  dlgPref in 'dlgPref.pas' {Pref},
  SCMUtility in '..\SCM_SHARED\SCMUtility.pas',
  exeinfo in '..\SCM_SHARED\exeinfo.pas',
  dlgBasicLogin in '..\SCM_SHARED\dlgBasicLogin.pas' {BasicLogin},
  SCMSimpleConnect in '..\SCM_SHARED\SCMSimpleConnect.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'SCM_MoreReports';
  TStyleManager.TrySetStyle('Windows10 SlateGray');
  Application.CreateForm(TMain, Main);
  Application.Run;
end.
