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
  private
    { Private declarations }
    fTagNum: Integer;
  public
    { Public declarations }

    property TagNum: Integer read fTagNum;

  end;

var
  Membership: TMembership;

implementation

uses
  System.DateUtils, dmSCM;

{$R *.dfm}

procedure TMembership.btnOkClick(Sender: TObject);
var
  i: Integer;
  cntrl: TControl;
begin
  for i := 0 to GroupBox.ControlCount - 1 do
  begin
    cntrl := GroupBox.Controls[i];
    if cntrl.ClassNameIs('TRadioButton') then
    begin
      if TRadioButton(cntrl).Checked then
      begin
        fTagNum := cntrl.Tag;
        break;
      end;
    end;
  end;
  ModalResult := mrOk;
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
  calDateTo.Date := EndOfTheWeek(date);
end;

procedure TMembership.btnTodayClick(Sender: TObject);
begin
  calDateFrom.Date := Date;
  calDateTo.Date := Date;
end;

procedure TMembership.FormCreate(Sender: TObject);
begin
  // TODO - load preferences- read last activated radiobutton.
  // Set defaut radiobutton state.
  RadioBtnGenericClick(RadioButton1);
end;

procedure TMembership.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
    ModalResult := mrCancel;
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

end.
