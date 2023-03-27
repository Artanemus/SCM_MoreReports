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
    qryPodiumGold: TFDQuery;
    qryPodiumSilver: TFDQuery;
    qryPodiumBronze: TFDQuery;
    frxDBSilver: TfrxDBDataset;
    frxDBBronze: TfrxDBDataset;
    frxRptGold: TfrxReport;
    frxDBGold: TfrxDBDataset;
    frxRptSilver: TfrxReport;
    frxRptBronze: TfrxReport;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
    fIsActive: boolean;
    fSwimClubID: integer;
  public
    { Public declarations }
    procedure PrepareMembership(sdate, edate: TDATETIME; switch: boolean);
    procedure PreparePodium(SessionID: integer);
  end;

var
  RPTS: TRPTS;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses SCMUtility, IniFiles;

{$R *.dfm}

procedure TRPTS.DataModuleCreate(Sender: TObject);
begin
  // I N I T I A L I Z E   P A R A M S  .
  fIsActive := False;
  fSwimClubID := 1;
  // C O N N E C T .
  if Assigned(SCM) then
  begin
    fIsActive := True;
    // CONNECTIONS DONE ON DEMAND
    // if not Assigned(qryMember.Connection) then
    // qryMember.Connection := SCM.scmConnection;
    // if not Assigned(qryPodiumSessionGold.Connection) then
    // qryPodiumSessionGold.Connection := SCM.scmConnection;
    // if not Assigned(qryPodiumSessionSilver.Connection) then
    // qryPodiumSessionSilver.Connection := SCM.scmConnection;
    // if not Assigned(qryPodiumSessionBronze.Connection) then
    // qryPodiumSessionBronze.Connection := SCM.scmConnection;
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

procedure TRPTS.PreparePodium(SessionID: integer);
begin
  if Assigned(SCM) then
  begin
    if not Assigned(qryPodiumGold.Connection) then
      qryPodiumGold.Connection := SCM.scmConnection;
    if qryPodiumGold.Active then
      qryPodiumGold.close;
    qryPodiumGold.ParamByName('SESSIONID').AsInteger := SessionID;
    qryPodiumGold.Prepare;
    qryPodiumGold.Open;
    if not Assigned(qryPodiumSilver.Connection) then
      qryPodiumSilver.Connection := SCM.scmConnection;
    if qryPodiumSilver.Active then
      qryPodiumSilver.close;
    qryPodiumSilver.ParamByName('SESSIONID').AsInteger := SessionID;
    qryPodiumSilver.Prepare;
    qryPodiumSilver.Open;
    if not Assigned(qryPodiumBronze.Connection) then
      qryPodiumBronze.Connection := SCM.scmConnection;
    if qryPodiumBronze.Active then
      qryPodiumBronze.close;
    qryPodiumBronze.ParamByName('SESSIONID').AsInteger := SessionID;
    qryPodiumBronze.Prepare;
    qryPodiumBronze.Open;
  end;
end;



end.
