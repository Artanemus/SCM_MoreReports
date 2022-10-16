unit dmSCM;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, FireDAC.UI.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Phys, FireDAC.VCLUI.Wait, FireDAC.Phys.MSSQL,
  FireDAC.Phys.MSSQLDef, System.Variants, DateUtils;

type
  TSCM = class(TDataModule)
    scmConnection: TFDConnection;
    qrySwimClub: TFDQuery;
    dsSwimClub: TDataSource;
    qrySession: TFDQuery;
    dsSession: TDataSource;
    qryLBHeader: TFDQuery;
    dsLBHeader: TDataSource;
    qryGetStartOfSession: TFDQuery;
    dsGetStartOfSession: TDataSource;
    qryGetSessionCount: TFDQuery;
    qryGenerateList: TFDQuery;
    procedure DataModuleCreate(Sender: TObject);

  private
    { Private declarations }
    FIsActive: boolean;

  public
    { Public declarations }
    function GetStartOfSwimmingSeason(SwimClubID: integer): TDateTime;
    function GetStartOfSession(SessionID: integer): TDateTime;
    function GetSessionCount(SwimClubID: integer;
      SDate, EDate: TDateTime): integer;
    procedure ActivateTable();
    procedure SimpleLoadSettingString(Section, Name: string; var Value: string);
    procedure SimpleMakeTemporyFDConnection(Server, User, Password: string;
      OsAuthent: boolean);
    procedure SimpleSaveSettingString(Section, Name, Value: string);
    procedure GenerateMembershipNums(SwimClubID: integer);

    property IsActive: boolean read FIsActive write FIsActive;
  end;

const
  SCMCONFIGFILENAME = 'SCMConfig.ini';

var
  SCM: TSCM;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}
{$R *.dfm}

uses
  System.IOUtils, IniFiles;

{$REGION  SIMPLE TEMPORY CONNECTION AND INIFILES CONFIGURATION}

procedure TSCM.ActivateTable;
begin
  // TODO: activate all the tables on the form ?....
  FIsActive := true;
end;

procedure TSCM.DataModuleCreate(Sender: TObject);
begin
  ActivateTable;
end;

procedure TSCM.GenerateMembershipNums(SwimClubID: integer);
var
  i: integer;
  bm: TBookmark;
begin
  // generate a membership number for null fields.
  if not Assigned(qryGenerateList.connection) then
    qryGenerateList.connection := scmConnection;
  try
    if qryGenerateList.active then
      qryGenerateList.Close;
    qryGenerateList.ParamByName('SWIMCLUBID').AsInteger := SwimClubID;
    qryGenerateList.Prepare;
    qryGenerateList.Open;
    if qryGenerateList.active then
    begin
      while (not qryGenerateList.eof) do
      begin
        if qryGenerateList.FieldByName('MembershipNum').IsNull then
        begin
          i := qryGenerateList.FieldByName('MemberID').AsInteger;
          bm := qryGenerateList.GetBookmark;
          i := 1000 + i;
          // locate membership num
          if qryGenerateList.Locate('MembershipNum', i, []) then
          begin
            // membership number in use...
            // TODO: build unique number...
          end
          else
          begin
            qryGenerateList.GotoBookmark(bm);
            qryGenerateList.edit;
            qryGenerateList.FieldByName('MembershipNum').AsInteger := i;
            qryGenerateList.post;
          end;
        end;
        qryGenerateList.Next;
      end;
    end;
  finally
    qryGenerateList.Close;
  end;

end;

function TSCM.GetSessionCount(SwimClubID: integer;
  SDate, EDate: TDateTime): integer;
begin
  result := 0;
  if qryGetSessionCount.active then
    qryGetSessionCount.Close;
  qryGetSessionCount.ParamByName('SWIMCLUBID').AsInteger := SwimClubID;
  qryGetSessionCount.ParamByName('SDATE').AsDateTime := SDate;
  qryGetSessionCount.ParamByName('EDATE').AsDateTime := EDate;
  qryGetSessionCount.Prepare;
  qryGetSessionCount.Open;
  if qryGetSessionCount.active then
  begin
    if not qryGetSessionCount.IsEmpty then
    begin
      result := qryGetSessionCount.FieldByName('SessionCount').AsInteger;
    end;
  end;

end;

function TSCM.GetStartOfSession(SessionID: integer): TDateTime;
begin
  result := Date;
  if qryGetStartOfSession.active then
    qryGetStartOfSession.Close;
  qryGetStartOfSession.ParamByName('SESSIONID').AsInteger := SessionID;
  qryGetStartOfSession.Prepare;
  qryGetStartOfSession.Open;
  if qryGetStartOfSession.active then
  begin
    if not qryGetStartOfSession.IsEmpty then
    begin
      result := qryGetStartOfSession.FieldByName('SessionStart').AsDateTime;
    end;
  end;
end;

function TSCM.GetStartOfSwimmingSeason(SwimClubID: integer): TDateTime;
var
  dt: TDateTime;
begin
  result := Date();
  if SwimClubID > 0 then
  begin
    if qrySwimClub.active then
      qrySwimClub.Close;
    qrySwimClub.ParamByName('SWIMCLUBID').AsInteger := SwimClubID;
    qrySwimClub.Prepare;
    qrySwimClub.Open;
    if qrySwimClub.active then
    begin
      if not qrySwimClub.IsEmpty then
      begin
        dt := qrySwimClub.FieldByName('StartOfSwimSeason').AsDateTime;
        // If ANow and AThen are two and a half years apart,
        // calling WithinPastYears with AYears set to 2 returns True.
        if WithinPastYears(result, dt, 1) then
          result := dt;
      end;
    end;
  end;
end;

procedure TSCM.SimpleLoadSettingString(Section, Name: string;
  var Value: string);
var
  ini: TIniFile;
begin
  ini := TIniFile.Create(TPath.GetDocumentsPath + PathDelim +
    SCMCONFIGFILENAME);
  try
    Value := ini.ReadString(Section, name, '');
  finally
    ini.Free;
  end;
end;

procedure TSCM.SimpleMakeTemporyFDConnection(Server, User, Password: string;
  OsAuthent: boolean);
var
  Value, Section: string;
begin
  if (scmConnection.Connected) then
  begin
    scmConnection.Close();
  end;

  scmConnection.Params.Add('Server=' + Server);
  scmConnection.Params.Add('DriverID=MSSQL');
  scmConnection.Params.Add('Database=SwimClubMeet');
  scmConnection.Params.Add('User_name=' + User);
  scmConnection.Params.Add('Password=' + Password);
  if (OsAuthent) then
    Value := 'Yes'
  else
    Value := 'No';
  scmConnection.Params.Add('OSAuthent=' + Value);
  scmConnection.Params.Add('Mars=yes');
  scmConnection.Params.Add('MetaDefSchema=dbo');
  scmConnection.Params.Add('ExtendedMetadata=False');
  scmConnection.Params.Add('ApplicationName=scmTimeKeeper');
  scmConnection.Connected := true;

  // ON SUCCESS - Save connection details.
  if (scmConnection.Connected) then
  begin
    Section := 'MSSQL_SwimClubMeet';
    Name := 'Server';
    SimpleSaveSettingString(Section, Name, Server);
    Name := 'User';
    SimpleSaveSettingString(Section, Name, User);
    Name := 'Password';
    SimpleSaveSettingString(Section, Name, Password);
    Name := 'OSAuthent';
    SimpleSaveSettingString(Section, Name, Value);
  end
end;

procedure TSCM.SimpleSaveSettingString(Section, Name, Value: string);
var
  ini: TIniFile;
begin
  ini := TIniFile.Create(TPath.GetDocumentsPath + PathDelim +
    SCMCONFIGFILENAME);
  try
    ini.WriteString(Section, Name, Value);
  finally
    ini.Free;
  end;

end;

{$REGION end}

end.
