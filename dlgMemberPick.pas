unit dlgMemberPick;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.DBCtrls,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, dmSCM, System.Contnrs, System.ImageList, Vcl.ImgList,
  Vcl.VirtualImageList, Vcl.BaseImageCollection, Vcl.ImageCollection;

type
  TscmMember = class(TObject)
  private
    { private declarations }
    MemberID: integer;
    FName: string;
  protected
    { protected declarations }
  public
    { public declarations }

    // published
    { published declarations }
    constructor Create();
    destructor Destroy(); override;
  end;

  TMemberPick = class(TForm)
    lboxL: TListBox;
    lboxR: TListBox;
    btnScrDest: TButton;
    btnScrDestAll: TButton;
    btnDestSrc: TButton;
    btnDestSrcAll: TButton;
    qryMemberList: TFDQuery;
    Button7: TButton;
    ImageCollection1: TImageCollection;
    VirtualImageList1: TVirtualImageList;
    edtSearch: TEdit;
    Button5: TButton;
    Label1: TLabel;
    VirtualImageList2: TVirtualImageList;
    procedure lboxRDragOver(Sender, Source: TObject; X, Y: integer;
      State: TDragState; var Accept: Boolean);
    procedure lboxLDragOver(Sender, Source: TObject; X, Y: integer;
      State: TDragState; var Accept: Boolean);
    procedure lboxRDragDrop(Sender, Source: TObject; X, Y: integer);
    procedure lboxLDragDrop(Sender, Source: TObject; X, Y: integer);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure lboxLDrawItem(Control: TWinControl; Index: integer; Rect: TRect;
      State: TOwnerDrawState);
    procedure btnRefreshClick(Sender: TObject);
    procedure btnScrDestClick(Sender: TObject);
    procedure btnDestSrcClick(Sender: TObject);
    procedure btnScrDestAllClick(Sender: TObject);
    procedure btnDestSrcAllClick(Sender: TObject);
    procedure edtSearchChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    scmMemberList: TObjectList;
    procedure TransferItems(Sender, Source: TObject);
    function MemberIsAssigned(obj: TObject; lbox: TListBox): Boolean;
  public
    { Public declarations }
  end;

var
  MemberPick: TMemberPick;

implementation

{$R *.dfm}

uses System.StrUtils;

{ TLboxMember }

constructor TscmMember.Create;
begin
  MemberID := 0;
  FName := '';
end;

destructor TscmMember.Destroy;
begin
  //
  inherited;
end;

{ MAIN CLASS }

procedure TMemberPick.btnScrDestAllClick(Sender: TObject);
begin
  lboxL.SelectAll;
  TransferItems(lboxR, lboxL);
end;

procedure TMemberPick.btnScrDestClick(Sender: TObject);
begin
  TransferItems(lboxR, lboxL);
end;

procedure TMemberPick.Button7Click(Sender: TObject);
begin
  ModalResult := mrOk;
end;

procedure TMemberPick.edtSearchChange(Sender: TObject);
var
  I: integer;
  obj: TscmMember;
  s: string;
begin
  lboxL.clear;
  for I := 0 to scmMemberList.Count - 1 do
  begin
    obj := (scmMemberList.Items[I] as TscmMember);
    // Already assigned to right-listbox.
    if MemberIsAssigned(obj, lboxR) then
      continue;
    s := obj.FName;
    // DO ALL
    if (length(edtSearch.Text) = 0) then
      lboxL.Items.AddObject(s, obj)
    else
    begin
      // FILTER - test for sub-string
      if ContainsText(s, edtSearch.Text) then
        lboxL.Items.AddObject(s, obj);
    end;
  end;
end;

procedure TMemberPick.btnDestSrcAllClick(Sender: TObject);
begin
  lboxR.SelectAll;
  TransferItems(lboxL, lboxR);
end;

procedure TMemberPick.btnDestSrcClick(Sender: TObject);
begin
  TransferItems(lboxL, lboxR);
end;

procedure TMemberPick.btnRefreshClick(Sender: TObject);
begin
  lboxL.Refresh;
end;

procedure TMemberPick.FormCreate(Sender: TObject);
var
  s: string;
  obj: TscmMember;
  j: integer;
begin
  scmMemberList := TObjectList.Create(true);
  // Populate the lboxL with members details
  if Assigned(SCM) then
  begin
    if not Assigned(qryMemberList.Connection) then
      qryMemberList.Connection := SCM.scmConnection;
    qryMemberList.Open;
    if qryMemberList.Active then
    begin
      while not qryMemberList.Eof do
      begin
        obj := TscmMember.Create;
        obj.MemberID := qryMemberList.FieldByName('MemberID').AsInteger;
        obj.FName := qryMemberList.FieldByName('FName').AsString;
        j := scmMemberList.Add(obj);
        s := qryMemberList.FieldByName('FName').AsString;
        lboxL.Items.AddObject(s, scmMemberList.Items[j]);
        qryMemberList.Next;
      end;
    end;
  end;
end;

procedure TMemberPick.FormDestroy(Sender: TObject);
begin
  scmMemberList.clear;
end;

procedure TMemberPick.FormShow(Sender: TObject);
begin
  edtSearch.SetFocus;
end;

procedure TMemberPick.lboxLDragDrop(Sender, Source: TObject; X, Y: integer);
begin
  TransferItems(Sender, Source);
end;

procedure TMemberPick.lboxLDragOver(Sender, Source: TObject; X, Y: integer;
  State: TDragState; var Accept: Boolean);
begin
  { Only let another TListBox drop items }
  if Source is TListBox then
    Accept := true
  else
    Accept := false;
end;

procedure TMemberPick.lboxLDrawItem(Control: TWinControl; Index: integer;
  Rect: TRect; State: TOwnerDrawState);
var
  lb: TListBox;
begin
  lb := (Control AS TListBox);
  lb.Canvas.TextOut(Rect.Left, Rect.Top, lb.Items[Index]);
end;

procedure TMemberPick.lboxRDragDrop(Sender, Source: TObject; X, Y: integer);
begin
  TransferItems(Sender, Source);
end;

procedure TMemberPick.lboxRDragOver(Sender, Source: TObject; X, Y: integer;
  State: TDragState; var Accept: Boolean);
begin
  { Only let another TListBox drop items }
  if Source is TListBox then
    Accept := true
  else
    Accept := false;
end;

function TMemberPick.MemberIsAssigned(obj: TObject; lbox: TListBox): Boolean;
var
  I: integer;
begin
  // check if obj is used by to lboxr
  result := false;
  for I := 0 to lbox.Count - 1 do
  begin
    if (obj = lbox.Items.Objects[I]) then
    begin
      result := true;
      break;
    end;
  end;

end;

procedure TMemberPick.TransferItems(Sender, Source: TObject);
var
  I: integer;
begin
  with (Source AS TListBox) do
  begin
    try
      for I := 0 to Items.Count - 1 do
      begin
        if Selected[I] then
          // NOTE: destination MemberList is assigned source object.
          (Sender AS TListBox).Items.AddObject(Items[I], Items.Objects[I]);
      end;
    finally
      // NOTE: Source's assigned objects are not freed (in use).
      DeleteSelected;
    end;
  end;
end;

end.
