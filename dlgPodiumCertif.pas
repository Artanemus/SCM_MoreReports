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
    fTitle, fDetail: string;
    doGold, doSilver, doBronze: Boolean;
    fEventID: Integer;
    fChecked: Boolean;
  public
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
    imgCheck: TVirtualImage;
    ComboBox1: TComboBox;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    LinkListControlToField1: TLinkListControlToField;
    procedure btnOkClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure qrySessionAfterScroll(DataSet: TDataSet);
    procedure ControlList1BeforeDrawItem(AIndex: Integer; ACanvas: TCanvas;
      ARect: TRect; AState: TOwnerDrawState);
    procedure FormDestroy(Sender: TObject);
    procedure ControlList1ItemClick(Sender: TObject);
    procedure imgCheckClick(Sender: TObject);
  private
    { Private declarations }
    PodiumList: TObjectList;
    procedure UpdatePodiumList();
  public
    { Public declarations }
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

procedure TPodiumCertif.btnOkClick(Sender: TObject);
begin
  ModalResult := mrOk;
end;

procedure TPodiumCertif.ControlList1BeforeDrawItem(AIndex: Integer;
  ACanvas: TCanvas; ARect: TRect; AState: TOwnerDrawState);
var
  obj: TPodium;
begin
  if (AIndex > -1) and (AIndex < PodiumList.Count) then
  begin
    obj := PodiumList.Items[AIndex] as TPodium;
    if obj.fChecked then
      imgCheck.ImageIndex := 3
    else
      imgCheck.ImageIndex := 4;

    lblTitle.Caption := obj.fTitle;
    lblDetail.Caption := obj.fDetail;

    if obj.doGold then
      btnGold.ImageIndex := 0
    else
      btnGold.ImageIndex := 0;
    if obj.doSilver then
      btnSilver.ImageIndex := 1
    else
      btnSilver.ImageIndex := 1;
    if obj.doBronze then
      btnBronze.ImageIndex := 2
    else
      btnBronze.ImageIndex := 2;
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

procedure TPodiumCertif.imgCheckClick(Sender: TObject);
begin
    if (imgCheck.ImageIndex = 3) then
      imgCheck.ImageIndex := 4
    else
      imgCheck.ImageIndex := 3;
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
