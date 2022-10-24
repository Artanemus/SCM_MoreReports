unit dlgPodiumCertif;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.ControlList, System.ImageList, Vcl.ImgList, Vcl.VirtualImageList,
  Vcl.BaseImageCollection, Vcl.ImageCollection, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Vcl.DBCtrls, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, dmSCM;

type
  TPodiumCertif = class(TForm)
    Panel2: TPanel;
    Label1: TLabel;
    btnOk: TButton;
    ImageCollection1: TImageCollection;
    VirtualImageList1: TVirtualImageList;
    ControlList1: TControlList;
    Panel1: TPanel;
    Panel3: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    ControlListButton1: TControlListButton;
    ControlListButton2: TControlListButton;
    ControlListButton3: TControlListButton;
    qrySession: TFDQuery;
    dsSession: TDataSource;
    DBComboBox1: TDBComboBox;
    procedure btnOkClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  PodiumCertif: TPodiumCertif;

implementation

{$R *.dfm}

procedure TPodiumCertif.btnOkClick(Sender: TObject);
begin
  ModalResult := mrOk;
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

end.
