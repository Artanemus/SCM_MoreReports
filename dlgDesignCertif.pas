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
  private
    { Private declarations }
    fdefaultStyleName: string;
    fdoDesign: boolean;
    fSessionID: integer;
  public
    { Public declarations }
  end;

var
  DesignCertif: TDesignCertif;

implementation

{$R *.dfm}

uses Vcl.themes;

procedure TDesignCertif.btnCloseClick(Sender: TObject);
begin
  ModalResult := mrOk;
end;

procedure TDesignCertif.FormCreate(Sender: TObject);
begin
  // store the current theme
  if Assigned(TStyleManager.ActiveStyle) then
    fdefaultStyleName := TStyleManager.ActiveStyle.Name;
  fdoDesign := false;
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

procedure TDesignCertif.vimgGoldClick(Sender: TObject);
begin
  if not Assigned(SCM) then
    exit;
  if not Assigned(RPTS) then
    exit;

  if fdoDesign then
  begin
    if fSessionID = 0 then
      exit;
//    Hide;
    // set style to default - designer looks better.
    if Assigned(TStyleManager.ActiveStyle) and
      (TStyleManager.ActiveStyle.Name <> 'Windows') then
    begin
      TStyleManager.TrySetStyle('Windows');
    end;
    // assert that all is connected ...
    // TODO: move into RPTS module
    if not Assigned(RPTS.qryPodiumGold.Connection) then
      RPTS.qryPodiumGold.Connection := SCM.scmConnection;
    if not RPTS.qryPodiumGold.Active then
      RPTS.qryPodiumGold.Close;
    // need valid data to preview report during design mode.
    RPTS.qryPodiumGold.ParamByName('SESSIONID').AsInteger := fSessionID;
    RPTS.qryPodiumGold.Prepare;
    RPTS.qryPodiumGold.Open;
    if RPTS.qryPodiumGold.Active then
    begin
      // go design the report
      RPTS.frxRptGold.DesignReport(True);
    end;
    // restore theme
    if Assigned(TStyleManager.ActiveStyle) then
      TStyleManager.TrySetStyle(fdefaultStyleName);
//    Show;
//    SetFocus;
  end
  else
  begin
    RPTS.frxRptGold.ShowReport();
  end;
end;

end.
