unit dlgMembership;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.WinXCalendars, Vcl.VirtualImage, Vcl.BaseImageCollection,
  Vcl.ImageCollection, Vcl.ButtonGroup, System.ImageList, Vcl.ImgList,
  Vcl.VirtualImageList;

type
  TMembership = class(TForm)
    Panel2: TPanel;
    Panel3: TPanel;
    btnOk: TButton;
    Label8: TLabel;
    Label9: TLabel;
    calDateFrom: TCalendarPicker;
    calDateTo: TCalendarPicker;
    ImageCollection1: TImageCollection;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    RadioButton3: TRadioButton;
    chkboxGenerateNum: TCheckBox;
    Panel1: TPanel;
    btnToday: TButton;
    btnThisWeek: TButton;
    btnThisSeason: TButton;
    GroupBox: TGroupBox;
    VirtualImageList1: TVirtualImageList;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnOkClick(Sender: TObject);
    procedure RadioBtnGenericClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnTodayClick(Sender: TObject);
    procedure btnThisWeekClick(Sender: TObject);
    procedure btnThisSeasonClick(Sender: TObject);
    procedure imgDateFromClick(Sender: TObject);
    procedure imgDateToClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    fTagNum: Integer;
    procedure ReadPreferences(iniFileName: string);
    procedure WritePreferences(iniFileName: string);
    function GetActiveTagNum(): Integer;
    function FindRadioBtn(TagNum: Integer): TControl;
  public
    { Public declarations }

    property TagNum: Integer read fTagNum;

  end;

var
  Membership: TMembership;

implementation

uses
  System.DateUtils, dmSCM, System.IniFiles, Utility, system.UITypes;

{$R *.dfm}

procedure TMembership.btnOkClick(Sender: TObject);
begin
  fTagNum := GetActiveTagNum;
  if fTagNum <> -1 then
    ModalResult := mrOk
  else
  begin
    MessageDlg('No radio buttons are active.' + sLineBreak +
      'A selection method hasn''t been chosen.', TMsgDlgType.mtInformation,
      [mbOk], 0);
  end;
end;

procedure TMembership.btnThisSeasonClick(Sender: TObject);
var
  dt: TDateTime;
begin
  dt := Date;
  // Get the start of season.
  if Assigned(SCM) then
  begin
    dt := SCM.GetStartOfSwimmingSeason(1);
  end;
  calDateFrom.Date := dt;
  calDateTo.Date := Date;
end;

procedure TMembership.btnThisWeekClick(Sender: TObject);
begin
  calDateFrom.Date := StartOfTheWeek(Date);
  calDateTo.Date := EndOfTheWeek(Date);
end;

procedure TMembership.btnTodayClick(Sender: TObject);
begin
  calDateFrom.Date := Date;
  calDateTo.Date := Date;
end;

procedure TMembership.FormCreate(Sender: TObject);
var
  iniFileName: string;
  cntrl: TControl;
  doDefault: boolean;
begin
  // initialise params.
  fTagNum := -1;
  doDefault := true;
  // ----------------------------------------------------
  // R E A D   P R E F E R E N C E S .
  // ----------------------------------------------------
  iniFileName := GetSCMPreferenceFileName;
  if FileExists(iniFileName) then
  begin
    ReadPreferences(iniFileName);
    // if successfully - fTagNum is re-assigned.
    if fTagNum <> -1 then
    begin
      // Within the grouped panel, find the RBtn with the tag.
      cntrl := FindRadioBtn(fTagNum);
      if Assigned(cntrl) then
      begin
        RadioBtnGenericClick(cntrl);
        doDefault := false;
      end;
    end;
  end;
  if doDefault then
    // Set defaut radiobutton state.
    RadioBtnGenericClick(RadioButton1);
end;

procedure TMembership.FormDestroy(Sender: TObject);
var
  iniFileName: string;
begin
  // ----------------------------------------------------
  // W R I T E   P R E F E R E N C E S .
  // ----------------------------------------------------
  iniFileName := GetSCMPreferenceFileName;
  if FileExists(iniFileName) then
  begin
    WritePreferences(iniFileName);
  end;

end;

procedure TMembership.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
  begin
    ModalResult := mrCancel;
    Key := 0;
  end;
end;

function TMembership.FindRadioBtn(TagNum: Integer): TControl;
var
  i: Integer;
  cntrl: TControl;
begin
  result := nil;
  for i := 0 to GroupBox.ControlCount - 1 do
  begin
    cntrl := GroupBox.Controls[i];
    if (cntrl is TRadioButton) then
    begin
      if (cntrl as TRadioButton).Tag = TagNum then
      begin
        result := cntrl;
        break;
      end;
    end;
  end;
end;

function TMembership.GetActiveTagNum: Integer;
var
  i: Integer;
  cntrl: TControl;
begin
  result := -1;
  for i := 0 to GroupBox.ControlCount - 1 do
  begin
    cntrl := GroupBox.Controls[i];
    if (cntrl is TRadioButton) then
    begin
      if (cntrl as TRadioButton).Checked then
      begin
        result := cntrl.Tag;
        break;
      end;
    end;
  end;
end;

procedure TMembership.imgDateFromClick(Sender: TObject);
begin
  // TO DO
end;

procedure TMembership.imgDateToClick(Sender: TObject);
begin
  // TODO
end;

procedure TMembership.RadioBtnGenericClick(Sender: TObject);
var
  rbtn: TRadioButton;
  cntrl: TControl;
  i: Integer;

begin
  rbtn := TRadioButton(Sender);
  rbtn.Checked := true;
  for i := 0 to GroupBox.ControlCount - 1 do
  begin
    cntrl := GroupBox.Controls[i];
    if (cntrl.Name <> rbtn.Name) and cntrl.ClassNameIs('TRadioButton') then
    begin
      TRadioButton(cntrl).Checked := false;
    end;
  end;

end;

procedure TMembership.ReadPreferences(iniFileName: string);
var
  iFile: TIniFile;
begin
  iFile := TIniFile.Create(iniFileName);
  fTagNum := iFile.ReadInteger('MembershipDlg', 'TagNum', -1);
  iFile.Free;
end;

procedure TMembership.WritePreferences(iniFileName: string);
var
  iFile: TIniFile;
begin
  iFile := TIniFile.Create(iniFileName);
  fTagNum := GetActiveTagNum;
  iFile.WriteInteger('MembershipDlg', 'TagNum', fTagNum);
  iFile.Free;
end;

end.
