unit dlgAbout;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Imaging.pngimage,
  Vcl.Imaging.jpeg, Vcl.ExtCtrls, ExeInfo;

type
  TAbout = class(TForm)
    Button1: TButton;
    Image1: TImage;
    Image2: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    ExeInfo1: TExeInfo;
  end;

var
  About: TAbout;

implementation

{$R *.dfm}

procedure TAbout.FormCreate(Sender: TObject);
begin
	ExeInfo1 := TExeInfo.Create(self);

end;

procedure TAbout.FormDestroy(Sender: TObject);
begin
	ExeInfo1.Free;
end;

procedure TAbout.FormShow(Sender: TObject);
begin
	Label5.Caption := ExeInfo1.FileDescription;
	Label6.Caption := ExeInfo1.FileVersion;
	Label7.Caption := ExeInfo1.ProductName;
	Label8.Caption := ExeInfo1.ProductVersion;
	Label9.Caption := ExeInfo1.LegalCopyright;
end;

end.
