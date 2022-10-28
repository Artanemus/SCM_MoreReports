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
    frxRptMembership: TfrxReport;
    frxDBMember: TfrxDBDataset;
    qryMember: TFDQuery;
    frxPDFExport1: TfrxPDFExport;
    frxBMPExport1: TfrxBMPExport;
    frxJPEGExport1: TfrxJPEGExport;
    frxDesigner1: TfrxDesigner;
    frxBarCodeObject1: TfrxBarCodeObject;
    qryINDVmember: TFDQuery;
    qryPodiumWinners: TFDQuery;
    frxDBPodiumWinners: TfrxDBDataset;
    frxRptPodiumGeneric: TfrxReport;
    frxRptPodiumSilver: TfrxReport;
    frxRptPodiumBronze: TfrxReport;
    frxRptPodiumGold: TfrxReport;
    procedure DataModuleCreate(Sender: TObject);
    procedure frxRptPodiumGoldBeforePrint(Sender: TfrxReportComponent);
  private
    { Private declarations }
    fIsActive: boolean;
    fSwimClubID: integer;
  public
    { Public declarations }
    procedure PrepareMembership(sdate, edate: TDATETIME; switch: boolean);
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
    // if qryRptSharedHeader.Active then
    // fIsActive := True;

    // qryMembershipCard.Connection := SCM.scmConnection;

  end;
end;

procedure TRPTS.frxRptPodiumGoldBeforePrint(Sender: TfrxReportComponent);
//var
//page: TfrxReportPage;
//obj: TObject;
begin
//  obj := frxRptPodiumGold.FindObject('Page1');
//  if assigned(obj) then
//  begin
//  page := obj as TfrxReportPage;


  //page.BackPicture.Assign('D:\Scard\Pictures\abbasi.jpg');
end;



procedure TRPTS.PrepareMembership(sdate, edate: TDATETIME; switch: boolean);
begin
  if Assigned(SCM) then
  begin
    if not Assigned(qryMember.Connection) then
      qryMember.Connection := SCM.scmConnection;
    try
      if qryMember.Active then
        qryMember.close;
      qryMember.ParamByName('SWITCH').AsBoolean := switch;
      qryMember.ParamByName('STARTDT').AsDateTime := sdate;
      qryMember.ParamByName('ENDDT').AsDateTime := edate;
      qryMember.Prepare;
      qryMember.Open;
      if qryMember.Active then
      begin
        // DO something
      end;
    finally
        // qryMember.Close;
    end;
  end;
end;

end.
