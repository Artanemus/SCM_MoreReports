unit frmMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, dmSCM, Vcl.StdCtrls, Vcl.DBCtrls,
  Vcl.ExtCtrls, Vcl.VirtualImage, Vcl.BaseImageCollection, Vcl.ImageCollection,
  Vcl.Buttons, System.ImageList, Vcl.ImgList, Vcl.VirtualImageList, dmRPTS,
  Vcl.Themes, Vcl.ComCtrls;

type
  TMain = class(TForm)
    Panel1: TPanel;
    DBtxtSwimClubCaption: TDBText;
    DBtxtSwimClubNickName: TDBText;
    DBtxtStartOfSwimSeason: TDBText;
    ImageCollection1: TImageCollection;
    VirtualImage1: TVirtualImage;
    VirtualImageList1: TVirtualImageList;
    spbRefresh: TSpeedButton;
    Panel2: TPanel;
    lblMembershipcardHeader: TLabel;
    Label2: TLabel;
    btnDesignMembershipCard: TButton;
    btnDesignPodium: TButton;
    lblMembershipCardDetail: TLabel;
    Panel3: TPanel;
    Panel4: TPanel;
    Label1: TLabel;
    btnMembershipCards: TButton;
    Panel9: TPanel;
    Button6: TButton;
    ProgressBar1: TProgressBar;
    sbtnInfo: TSpeedButton;
    sbtnOptions: TSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnMembershipCardsClick(Sender: TObject);
    procedure btnDesignMembershipCardClick(Sender: TObject);
    procedure btnPodiumCertificatesClick(Sender: TObject);
    procedure btnDesignPodiumClick(Sender: TObject);
    procedure sbtnInfoClick(Sender: TObject);
    procedure sbtnOptionsClick(Sender: TObject);
  private
    { Private declarations }
    fSwimClubID, fMaxAllowToPick: integer;
    fdefaultStyleName, fCustRptMemShip: string;
    fCustRptCertifGOLD, fCustRptCertifSILVER, fCustRptCertifBRONZE: string;

    // inifiles section name
    fSectionName: string;

    // P R E F E R E N C E   F I L E   A C C E S S .
    procedure ReadPreferences(iniFileName: string);

  public
    { Public declarations }
  end;

var
  Main: TMain;

implementation

{$R *.dfm}

uses dlgBasicLogin, exeinfo, SCMUtility, dlgAbout, System.IniFiles, System.UITypes,
  System.DateUtils, FireDAC.Stan.Param, dlgMembership, dlgPickMember,
  dlgPickCertif, System.Contnrs, dlgDesignCertif, dlgPref;

procedure TMain.btnDesignMembershipCardClick(Sender: TObject);
//var
//  iniFileName: string;
//  iFile: TIniFile;
begin
  if Assigned(RPTS) then
  begin
    // set style to default - designer looks better.
    if Assigned(TStyleManager.ActiveStyle) and
      (TStyleManager.ActiveStyle.Name <> 'Windows') then
    begin
      TStyleManager.TrySetStyle('Windows');
    end;
    RPTS.frxRptMembership.DesignReport(True);
    // restore application
    if Assigned(TStyleManager.ActiveStyle) then
      TStyleManager.TrySetStyle(fdefaultStyleName);

    // update customisation filename...
    fCustRptMemShip := LoadSharedIniFileSetting(fSectionName, 'CustRptMemShip');

//    iniFileName := GetSCMPreferenceFileName;
//    if FileExists(iniFileName) then
//    begin
//      iFile := TIniFile.create(iniFileName);
//      fCustRptMemShip := iFile.ReadString(IniSectionName, 'CustRptMemShip', '');
//      iFile.free;
//    end;

  end;
end;

procedure TMain.FormCreate(Sender: TObject);
var
  aBasicLogin: TBasicLogin;
  result: TmodalResult;
  iniFileName: string;
begin
  // ----------------------------------------------------
  // C R E A T E   D A T A M O D U L E   S C M .
  // ----------------------------------------------------
  try
    SCM := TSCM.create(Self);
  finally
    // with SCM created and the essential tables are open then
    // asserting the connection should be true
    if not Assigned(SCM) then
    begin
      MessageDlg('The SCM connection couldn''t be created!', mtError,
        [mbOk], 0);
      Application.Terminate;
    end;
  end;

  if not Assigned(SCM) then
    Exit;
  // ----------------------------------------------------
  // C O N N E C T   T O   S E R V E R .
  // ----------------------------------------------------
  aBasicLogin := TBasicLogin.create(Self);
  aBasicLogin.DBName := 'SwimClubMeet';
  aBasicLogin.DBConnection := SCM.scmConnection;
  result := aBasicLogin.ShowModal;
  aBasicLogin.free;

  if (result = mrAbort) or (result = mrCancel) then
  begin
    Application.Terminate;
    Exit;
  end;

  // ----------------------------------------------------
  // C R E A T E   D A T A M O D U L E   R P T S .
  // ----------------------------------------------------
  try
    RPTS := TRPTS.create(Self);
  finally
    // with SCM created and the essential tables are open then
    // asserting the connection should be true
    if not Assigned(RPTS) then
    begin
      MessageDlg('The report module couldn''t be created!', mtError,
        [mbOk], 0);
      Application.Terminate;
    end;
  end;

  if not Assigned(RPTS) then
    Exit;

  // ----------------------------------------------------
  // A C T I V A T E   S C M  .
  // ----------------------------------------------------
  SCM.ActivateTable();

  // A S S E R T .
  if not SCM.IsActive then
  begin
    MessageDlg('An error occurred during MSSQL table activation.' + sLineBreak +
      'The database''s schema may need updating.' + sLineBreak +
      'The application will terminate!', mtError, [mbOk], 0);
    // note: cleans and destroys SCM
    Application.Terminate;
  end;


  // ----------------------------------------------------
  // A C T I V A T E   R P T S .
  // ----------------------------------------------------
  {TODO -oBSA -cGeneral : Create RPTS activation routine}
  RPTS.qrySharedHeader.Connection := SCM.scmConnection;
  RPTS.qryMember.Connection := SCM.scmConnection;

  // ----------------------------------------------------
  // I N I T I A L I Z E   P A R A M S .
  // ----------------------------------------------------
  Application.ShowHint := True; // enable hints
  fSwimClubID := 1;
  fMaxAllowToPick := 20;
  fCustRptMemShip := '';
  fCustRptCertifGOLD := '';
  fCustRptCertifSILVER := '';
  fCustRptCertifBRONZE := '';
  fSectionName := 'MoreReports';

  // ----------------------------------------------------
  // R E A D   P R E F E R E N C E S .
  // ----------------------------------------------------
  iniFileName := GetSCMPreferenceFileName;
  if FileExists(iniFileName) then
  begin
    ReadPreferences(iniFileName);
  end;

  // ----------------------------------------------------
  // D I S P L A Y   H E A D E R   I N F O .
  // ----------------------------------------------------
  if fSwimClubID <> 0 then
  begin
    SCM.qryLBHeader.Connection := SCM.scmConnection;
    SCM.qryLBHeader.ParamByName('SWIMCLUBID').AsInteger := fSwimClubID;
    SCM.qryLBHeader.Prepare;
    SCM.qryLBHeader.Open;
  end;
  if SCM.qryLBHeader.Active then
  begin
    DBtxtSwimClubCaption.DataSource := SCM.dsLBHeader;
    DBtxtSwimClubNickName.DataSource := SCM.dsLBHeader;
    DBtxtStartOfSwimSeason.DataSource := SCM.dsLBHeader;
  end;
  Application.ShowHint := True;
  // store the current theme
  if Assigned(TStyleManager.ActiveStyle) then
    fdefaultStyleName := TStyleManager.ActiveStyle.Name;

end;

procedure TMain.FormDestroy(Sender: TObject);
begin
  // de-activate RPTS (FastReport)
  if Assigned(RPTS) then
  begin
    FreeAndNil(RPTS);
  end;
  // de-activete SCM DataModule
  if Assigned(SCM) then
  begin
    SCM.scmConnection.Close;
    FreeAndNil(SCM);
  end;
end;

procedure TMain.ReadPreferences(iniFileName: string);
var
  iFile: TIniFile;
begin
  iFile := TIniFile.create(iniFileName);
  fMaxAllowToPick := iFile.ReadInteger(fSectionName, 'MaxAllowToPick', 20);
  fCustRptCertifGOLD := iFile.ReadString(fSectionName,
    'CustRptCertifGOLD', '');
  fCustRptCertifSILVER := iFile.ReadString(fSectionName,
    'CustRptCertifSILVER', '');
  fCustRptCertifBRONZE := iFile.ReadString(fSectionName,
    'CustRptCertifBRONZE', '');
  fCustRptMemShip := iFile.ReadString(fSectionName, 'CustRptMemShip', '');
  iFile.free;
  // ----------------------------------------------------
  // Load customized report
  // if the FileName is empty, then the default report design is used.
  // ----------------------------------------------------
  if Assigned(RPTS) then
  begin
    if Length(fCustRptMemShip) > 0 then
    BEGIN
      if FileExists(fCustRptMemShip) then
        RPTS.frxRptMembership.LoadFromFile(fCustRptMemShip);
    END;
    if Length(fCustRptCertifGOLD) > 0 then
    begin
      if FileExists(fCustRptCertifGOLD) then
        RPTS.frxRptGold.LoadFromFile(fCustRptCertifGOLD);
    end;
    if Length(fCustRptCertifSILVER) > 0 then
    begin
      if FileExists(fCustRptCertifSILVER) then
        RPTS.frxRptSilver.LoadFromFile(fCustRptCertifSILVER);
    end;
    if Length(fCustRptCertifBRONZE) > 0 then
    begin
      if FileExists(fCustRptCertifBRONZE) then
        RPTS.frxRptBronze.LoadFromFile(fCustRptCertifBRONZE);
    end;
  end;

end;

procedure TMain.sbtnInfoClick(Sender: TObject);
var
  dlg: TAbout;
begin
  dlg := TAbout.create(Self);
  dlg.ShowModal;
  dlg.free;
end;

procedure TMain.sbtnOptionsClick(Sender: TObject);
var
  dlg: TPref;
  iniFileName: string;
begin
  dlg := TPref.create(Self);
  dlg.ShowModal;
  dlg.free;
  // ----------------------------------------------------
  // R E - R E A D   P R E F E R E N C E S .
  // ----------------------------------------------------
  iniFileName := GetSCMPreferenceFileName;
  if FileExists(iniFileName) then
  begin
    ReadPreferences(iniFileName);
  end;
end;

procedure TMain.btnPodiumCertificatesClick(Sender: TObject);
var
  dlg: TPickCertif;
  dlg2: TDesignCertif;
  SessionID: integer;
begin
  if not Assigned(SCM) then
    Exit;
  if not Assigned(RPTS) then
    Exit;

  dlg := TPickCertif.create(Self);
  if IsPositiveResult(dlg.ShowModal) then
  begin
    SessionID := dlg.GetCurrSessionID;
    if SessionID = 0 then
      Exit;
    // prepare and open gold, silver, bronze podium queries
    RPTS.PreparePodium(SessionID);
    // Assign Filters
    RPTS.qryPodiumGold.Filter := dlg.GetGoldFilterStr;
    RPTS.qryPodiumSilver.Filter := dlg.GetSilverFilterStr;
    RPTS.qryPodiumBronze.Filter := dlg.GetBronzeFilterStr;
    // Asset - enable filters
    if not RPTS.qryPodiumGold.Filtered then
      RPTS.qryPodiumGold.Filtered := True;
    if not RPTS.qryPodiumSilver.Filtered then
      RPTS.qryPodiumSilver.Filtered := True;
    if not RPTS.qryPodiumBronze.Filtered then
      RPTS.qryPodiumBronze.Filtered := True;

    // Fianlly - prepare report ...
    RPTS.frxRptGold.PrepareReport();
    RPTS.frxRptSilver.PrepareReport();
    RPTS.frxRptBronze.PrepareReport();
    // finished with dialogue - dispose off
    FreeAndNil(dlg);
    // display dialogue to preview, print, export
    dlg2 := TDesignCertif.create(Self);
    dlg2.ShowModal;
    dlg2.free;
  end;
  if Assigned(dlg) then
    dlg.free;
end;

procedure TMain.btnDesignPodiumClick(Sender: TObject);
var
  dlg: TDesignCertif;
begin
  if Assigned(RPTS) then
  begin
    dlg := TDesignCertif.create(Self);
    dlg.doPodiumDesign := True;
    if Assigned(SCM) then
      // Finds a session with 1st,2nd,3rd place holders...
      // so FastReport preview has some data to display.
      dlg.SessionID := SCM.GetSampleSessionID;
    // prepare and open gold, silver, bronze podium queries
    RPTS.PreparePodium(dlg.SessionID);
    dlg.ShowModal;
    dlg.free;
  end;
end;

procedure TMain.btnMembershipCardsClick(Sender: TObject);
var
  dlg: TMembership;
  dlgMP: TPickMember;
  TagNum, I, J: integer;
  doGenerate, doPrefix: Boolean;
  filterStr, s: string;
  obj: TscmMember;
begin

  if (not Assigned(SCM)) or (not Assigned(RPTS)) then
    Exit;

  dlg := TMembership.create(Self);
  if IsPositiveResult(dlg.ShowModal) then
  begin
    TagNum := dlg.TagNum;
    doGenerate := dlg.chkboxGenerateNum.Checked;

    if doGenerate then
    begin
      SCM.GenerateMembershipNums(fSwimClubID);
    end;

    case TagNum of
      1:
        begin
          // WITHIN A DATE RANGE ...
          // -----------------------------------
          if (RPTS.qryMember.Filtered) then
            RPTS.qryMember.Filtered := false;
          RPTS.PrepareMembership(dlg.calDateFrom.Date,
            dlg.calDateTo.Date, True);
          FreeAndNil(dlg);
          RPTS.frxRptMembership.PrepareReport();
          RPTS.frxRptMembership.ShowReport();
        end;
      2:
        begin
          // USER PICKS MEMBERS FROM LIST ...
          // -----------------------------------
          FreeAndNil(dlg); // finished with dlg.
          // create the quick pick dlg ...
          dlgMP := TPickMember.create(Self);
          if IsPositiveResult(dlgMP.ShowModal) then
          begin
            // prepare - all swimmers
            RPTS.PrepareMembership(0, 0, false);
            // build a members' list for filtering.
            filterStr := '';
            doPrefix := false;
            J := 0;

            // limit to 20xCards (2xA4 pages)
            // --------------------------------
            if dlgMP.lboxR.count > fMaxAllowToPick then
            begin
              MessageDlg('You have exceeded the allowed amount of members!' +
                sLineBreak + 'Only the first ' + IntToStr(fMaxAllowToPick) +
                ' will appear in the report.' + sLineBreak +
                '(This limit can be changed in the config file.)',
                TMsgDlgType.mtWarning, [mbOk], 0);
            end;

            for I := 0 to dlgMP.lboxR.count - 1 do
            begin
              s := 'MemberID = ';
              obj := dlgMP.lboxR.Items.Objects[I] as TscmMember;
              s := s + IntToStr(obj.ID);
              // first iteration doesn't require prefix
              if doPrefix then
                filterStr := filterStr + ' OR ' + s
              else
                filterStr := filterStr + s;
              doPrefix := True;
              J := J + 1;
              if J > fMaxAllowToPick then
                break;
            end;
            if (Length(filterStr) > 0) then
            begin
              try
                RPTS.qryMember.Filter := filterStr;
                RPTS.qryMember.Filtered := True;
                RPTS.frxRptMembership.PrepareReport();
                RPTS.frxRptMembership.ShowReport();
              finally
                // disable filtering on query
                if (RPTS.qryMember.Filtered) then
                  RPTS.qryMember.Filtered := false;
                RPTS.qryMember.Filter := '';
              end;
            end;

          end;
          FreeAndNil(dlgMP); // finished with quick pick dlg.
        end;
      3:
        begin
          // ALL ACTIVE SWIMMERS ...
          // -----------------------------------
          if (RPTS.qryMember.Filtered) then
            RPTS.qryMember.Filtered := false;
          FreeAndNil(dlg); // finished with dlg
          RPTS.PrepareMembership(0, 0, false);
          RPTS.frxRptMembership.PrepareReport();
          // no PREVIEW assignment needed ...
          RPTS.frxRptMembership.ShowReport();
        end;
    else
      // do nothing
    end;
  end;

  if Assigned(dlg) then
    dlg.free;

end;

end.
