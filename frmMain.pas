unit frmMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, dmSCM, Vcl.StdCtrls, Vcl.DBCtrls,
  Vcl.ExtCtrls, Vcl.VirtualImage, Vcl.BaseImageCollection, Vcl.ImageCollection,
  Vcl.Buttons, System.ImageList, Vcl.ImgList, Vcl.VirtualImageList, dmRPTS,
  Vcl.Themes;

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
    Label3: TLabel;
    sbtnPodiumCertificates: TSpeedButton;
    sbtnAttendanceRecords: TSpeedButton;
    btnDesignMembershipCard: TButton;
    btnDesignPodium: TButton;
    Button2: TButton;
    lblMembershipCardDetail: TLabel;
    Panel3: TPanel;
    Panel4: TPanel;
    Label1: TLabel;
    Panel5: TPanel;
    Panel6: TPanel;
    SpeedButton1: TSpeedButton;
    Label4: TLabel;
    Button1: TButton;
    Label5: TLabel;
    Panel7: TPanel;
    SpeedButton2: TSpeedButton;
    Label6: TLabel;
    Label7: TLabel;
    Button3: TButton;
    Panel8: TPanel;
    SpeedButton3: TSpeedButton;
    Label8: TLabel;
    Label9: TLabel;
    Button4: TButton;
    btnMembershipCards: TButton;
    Panel9: TPanel;
    Panel10: TPanel;
    SpeedButton4: TSpeedButton;
    Label10: TLabel;
    Label11: TLabel;
    Button5: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnMembershipCardsClick(Sender: TObject);
    procedure btnDesignMembershipCardClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure sbtnPodiumCertificatesClick(Sender: TObject);
  private
    { Private declarations }
    fSwimClubID, fMaxAllowToPick: integer;
    fdefaultStyleName: string;

    procedure ReadPreferences(iniFileName: string);
  public
    { Public declarations }
  end;

var
  Main: TMain;

implementation

{$R *.dfm}

uses dlgBasicLogin, exeinfo, Utility, dlgAbout, System.IniFiles, System.UITypes,
  System.DateUtils, FireDAC.Stan.Param, dlgMembership, dlgPickMember,
  dlgPodiumCertif;

procedure TMain.btnDesignMembershipCardClick(Sender: TObject);
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
    SCM := TSCM.Create(Self);
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
  aBasicLogin := TBasicLogin.Create(Self);
  result := aBasicLogin.ShowModal;
  aBasicLogin.Free;

  if (result = mrAbort) or (result = mrCancel) then
  begin
    Application.Terminate;
    Exit;
  end;
  // ----------------------------------------------------
  // C R E A T E   D A T A M O D U L E   R P T S .
  // ----------------------------------------------------
  RPTS := TRPTS.Create(Self);
  RPTS.qrySharedHeader.Connection := SCM.scmConnection;
  RPTS.qryMember.Connection := SCM.scmConnection;
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
  // I N I T I A L I Z E   P A R A M S .
  // ----------------------------------------------------
  Application.ShowHint := True; // enable hints
  fSwimClubID := 1;
  fMaxAllowToPick := 20;
  // ----------------------------------------------------
  // R E A D   P R E F E R E N C E S .
  // ----------------------------------------------------
  iniFileName := GetSCMPreferenceFileName;
  if FileExists(iniFileName) then
    ReadPreferences(iniFileName);

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

procedure TMain.FormShow(Sender: TObject);
begin
  btnMembershipCards.SetFocus;
end;

procedure TMain.ReadPreferences(iniFileName: string);
var
  iFile: TIniFile;
begin
  iFile := TIniFile.Create(iniFileName);
  fMaxAllowToPick := iFile.ReadInteger('MemberPicker', 'MaxAllowToPick', 20);
  iFile.Free;
end;

procedure TMain.sbtnPodiumCertificatesClick(Sender: TObject);
var
  dlg: TPodiumCertif;
  I, J: integer;
  obj: TPodium;
begin
  if not Assigned(SCM) then
    Exit;
  if not Assigned(RPTS) then
    Exit;

  dlg := TPodiumCertif.Create(Self);
  if IsPositiveResult(dlg.ShowModal) then
  begin
    if not Assigned(RPTS.qryPodiumWinners.Connection) then
      RPTS.qryPodiumWinners.Connection := SCM.scmConnection;
    if RPTS.qryPodiumWinners.Active then
      RPTS.qryPodiumWinners.Close;

    // iterate accross events in podiumlist
    for I := 0 to dlg.PodiumList.Count-1 do
    begin
      obj := dlg.PodiumList.Items[I] as TPodium;
      if obj.fChecked then
      begin
        RPTS.qryPodiumWinners.ParamByName('EVENTID').AsInteger := obj.fEventID;
        RPTS.qryPodiumWinners.Prepare;
        RPTS.qryPodiumWinners.Open;
        // query finds the top three 'fastest' swimmers for the event
        // fastest swimmer - first
        if RPTS.qryPodiumWinners.Active then
        begin
          // assert
          // clear report
          J := 1;
          while not RPTS.qryPodiumWinners.Eof do
          begin
            case J of
              1:
                begin
                  if obj.doGold then
                  begin
                    // assign correct layoutA
                    // report prepare(false) // appended
                  end;
                end;
              2:
                begin
                  if obj.doSilver then
                  begin
                    // assign correct layoutB
                    // report prepareReport(false)  // appended
                  end;

                end;
              3:
                begin
                  if obj.doBronze then
                  begin
                    // assign correct layoutC
                    // report prepareReport(false) // appended
                  end;
                end;
            end;
            J := J + 1;
            RPTS.qryPodiumWinners.Next;
          end;
          // report.ShowReport
        end;
      end;
    end;

  end;
  dlg.Free;
end;

procedure TMain.btnMembershipCardsClick(Sender: TObject);
var
  dlg: TMembership;
  TagNum, I, J: integer;
  doGenerate, doPrefix: Boolean;
  dlgMP: TPickMember;
  filterStr, s: string;
  obj: TscmMember;
begin

  if (not Assigned(SCM)) or (not Assigned(RPTS)) then
    Exit;

  dlg := TMembership.Create(Self);
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
          dlgMP := TPickMember.Create(Self);
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
            if dlgMP.lboxR.Count > fMaxAllowToPick then
            begin
              MessageDlg('You have exceeded the allowed amount of members!' +
                sLineBreak + 'Only the first ' + IntToStr(fMaxAllowToPick) +
                ' will appear in the report.' + sLineBreak +
                '(This limit can be changed in the config file.)',
                TMsgDlgType.mtWarning, [mbOk], 0);
            end;

            for I := 0 to dlgMP.lboxR.Count - 1 do
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
            if (length(filterStr) > 0) then
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
    dlg.Free;

end;

end.
