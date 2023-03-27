unit dlgPref;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls,
  Vcl.ExtCtrls,
  Vcl.Samples.Spin, System.ImageList, Vcl.ImgList, Vcl.VirtualImageList,
  Vcl.BaseImageCollection, Vcl.ImageCollection;

type
  TPref = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    edtMembership: TEdit;
    Label2: TLabel;
    FileOpenDialog: TFileOpenDialog;
    btnClose: TButton;
    Label1: TLabel;
    edtGold: TEdit;
    btnGold: TButton;
    sedtMaxAllowToPick: TSpinEdit;
    Label3: TLabel;
    Label4: TLabel;
    edtSilver: TEdit;
    Label5: TLabel;
    edtBronze: TEdit;
    ImageCollection1: TImageCollection;
    VirtualImageList1: TVirtualImageList;
    btnSilver: TButton;
    btnBronze: TButton;
    btnMembership: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnPodiumCertifClick(Sender: TObject);
    procedure btnMemshipClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
    fSectionName: string;

    // P R E F E R E N C E   F I L E   A C C E S S .
    procedure ReadPreferences(iniFileName: string);
    procedure WritePreferences(iniFileName: string);

  public
    { Public declarations }
  end;

var
  Pref: TPref;

implementation

{$R *.dfm}

uses
  IniFiles, SCMUtility, System.UITypes;

{ TPref }

procedure TPref.btnPodiumCertifClick(Sender: TObject);
var
  s: string;
  i: integer;
begin
  i := (Sender as TButton).Tag;
  case i of
    1:
      s := ExtractFilePath(edtGold.Text);
    2:
      s := ExtractFilePath(edtSilver.Text);
    3:
      s := ExtractFilePath(edtBronze.Text);
  end;
  s := ExtractFilePath(edtGold.Text);
  FileOpenDialog.DefaultFolder := s;
  if FileOpenDialog.Execute then
  begin
    case i of
      1:
        edtGold.Text := FileOpenDialog.FileName;
      2:
        edtSilver.Text := FileOpenDialog.FileName;
      3:
        edtBronze.Text := FileOpenDialog.FileName;
    end;
  end;
end;

procedure TPref.btnMemshipClick(Sender: TObject);
var
  s: string;
begin
  s := ExtractFilePath(edtMembership.Text);
  FileOpenDialog.DefaultFolder := s;
  if FileOpenDialog.Execute then
  begin
    edtMembership.Text := FileOpenDialog.FileName;
  end;
end;

procedure TPref.btnCloseClick(Sender: TObject);
begin
  ModalResult := mrOk;
end;

procedure TPref.FormCreate(Sender: TObject);
var
  iniFileName: string;

begin
  fSectionName := 'MoreReports';

  // read from preference file
  iniFileName := GetSCMPreferenceFileName();
  if FileExists(iniFileName) then
    ReadPreferences(iniFileName)
  else
  begin
    // SCM SYSTEM ERROR : The preference file couldn't be created.
    MessageDlg('An unexpected SCM error occurred.' + sLineBreak +
      'Unable to read SCM_MoreReportsPref.ini.', mtError, [mbOk], 0);
  end;
end;

procedure TPref.FormDestroy(Sender: TObject);
var
  iniFileName: string;
begin
  // write out values
  iniFileName := GetSCMPreferenceFileName();
  if FileExists(iniFileName) then
    WritePreferences(iniFileName);
end;

procedure TPref.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
    ModalResult := mrCancel;
end;

procedure TPref.ReadPreferences(iniFileName: string);
var
  iFile: TIniFile;
begin
  iFile := TIniFile.create(iniFileName);
  edtGold.Text := iFile.ReadString(fSectionName, 'CustRptCertifGOLD', '');
  edtSilver.Text := iFile.ReadString(fSectionName, 'CustRptCertifSILVER', '');
  edtBronze.Text := iFile.ReadString(fSectionName, 'CustRptCertifBRONZE', '');
  edtMembership.Text := iFile.ReadString(fSectionName, 'CustRptMemShip', '');
  sedtMaxAllowToPick.Value := iFile.ReadInteger(fSectionName,
    'MaxAllowToPick', 20);
  iFile.Free;
end;

procedure TPref.WritePreferences(iniFileName: string);
var
  iFile: TIniFile;
begin
  iFile := TIniFile.create(iniFileName);
  iFile.WriteInteger(fSectionName, 'MaxAllowToPick',
    sedtMaxAllowToPick.Value);
  iFile.WriteString(fSectionName, 'CustRptCertifGOLD', edtGold.Text);
  iFile.WriteString(fSectionName, 'CustRptCertifSILVER', edtSilver.Text);
  iFile.WriteString(fSectionName, 'CustRptCertifBRONZE', edtBronze.Text);
  iFile.WriteString(fSectionName, 'CustRptMemShip', edtMembership.Text);
  iFile.Free;
end;

end.
