unit dlgDesignCertif;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
  Vcl.VirtualImage, Vcl.BaseImageCollection, Vcl.ImageCollection, dmSCM, dmRPTS,
  Vcl.ExtDlgs;

type
  TDesignCertif = class(TForm)
    ImageCollection1: TImageCollection;
    VirtualImage1: TVirtualImage;
    VirtualImage2: TVirtualImage;
    VirtualImage3: TVirtualImage;
    btnBkgrdGold: TButton;
    btnBkgrdSilver: TButton;
    btnBkgrdBronze: TButton;
    Panel1: TPanel;
    btnClose: TButton;
    btnDesignReport: TButton;
    OpenPictureDialog1: TOpenPictureDialog;
    procedure btnCloseClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnDesignReportClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnBkgrdGoldClick(Sender: TObject);
  private
    { Private declarations }
    fdefaultStyleName: string;
  public
    { Public declarations }
  end;

var
  DesignCertif: TDesignCertif;

implementation

{$R *.dfm}

uses vcl.themes;

procedure TDesignCertif.btnBkgrdGoldClick(Sender: TObject);
begin
  OpenPictureDialog1.Execute;
end;

procedure TDesignCertif.btnCloseClick(Sender: TObject);
begin
  ModalResult := mrOk;
end;

procedure TDesignCertif.btnDesignReportClick(Sender: TObject);
begin
  if Assigned(SCM) and Assigned(RPTS) then
  begin
    Hide;
    // set style to default - designer looks better.
    if Assigned(TStyleManager.ActiveStyle) and
      (TStyleManager.ActiveStyle.Name <> 'Windows') then
    begin
      TStyleManager.TrySetStyle('Windows');
    end;
    // assert that all is connected ...
    if not Assigned(RPTS.qryPodiumWinners.Connection) then
      RPTS.qryPodiumWinners.Connection := SCM.scmConnection;
    if not RPTS.qryPodiumWinners.Active then
       RPTS.qryPodiumWinners.Open;
    // go design the report
    RPTS.frxRptPodium.DesignReport(True);
    // restore theme
    if Assigned(TStyleManager.ActiveStyle) then
      TStyleManager.TrySetStyle(fdefaultStyleName);
    Show;
    SetFocus;
  end;
end;

procedure TDesignCertif.FormCreate(Sender: TObject);
begin
  // store the current theme
  if Assigned(TStyleManager.ActiveStyle) then
    fdefaultStyleName := TStyleManager.ActiveStyle.Name;

end;

procedure TDesignCertif.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
  begin
    ModalResult := mrOk;
    Key := 0;
  end;
end;

end.
