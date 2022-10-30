unit dmRPTS;

interface

uses
  System.SysUtils, System.Classes, dmSCM, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  frxClass, frxDBSet, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  frxDesgn, frxExportImage, frxExportBaseDialog, frxExportPDF, frxBarcode,
  Vcl.BaseImageCollection, Vcl.ImageCollection, Vcl.Graphics, System.ImageList,
  Vcl.ImgList, Vcl.VirtualImageList;

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
    frxRptPodium: TfrxReport;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
    fIsActive: boolean;
    fSwimClubID: integer;
  public
    { Public declarations }
    procedure PrepareMembership(sdate, edate: TDATETIME; switch: boolean);
    procedure AssignParams(Place: integer);
  end;

var
  RPTS: TRPTS;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}
{$R *.dfm}

procedure TRPTS.AssignParams(Place: integer);
var
  page: TfrxReportPage;
  sl: TfrxMemoView;
begin
  sl := frxRptPodium.FindComponent('MemoPodiumPlace') As TfrxMemoView;
  page := frxRptPodium.FindComponent('Page1') AS TfrxReportPage;

  if Assigned(sl) then
  begin
    sl.Memo.Clear;
  end;
  case Place of
    1:
      begin
        if Assigned(sl) then
          sl.Memo.Add('1st Place');
        if Assigned(page) then
        begin
          page.BackPicture.LoadFromFile
            ('C:\Users\Ben\Documents\GitHub\SCM_MoreReports\ASSETS\CertificateGold.png');
        end;
      end;
    2:
      begin
        if Assigned(sl) then
          sl.Memo.Add('2nd Place');
        if Assigned(page) then
          page.BackPicture.LoadFromFile
            ('C:\Users\Ben\Documents\GitHub\SCM_MoreReports\ASSETS\CertificateSilver.png');
      end;
    3:
      begin
        if Assigned(sl) then
          sl.Memo.Add('3rd Place');
        if Assigned(page) then
          page.BackPicture.LoadFromFile
            ('C:\Users\Ben\Documents\GitHub\SCM_MoreReports\ASSETS\CertificateBronze.png');
      end;
  end;
end;

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
