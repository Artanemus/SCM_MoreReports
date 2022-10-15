unit dmRPTS;

interface

uses
  System.SysUtils, System.Classes, dmSCM, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  frxClass, frxDBSet, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  frxDesgn, frxExportImage, frxExportBaseDialog, frxExportPDF, frxBarcode;

type
  TRPTS = class(TDataModule)
    qrySharedHeader: TFDQuery;
    frxDBSharedHeader: TfrxDBDataset;
    frxReport1: TfrxReport;
    frxDBMember: TfrxDBDataset;
    qryMember: TFDQuery;
    frxPDFExport1: TfrxPDFExport;
    frxBMPExport1: TfrxBMPExport;
    frxJPEGExport1: TfrxJPEGExport;
    frxDesigner1: TfrxDesigner;
    frxBarCodeObject1: TfrxBarCodeObject;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
    fIsActive: boolean;
    fSwimClubID: integer;
  public
    { Public declarations }
  end;

var
  RPTS: TRPTS;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TRPTS.DataModuleCreate(Sender: TObject);
begin
  // I N I T I A L I Z E   P A R A M S  .
  fIsActive := False;
  fSwimClubID := 1;
  // C O N N E C T .
  if Assigned(SCM) then
  begin
    // qryRptSharedHeader.Connection := SCM.scmConnection;
    // qryRptSharedHeader.Open;
    //if qryRptSharedHeader.Active then
      //fIsActive := True;

    // qryMembershipCard.Connection := SCM.scmConnection;

  end;
end;

end.
