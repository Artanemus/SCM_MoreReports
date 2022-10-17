unit dlgTwoLists;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.DBCtrls,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, dmSCM;

type
  TLboxMember = class(TObject)
  private
    { private declarations }
    MemberID: integer;
    Fname: string;
  protected
    { protected declarations }
  public
    { public declarations }

    // published
    { published declarations }
  end;

type
  TTwoLists = class(TForm)
    lboxL: TListBox;
    lboxR: TListBox;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    qryMemberList: TFDQuery;
    Button7: TButton;
    Button8: TButton;
    procedure lboxRDragOver(Sender, Source: TObject; X, Y: integer;
      State: TDragState; var Accept: Boolean);
    procedure lboxLDragOver(Sender, Source: TObject; X, Y: integer;
      State: TDragState; var Accept: Boolean);
    procedure lboxRDragDrop(Sender, Source: TObject; X, Y: integer);
    procedure lboxLDragDrop(Sender, Source: TObject; X, Y: integer);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure lboxLDataObject(Control: TWinControl; Index: integer;
      var DataObject: TObject);
    procedure lboxLData(Control: TWinControl; Index: integer; var Data: string);
    function lboxLDataFind(Control: TWinControl; FindString: string): integer;
    procedure lboxLDrawItem(Control: TWinControl; Index: integer; Rect: TRect;
      State: TOwnerDrawState);
    procedure Button8Click(Sender: TObject);
  private
    { Private declarations }
    procedure TransferItems(Sender, Source: TObject);
    procedure FreeLboxObjects(LBox: TListBox);
  public
    { Public declarations }
  end;

var
  TwoLists: TTwoLists;

implementation

{$R *.dfm}

procedure TTwoLists.Button7Click(Sender: TObject);
begin
  ModalResult := mrOk;
end;

procedure TTwoLists.Button8Click(Sender: TObject);
begin
  lboxL.Refresh;
end;

procedure TTwoLists.FormCreate(Sender: TObject);
var
  s: string;
  obj: TLboxMember;
  i: integer;
begin
      i := 0;
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
        obj := TLboxMember.Create;
        obj.MemberID := qryMemberList.FieldByName('MemberID').AsInteger;
        obj.Fname := qryMemberList.FieldByName('FName').AsString;
        s := qryMemberList.FieldByName('FName').AsString;
        lboxL.Items.AddObject(s, obj);
        i := i + 1;
        qryMemberList.Next;
      end;
    end;
  end;
  lboxl.Count := i;
  lboxL.Refresh;
  lboxL.Repaint;
end;

procedure TTwoLists.FormDestroy(Sender: TObject);
begin
  FreeLboxObjects(lboxL);
  FreeLboxObjects(lboxR);
end;

procedure TTwoLists.FreeLboxObjects(LBox: TListBox);
var
  i: integer;
begin
  for i := 0 to LBox.Items.Count - 1 do
    LBox.Items.Objects[i].Free;
  LBox.Items.Clear;
end;

procedure TTwoLists.lboxLData(Control: TWinControl; Index: integer;
  var Data: string);
var
  obj: TLboxMember;
  lb: TListBox;
begin
  lb := (Control AS TListBox);
  obj := (lb.Items.Objects[index] AS TLboxMember);
  Data := obj.Fname;
end;

function TTwoLists.lboxLDataFind(Control: TWinControl;
  FindString: string): integer;
var
  i: integer;
  obj: TLboxMember;
  lb: TListBox;
begin
  result := -1;
  lb := (Control AS TListBox);
  for i := 0 to lb.Count do
  begin

    obj := (lb.Items.Objects[i] AS TLboxMember);
    if obj.Fname = FindString then
    begin
      result := i;
    end;
  end;
end;

procedure TTwoLists.lboxLDataObject(Control: TWinControl; Index: integer;
  var DataObject: TObject);
var
  obj: TLboxMember;
  lb: TListBox;
begin
  lb := (Control AS TListBox);
  obj := (lb.Items.Objects[index] AS TLboxMember);
  DataObject := TObject(obj);
end;

procedure TTwoLists.lboxLDragDrop(Sender, Source: TObject; X, Y: integer);
begin
  TransferItems(Sender, Source);
end;

procedure TTwoLists.lboxLDragOver(Sender, Source: TObject; X, Y: integer;
  State: TDragState; var Accept: Boolean);
begin
  { Only let another TListBox drop items }
  if Source is TListBox then
    Accept := True
  else
    Accept := False;
end;

procedure TTwoLists.lboxLDrawItem(Control: TWinControl; Index: integer;
  Rect: TRect; State: TOwnerDrawState);
var
  lb: TListBox;
begin
  lb := (Control AS TListBox);
  lb.Canvas.TextOut(Rect.Left, Rect.Top, lb.Items[Index]);
end;

procedure TTwoLists.lboxRDragDrop(Sender, Source: TObject; X, Y: integer);
begin
  TransferItems(Sender, Source);
end;

procedure TTwoLists.lboxRDragOver(Sender, Source: TObject; X, Y: integer;
  State: TDragState; var Accept: Boolean);
begin
  { Only let another TListBox drop items }
  if Source is TListBox then
    Accept := True
  else
    Accept := False;
end;

procedure TTwoLists.TransferItems(Sender, Source: TObject);
var
  i, N: integer;
  s: string;
  obj: TLboxMember;
begin
  with (Source AS TListBox) do
  begin
    try
      for i := 0 to Items.Count - 1 do
      begin
        if Selected[i] then
        begin
          obj := TLboxMember.Create;
          obj.MemberID := (Items.Objects[i] as TLboxMember).MemberID;
          s := Items[i];
          (Sender AS TListBox).Items.AddObject(s, obj);
          // FreeAndNil(Items.Objects[i]);
          // (Source AS TListBox).Items.Delete(i);
        end;
      end;
    finally
      //
    end;

  end;
end;

end.
