unit dlgPref;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls,
  Vcl.ExtCtrls,
  Vcl.Samples.Spin;

type
  TPref = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    edtCustRptMemShip: TEdit;
    Label2: TLabel;
    btnBrowseCustRptMemShip: TButton;
    FileOpenDialog: TFileOpenDialog;
    btnClose: TButton;
    Label1: TLabel;
    edtCustRptCertifGOLD: TEdit;
    btnBrowseCertifGOLD: TButton;
    sedtMaxAllowToPick: TSpinEdit;
    Label3: TLabel;
    Label4: TLabel;
    edtCustRptCertifSILVER: TEdit;
    Label5: TLabel;
    edtCustRptCertifBRONZE: TEdit;
    btnBrowseCertifSILVER: TButton;
    btnBrowseCertifBRONZE: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnBrowseCertifGOLDClick(Sender: TObject);
    procedure btnBrowseCustRptMemShipClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }

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
  IniFiles, Utility, System.UITypes;

{ TPref }

procedure TPref.btnBrowseCertifGOLDClick(Sender: TObject);
var
  s: string;
begin
  s := ExtractFilePath(edtCustRptCertifGOLD.Text);
  FileOpenDialog.DefaultFolder := s;
  if FileOpenDialog.Execute then
  begin
    edtCustRptCertifGOLD.Text := FileOpenDialog.FileName;
  end;
end;

procedure TPref.btnBrowseCustRptMemShipClick(Sender: TObject);
var
  s: string;
begin
  s := ExtractFilePath(edtCustRptMemShip.Text);
  FileOpenDialog.DefaultFolder := s;
  if FileOpenDialog.Execute then
  begin
    edtCustRptMemShip.Text := FileOpenDialog.FileName;
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
  edtCustRptCertifGOLD.Text := iFile.ReadString(IniSectionName,
    'CustRptCertifGOLD', '');
  edtCustRptCertifSILVER.Text := iFile.ReadString(IniSectionName,
    'CustRptCertifSILVER', '');
  edtCustRptCertifBRONZE.Text := iFile.ReadString(IniSectionName,
    'CustRptCertifBRONZE', '');
  edtCustRptMemShip.Text := iFile.ReadString(IniSectionName,
    'CustRptMemShip', '');
  sedtMaxAllowToPick.Value := iFile.ReadInteger(IniSectionName,
    'MaxAllowToPick', 20);
  iFile.Free;
end;

procedure TPref.WritePreferences(iniFileName: string);
var
  iFile: TIniFile;
begin
  iFile := TIniFile.create(iniFileName);
  iFile.WriteInteger(IniSectionName, 'MaxAllowToPick',
    sedtMaxAllowToPick.Value);
  iFile.WriteString(IniSectionName, 'CustRptCertifGOLD',
    edtCustRptCertifGOLD.Text);
  iFile.WriteString(IniSectionName, 'CustRptCertifSILVER',
    edtCustRptCertifSILVER.Text);
  iFile.WriteString(IniSectionName, 'CustRptCertifBRONZE',
    edtCustRptCertifBRONZE.Text);
  iFile.WriteString(IniSectionName, 'CustRptMemShip', edtCustRptMemShip.Text);
  iFile.Free;
end;

end.
