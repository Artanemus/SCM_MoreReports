unit dlgPickCertif;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.ControlList, System.ImageList, Vcl.ImgList, Vcl.VirtualImageList,
  Vcl.BaseImageCollection, Vcl.ImageCollection, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Vcl.DBCtrls, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, dmSCM,
  System.Contnrs, Vcl.VirtualImage, System.Rtti, System.Bindings.Outputs,
  Vcl.Bind.Editors, Data.Bind.EngExt, Vcl.Bind.DBEngExt, Data.Bind.Components,
  Data.Bind.DBScope;

type

  TPodiumMode = (pmGold, pmSilver, pmBronze);


  TPodium = class(TObject)
  private
  public
    fTitle, fDetail: string;
    doGold, doSilver, doBronze: Boolean;
    fEventID: Integer;
    fChecked: Boolean;

    constructor Create();
    destructor Destroy(); override;
  end;

  TPickCertif = class(TForm)
    Panel2: TPanel;
    Label1: TLabel;
    btnOk: TButton;
    ImageCollection1: TImageCollection;
    VirtualImageList1: TVirtualImageList;
    ControlList1: TControlList;
    Panel1: TPanel;
    Panel3: TPanel;
    lblTitle: TLabel;
    lblDetail: TLabel;
    btnGold: TControlListButton;
    btnSilver: TControlListButton;
    btnBronze: TControlListButton;
    qryPSession: TFDQuery;
    dsSession: TDataSource;
    qryEvent: TFDQuery;
    dsevent: TDataSource;
    ComboBox1: TComboBox;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    LinkListControlToField1: TLinkListControlToField;
    btnCheck: TControlListButton;
    Panel4: TPanel;
    btnSelectAll: TButton;
    btnSelectNone: TButton;
    btnToggleGold: TButton;
    btnToggleSilver: TButton;
    btnToggleBronze: TButton;
    btnCancel: TButton;
    procedure btnOkClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure ControlList1BeforeDrawItem(AIndex: Integer; ACanvas: TCanvas;
      ARect: TRect; AState: TOwnerDrawState);
    procedure FormDestroy(Sender: TObject);
    procedure ControlList1ItemClick(Sender: TObject);
    procedure btnGoldClick(Sender: TObject);
    procedure btnCheckClick(Sender: TObject);
    procedure btnSilverClick(Sender: TObject);
    procedure btnBronzeClick(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure btnSelectAllClick(Sender: TObject);
    procedure btnSelectNoneClick(Sender: TObject);
    procedure btnToggleGoldClick(Sender: TObject);
    procedure btnToggleSilverClick(Sender: TObject);
    procedure btnToggleBronzeClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
  private
    { Private declarations }
    IsInit: Boolean;
    procedure UpdatePodiumList();
    function GetFilterStr(PodiumMode: TPodiumMode): string;
  public
    { Public declarations }
    PodiumList: TObjectList;
    function GetCurrSessionID(): integer;
    function GetGoldFilterStr(): string;
    function GetSilverFilterStr(): string;
    function GetBronzeFilterStr(): string;
  end;


var
  PickCertif: TPickCertif;

implementation

{$R *.dfm}
{ TPodium }

uses System.StrUtils;

constructor TPodium.Create;
begin
  fTitle := '';
  fDetail := '';
  doGold := true;
  doSilver := true;
  doBronze := true;
  fEventID := 0;
  fChecked := true;
end;

destructor TPodium.Destroy;
begin

  inherited;
end;

{ MAIN COMPONENT }

procedure TPickCertif.btnBronzeClick(Sender: TObject);
var
  obj: TPodium;
  idx: integer;
begin
    idx := ControlList1.ItemIndex;
  if (idx > -1) and (idx < PodiumList.Count) then
  begin
    obj := PodiumList.Items[idx] as TPodium;
    obj.doBronze := not (obj.doBronze);
    ControlList1.Paint;
  end;
end;

procedure TPickCertif.btnCancelClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TPickCertif.btnCheckClick(Sender: TObject);
var
  obj: TPodium;
  idx: integer;
begin
    idx := ControlList1.ItemIndex;
  if (idx > -1) and (idx < PodiumList.Count) then
  begin
    obj := PodiumList.Items[idx] as TPodium;
    obj.fChecked := not (obj.fChecked);
    ControlList1.Paint;
  end;
end;

procedure TPickCertif.btnGoldClick(Sender: TObject);
var
  obj: TPodium;
  idx: integer;
begin
    idx := ControlList1.ItemIndex;
  if (idx > -1) and (idx < PodiumList.Count) then
  begin
    obj := PodiumList.Items[idx] as TPodium;
    obj.doGold := not (obj.doGold);
    ControlList1.Paint;
  end;
end;

procedure TPickCertif.btnOkClick(Sender: TObject);
begin
  ModalResult := mrOk;
end;

procedure TPickCertif.btnSelectAllClick(Sender: TObject);
var
  I: Integer;
begin
  for I := 0 to PodiumList.Count-1 do
  begin
    (PodiumList.Items[I] as TPodium).fChecked := true;
  end;
  ControlList1.Paint;
end;

procedure TPickCertif.btnSelectNoneClick(Sender: TObject);
var
  I: Integer;
begin
  for I := 0 to PodiumList.Count-1 do
  begin
    (PodiumList.Items[I] as TPodium).fChecked := false;
  end;
  ControlList1.Paint;
end;

procedure TPickCertif.btnSilverClick(Sender: TObject);
var
  obj: TPodium;
  idx: integer;
begin
    idx := ControlList1.ItemIndex;
  if (idx > -1) and (idx < PodiumList.Count) then
  begin
    obj := PodiumList.Items[idx] as TPodium;
    obj.doSilver := not (obj.doSilver);
    ControlList1.Paint;
  end;
end;

procedure TPickCertif.btnToggleBronzeClick(Sender: TObject);
var
  I: Integer;
  obj: TPodium;
begin
  for I := 0 to PodiumList.Count-1 do
  begin
    obj := PodiumList.Items[I] as TPodium;
    obj.doBronze := not obj.doBronze;
  end;
  ControlList1.Paint;
end;

procedure TPickCertif.btnToggleGoldClick(Sender: TObject);
var
  I: Integer;
  obj: TPodium;
begin
  for I := 0 to PodiumList.Count-1 do
  begin
    obj := PodiumList.Items[I] as TPodium;
    obj.doGold := not obj.doGold;
  end;
  ControlList1.Paint;
end;

procedure TPickCertif.btnToggleSilverClick(Sender: TObject);
var
  I: Integer;
  obj: TPodium;
begin
  for I := 0 to PodiumList.Count-1 do
  begin
    obj := PodiumList.Items[I] as TPodium;
    obj.doSilver := not obj.doSilver;
  end;
  ControlList1.Paint;
end;

procedure TPickCertif.ComboBox1Change(Sender: TObject);
begin
  if IsInit then exit;
  UpdatePodiumList;
  ControlList1.ItemCount := PodiumList.Count;
end;

procedure TPickCertif.ControlList1BeforeDrawItem(AIndex: Integer;
  ACanvas: TCanvas; ARect: TRect; AState: TOwnerDrawState);
var
  obj: TPodium;
begin
  if (AIndex > -1) and (AIndex < PodiumList.Count) then
  begin
    obj := PodiumList.Items[AIndex] as TPodium;
    // if check then process a podium certificate for this event
    if obj.fChecked then
      btnCheck.ImageIndex := 6
    else
      btnCheck.ImageIndex := 7;
    // distance.stroke and event details
    lblTitle.Caption := obj.fTitle;
    lblDetail.Caption := obj.fDetail;
    // determins which certificate is printed.
    if obj.doGold then
      btnGold.ImageIndex := 0
    else
      btnGold.ImageIndex := 3;
    if obj.doSilver then
      btnSilver.ImageIndex := 1
    else
      btnSilver.ImageIndex := 4;
    if obj.doBronze then
      btnBronze.ImageIndex := 2
    else
      btnBronze.ImageIndex := 5;
  end;
end;

procedure TPickCertif.ControlList1ItemClick(Sender: TObject);
begin
  if (Sender is TVirtualImage) then
  begin
    if ((Sender as TVirtualImage).ImageIndex = 3) then
      (Sender as TVirtualImage).ImageIndex := 4
    else
      (Sender as TVirtualImage).ImageIndex := 3;
  end;
end;

procedure TPickCertif.FormCreate(Sender: TObject);
begin
  if not Assigned(SCM) then
    Close;

  PodiumList := TObjectList.Create;
  IsInit := true;


  if SCM.scmConnection.Connected then
  begin
    qryPSession.Connection := SCM.scmConnection;
    qryEvent.Connection := SCM.scmConnection;
    if (not qryPSession.Active) then
      qryPSession.Open;
    if (not qryEvent.Active) then
      qryEvent.Open;

    if qryEvent.Active then
    begin
      UpdatePodiumList;
      ControlList1.ItemCount := PodiumList.Count;
    end;
  end;

    IsInit := false;

end;

procedure TPickCertif.FormDestroy(Sender: TObject);
begin
  if Assigned(PodiumList) then
    PodiumList.Clear;
  FreeAndNil(PodiumList);
end;

procedure TPickCertif.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
  begin
    ModalResult := mrCancel;
    Key := 0;
  end;
end;

function TPickCertif.GetBronzeFilterStr: string;
begin
  result := GetFilterStr(pmBronze);
end;

function TPickCertif.GetCurrSessionID: integer;
begin
  result := 0;
  if qryPSession.Active then
  begin
    if qryPSession.RecordCount > 0  then
      result := qryPSession.FieldByName('SessionID').AsInteger;
  end;
end;

function TPickCertif.GetFilterStr(PodiumMode: TPodiumMode): string;
var
s: string;
obj: TPodium;
I: integer;
begin
    // iterate accross events in podiumlist
    result := '';
    s := '';
    for I := 0 to PodiumList.count - 1 do
    begin
      obj := PodiumList.Items[I] as TPodium;
      if obj.fChecked then
      begin
      // TODO: does the event have swimmers with racetimes?

      case PodiumMode of
        pmGold:
          begin
          if obj.doGold then
            s := s + 'EventID = ' + IntToStr(obj.fEventID) + ' OR ';
          end;
        pmSilver:
          begin
          if obj.doSilver then
            s := s + 'EventID = ' + IntToStr(obj.fEventID) + ' OR ';
          end;
        pmBronze:
          begin
          if obj.doBronze then
            s := s + 'EventID = ' + IntToStr(obj.fEventID) + ' OR ';
          end;
      end;

      end;
    end;
    // Trim redundant ' AND ' at eos.
    if Length(s) > 4 then
      s := LeftStr(s, Length(s) - 4);
    // Empty dataSet.
    if (s = '') then
      s := 'EventID = 0';
    result := s;
end;

function TPickCertif.GetGoldFilterStr: string;
begin
  result := GetFilterStr(pmGold);
end;

function TPickCertif.GetSilverFilterStr: string;
begin
  result := GetFilterStr(pmSilver);
end;

procedure TPickCertif.UpdatePodiumList;
var
  obj: TPodium;
begin
  if Assigned(SCM) and qryEvent.Active then
  begin
    if PodiumList.Count > 0 then
      PodiumList.Clear;
    qryEvent.First;
    while not qryEvent.Eof do
    begin
      obj := TPodium.Create;
      obj.fEventID := qryEvent.FieldByName('EventID').AsInteger;
      obj.fTitle := qryEvent.FieldByName('TitleStr').AsString;
      obj.fDetail := qryEvent.FieldByName('DetailStr').AsString;
      PodiumList.Add(obj);
      qryEvent.Next;
    end;
  end;
end;

end.
