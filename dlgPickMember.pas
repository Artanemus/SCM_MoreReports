unit dlgPickMember;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.CheckLst, Vcl.ExtCtrls,
  Vcl.VirtualImage, Vcl.BaseImageCollection, Vcl.ImageCollection;

type
  TPickMember = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    CheckListBox1: TCheckListBox;
    Edit1: TEdit;
    ImageCollection1: TImageCollection;
    btnOk: TButton;
    VirtualImage1: TVirtualImage;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  PickMember: TPickMember;

implementation

{$R *.dfm}

end.
