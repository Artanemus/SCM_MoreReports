unit dlgPodiumCertif;

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

  TPodiumCertif = class(TForm)
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
    procedure btnOkClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure qrySessionAfterScroll(DataSet: TDataSet);
    procedure ControlList1BeforeDrawItem(AIndex: Integer; ACanvas: TCanvas;
      ARect: TRect; AState: TOwnerDrawState);
    procedure FormDestroy(Sender: TObject);
    procedure ControlList1ItemClick(Sender: TObject);
    procedure btnGoldClick(Sender: TObject);
    procedure btnCheckClick(Sender: TObject);
    procedure btnSilverClick(Sender: TObject);
    procedure btnBronzeClick(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
  private
    { Private declarations }
    IsInit: Boolean;
    procedure UpdatePodiumList();
  public
    { Public declarations }
    PodiumList: TObjectList;
  end;

var
  PodiumCertif: TPodiumCertif;

implementation

{$R *.dfm}
{ TPodium }

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

procedure TPodiumCertif.btnBronzeClick(Sender: TObject);
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

procedure TPodiumCertif.btnCheckClick(Sender: TObject);
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

procedure TPodiumCertif.btnGoldClick(Sender: TObject);
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

procedure TPodiumCertif.btnOkClick(Sender: TObject);
begin
  ModalResult := mrOk;
end;

procedure TPodiumCertif.btnSilverClick(Sender: TObject);
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

procedure TPodiumCertif.ComboBox1Change(Sender: TObject);
begin
  if IsInit then exit;
  UpdatePodiumList;
  ControlList1.ItemCount := PodiumList.Count;
end;

procedure TPodiumCertif.ControlList1BeforeDrawItem(AIndex: Integer;
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

procedure TPodiumCertif.ControlList1ItemClick(Sender: TObject);
begin
  if (Sender is TVirtualImage) then
  begin
    if ((Sender as TVirtualImage).ImageIndex = 3) then
      (Sender as TVirtualImage).ImageIndex := 4
    else
      (Sender as TVirtualImage).ImageIndex := 3;
  end;
end;

procedure TPodiumCertif.FormCreate(Sender: TObject);
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

procedure TPodiumCertif.FormDestroy(Sender: TObject);
begin
  if Assigned(PodiumList) then
    PodiumList.Clear;
  FreeAndNil(PodiumList);
end;

procedure TPodiumCertif.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
  begin
    ModalResult := mrCancel;
    Key := 0;
  end;
end;

procedure TPodiumCertif.qrySessionAfterScroll(DataSet: TDataSet);
begin
  // UpdatePodiumList;
  // ControlList1.ItemCount := PodiumList.Count;
end;

procedure TPodiumCertif.UpdatePodiumList;
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
