unit dlgPodiumPreview;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
  Vcl.VirtualImage, Vcl.BaseImageCollection, Vcl.ImageCollection, dmSCM, dmRPTS;

type
  TPodiumPreview = class(TForm)
    ImageCollection1: TImageCollection;
    VirtualImage1: TVirtualImage;
    VirtualImage2: TVirtualImage;
    VirtualImage3: TVirtualImage;
    btnPreviewBronze: TButton;
    btnPreviewSilver: TButton;
    btnPreviewGold: TButton;
    Panel1: TPanel;
    btnClose: TButton;
    procedure btnCloseClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnPreviewGoldClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  PodiumPreview: TPodiumPreview;

implementation

{$R *.dfm}

procedure TPodiumPreview.btnCloseClick(Sender: TObject);
begin
  ModalResult := mrOk;
end;

procedure TPodiumPreview.btnPreviewGoldClick(Sender: TObject);
begin
  if not Assigned(SCM)  then exit;
  if not Assigned(RPTS) then exit;
  RPTS.frxRptPodiumGold.ShowReport;
end;

procedure TPodiumPreview.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
  begin
    ModalResult := mrOk;
    Key := 0;
  end;
end;

end.
