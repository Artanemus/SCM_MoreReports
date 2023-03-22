unit dlgDesignCertif;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
  Vcl.VirtualImage, Vcl.BaseImageCollection, Vcl.ImageCollection, dmSCM, dmRPTS,
  Vcl.ExtDlgs, FireDAC.Stan.Param;

type
  TDesignCertif = class(TForm)
    ImageCollection1: TImageCollection;
    vimgGold: TVirtualImage;
    vimgSilver: TVirtualImage;
    vimgBronze: TVirtualImage;
    Label1: TLabel;
    procedure btnCloseClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure vimgGoldClick(Sender: TObject);
    procedure vimgSilverClick(Sender: TObject);
    procedure vimgBronzeClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    fdefaultStyleName: string;
    fDoPodiumDesign: boolean;
    fSessionID: integer;
    procedure GoDesignReport(pick: integer);
  public
    { Public declarations }
    property doPodiumDesign: boolean read fDoPodiumDesign write fDoPodiumDesign;
    property SessionID: integer read fSessionID write fSessionID;
  end;

var
  DesignCertif: TDesignCertif;

implementation

{$R *.dfm}

uses Vcl.themes, Data.DB, Utility, IniFiles;

procedure TDesignCertif.btnCloseClick(Sender: TObject);
begin
  ModalResult := mrOk;
end;

procedure TDesignCertif.FormCreate(Sender: TObject);
begin
  // store the current theme
  if Assigned(TStyleManager.ActiveStyle) then
    fdefaultStyleName := TStyleManager.ActiveStyle.Name;
  fDoPodiumDesign := false;
  fSessionID := 0;
  // TODO: mode - preview prepared reports - hide virt-images that have no records.

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

procedure TDesignCertif.FormShow(Sender: TObject);
begin
  if Assigned(SCM) AND Assigned(RPTS) then
  begin
    if fDoPodiumDesign then
    begin
      Caption := 'Podium Certificates - DESIGN.';
      Label1.Caption := 'Click the report icon to run the report designer.';
    end
    else
    begin
      // Caption
      Caption := 'Podium Certificates - Preview, print and export.';
      Label1.Caption := 'Click the report icon to review, print or export.';
      // Message line
      if RPTS.qryPodiumGold.IsEmpty then
        vimgGold.ImageIndex := 3;
      if RPTS.qryPodiumSilver.IsEmpty then
        vimgSilver.ImageIndex := 3;
      if RPTS.qryPodiumBronze.IsEmpty then
        vimgBronze.ImageIndex := 3;
    end;
  end;
end;

procedure TDesignCertif.GoDesignReport(pick: integer);
var
  iniFileName: string;
  iFile: TIniFile;
begin
  Hide;
  // set style to default - designer looks better.
  if Assigned(TStyleManager.ActiveStyle) and
    (TStyleManager.ActiveStyle.Name <> 'Windows') then
  begin
    TStyleManager.TrySetStyle('Windows');
  end;
  case pick of
    1:
      RPTS.frxRptGold.DesignReport(True);
    2:
      RPTS.frxRptSilver.DesignReport(True);
    3:
      RPTS.frxRptBronze.DesignReport(True);
  end;

  // ----------------------------------------------
  // Update Customization filename
  // ----------------------------------------------
  iniFileName := GetSCMPreferenceFileName();
  if FileExists(iniFileName) then
  begin
    iFile := TIniFile.create(iniFileName);
    case pick of
      1:
        iFile.WriteString(IniSectionName, 'CustRptCertifGOLD',
          RPTS.frxRptGold.FileName);
      2:
        iFile.WriteString(IniSectionName, 'CustRptCertifSILVER',
          RPTS.frxRptSilver.FileName);
      3:
        iFile.WriteString(IniSectionName, 'CustRptMemShip',
          RPTS.frxRptBronze.FileName);
    end;
    iFile.free;
  end;

  // restore theme
  if Assigned(TStyleManager.ActiveStyle) then
    TStyleManager.TrySetStyle(fdefaultStyleName);
  Show;
  SetFocus;
end;

procedure TDesignCertif.vimgBronzeClick(Sender: TObject);
begin
  if (not Assigned(SCM)) or (not Assigned(RPTS)) then
    exit;
  if fDoPodiumDesign then
    GoDesignReport(3)
  else
  begin
    if RPTS.qryPodiumBronze.IsEmpty then
      exit;
    RPTS.frxRptBronze.ShowReport();
  end;
end;

procedure TDesignCertif.vimgGoldClick(Sender: TObject);
begin
  if (not Assigned(SCM)) OR (not Assigned(RPTS)) then
    exit;
  if fDoPodiumDesign then
    GoDesignReport(1)
  else
  begin
    if RPTS.qryPodiumGold.IsEmpty then
      exit;
    RPTS.frxRptGold.ShowReport();
  end;
end;

procedure TDesignCertif.vimgSilverClick(Sender: TObject);
begin
  if (not Assigned(SCM)) or (not Assigned(RPTS)) then
    exit;
  if fDoPodiumDesign then
    GoDesignReport(2)
  else
  begin
    if RPTS.qryPodiumSilver.IsEmpty then
      exit;
    RPTS.frxRptSilver.ShowReport();
  end;
end;

end.
