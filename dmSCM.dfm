object SCM: TSCM
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 394
  Width = 607
  object scmConnection: TFDConnection
    Params.Strings = (
      'ConnectionDef=MSSQL_SwimClubMeet')
    ConnectedStoredUsage = [auDesignTime]
    Connected = True
    LoginPrompt = False
    Left = 96
    Top = 40
  end
  object qrySwimClub: TFDQuery
    IndexFieldNames = 'SwimClubID'
    Connection = scmConnection
    FormatOptions.AssignedValues = [fvFmtDisplayDateTime]
    FormatOptions.FmtDisplayDateTime = 'dd/mm/yy HH:NN'
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert, uvEUpdate]
    UpdateOptions.EnableDelete = False
    UpdateOptions.EnableInsert = False
    UpdateOptions.EnableUpdate = False
    SQL.Strings = (
      'USE [SwimClubMeet];'
      ''
      'DECLARE @SwimClubID AS INT;'
      ''
      'SET @SwimClubID = :SWIMCLUBID;'
      ''
      'IF @SwimClubID IS NULL'
      #9'SET @SwimClubID = 1;'
      ''
      'SELECT [SwimClubID]'
      #9',[NickName]'
      #9',[Caption]'
      #9',[Email]'
      #9',[ContactNum]'
      #9',[WebSite]'
      #9',[HeatAlgorithm]'
      #9',[EnableTeamEvents]'
      #9',[EnableSwimOThon]'
      #9',[EnableExtHeatTypes]'
      #9',[EnableMembershipStr]'
      #9',[NumOfLanes]'
      #9',[LenOfPool]'
      #9',[StartOfSwimSeason]'
      #9',[CreatedOn]'
      'FROM [dbo].[SwimClub]'
      'WHERE SwimClubID = @SwimClubID;')
    Left = 88
    Top = 160
    ParamData = <
      item
        Name = 'SWIMCLUBID'
        DataType = ftInteger
        ParamType = ptInput
        Value = 1
      end>
  end
  object dsSwimClub: TDataSource
    DataSet = qrySwimClub
    Left = 152
    Top = 160
  end
  object qrySession: TFDQuery
    Connection = scmConnection
    FormatOptions.AssignedValues = [fvFmtDisplayDateTime, fvFmtDisplayDate, fvFmtDisplayTime]
    FormatOptions.FmtDisplayDateTime = 'dd/mm/yy HH:MM'
    FormatOptions.FmtDisplayDate = 'dd/mm/yyyy'
    FormatOptions.FmtDisplayTime = 'nn:ss.zzz'
    SQL.Strings = (
      'USE SwimClubMeet'
      ''
      'DECLARE @SwimClubID AS INT;'
      'SET @SwimClubID = :SWIMCLUBID;'
      ''
      'SELECT Session.SessionID'
      #9',Session.SessionStart'
      #9',Session.SwimClubID'
      #9',Session.SessionStatusID'
      #9',SessionStatus.Caption AS StatusStr'
      #9',Session.Caption'
      'FROM Session'
      
        'LEFT OUTER JOIN SessionStatus ON Session.SessionStatusID = Sessi' +
        'onStatus.SessionStatusID'
      'WHERE SwimClubID = @SwimClubID AND Session.SessionStatusID <> 2'
      'ORDER BY Session.SessionStart DESC')
    Left = 88
    Top = 256
    ParamData = <
      item
        Name = 'SWIMCLUBID'
        DataType = ftInteger
        ParamType = ptInput
        Value = 1
      end>
  end
  object dsSession: TDataSource
    DataSet = qrySession
    Left = 152
    Top = 256
  end
  object qryLBHeader: TFDQuery
    ActiveStoredUsage = [auDesignTime]
    IndexFieldNames = 'SwimClubID'
    Connection = scmConnection
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert, uvEUpdate]
    UpdateOptions.EnableDelete = False
    UpdateOptions.EnableInsert = False
    UpdateOptions.EnableUpdate = False
    UpdateOptions.KeyFields = 'SwimClubID'
    SQL.Strings = (
      'USE SwimClubMeet;'
      ''
      'DECLARE @SwimClubID AS INTEGER;'
      'SET @SwimClubID = :SWIMCLUBID;'
      ''
      ''
      'SELECT '
      #9#9' [SwimClubID]'
      #9#9',[NickName]'
      #9#9',[Caption]'
      #9#9',[StartOfSwimSeason]'
      
        '        , Concat('#39'Start of swimming season: '#39', Format(StartOfSwi' +
        'mSeason, '#39'MMMM dd, yyyy'#39', '#39'en-AU'#39')) as CaptionStr'
      ''
      '/* '#9#9',[Email]'
      #9#9',[ContactNum]'
      #9#9',[WebSite]'
      #9#9',[HeatAlgorithm]'
      #9#9',[EnableTeamEvents]'
      #9#9',[EnableSwimOThon]'
      #9#9',[EnableExtHeatTypes]'
      #9#9',[EnableMembershipStr]'
      #9#9',[NumOfLanes]'
      #9#9',[LenOfPool]'
      #9#9',[CreatedOn] */'
      'FROM [SwimClubMeet].[dbo].[SwimClub]'
      'WHERE SwimClubID = @SwimClubID; ')
    Left = 88
    Top = 104
    ParamData = <
      item
        Name = 'SWIMCLUBID'
        DataType = ftInteger
        ParamType = ptInput
        Value = 1
      end>
  end
  object dsLBHeader: TDataSource
    AutoEdit = False
    DataSet = qryLBHeader
    Left = 151
    Top = 104
  end
  object qryGetStartOfSession: TFDQuery
    Connection = scmConnection
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert, uvEUpdate]
    UpdateOptions.EnableDelete = False
    UpdateOptions.EnableInsert = False
    UpdateOptions.EnableUpdate = False
    SQL.Strings = (
      'USE SwimClubMeet;'
      'DECLARE @SessionID AS INTEGER;'
      'SET @SessionID = :SESSIONID;'
      ''
      
        '-- Select rows from a Table or View '#39'[Session]'#39' in schema '#39'[dbo]' +
        #39
      'SELECT SessionStart'
      'FROM [dbo].[Session]'
      'WHERE SessionID = @SessionID;')
    Left = 304
    Top = 64
    ParamData = <
      item
        Name = 'SESSIONID'
        DataType = ftInteger
        ParamType = ptInput
        Value = 70
      end>
  end
  object dsGetStartOfSession: TDataSource
    DataSet = qryGetStartOfSession
    Left = 448
    Top = 64
  end
  object qryGetSessionCount: TFDQuery
    ActiveStoredUsage = [auDesignTime]
    Connection = scmConnection
    SQL.Strings = (
      'USE SwimClubMeet;'
      ''
      'DECLARE @SDate AS DATETIME;'
      'DECLARE @EDate AS DATETIME;'
      'DECLARE @SwimClubID AS INTEGER;'
      ''
      ''
      'SET @SDate = :SDATE; --'#39'2021-01-01'#39';'
      'SET @EDate = :EDATE; --'#39'2022-01-20'#39';'
      'SET @SwimClubID = :SWIMCLUBID;'
      ''
      'WITH myCTE'
      'AS (SELECT COUNT(*) AS RowsInView'
      '    FROM [dbo].[Session]'
      '    WHERE [Session].SessionStart >= @SDate'
      
        '          AND [Session].SessionStart <= @EDate AND [Session].Swi' +
        'mClubID = @SwimClubID)'
      'SELECT myCTE.RowsInView AS SessionCount'
      'FROM myCTE;')
    Left = 312
    Top = 136
    ParamData = <
      item
        Name = 'SDATE'
        DataType = ftDateTime
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'EDATE'
        DataType = ftDateTime
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'SWIMCLUBID'
        DataType = ftInteger
        ParamType = ptInput
        Value = 1
      end>
  end
  object qryGenerateList: TFDQuery
    IndexFieldNames = 'MemberID'
    Connection = scmConnection
    UpdateOptions.KeyFields = 'MemberID'
    SQL.Strings = (
      'Use SwimClubMeet;'
      'DECLARE @SwimClubID AS INTEGER;'
      'SET @SwimClubID = :SWIMCLUBID;'
      ''
      'SELECT '
      #9#9' [MemberID]'
      #9#9',[MembershipNum]'
      'FROM [SwimClubMeet].[dbo].[Member] '
      'WHERE SwimClubID = @SwimClubID ;')
    Left = 312
    Top = 240
    ParamData = <
      item
        Name = 'SWIMCLUBID'
        DataType = ftInteger
        ParamType = ptInput
        Value = 1
      end>
  end
  object qrySampleSession: TFDQuery
    ActiveStoredUsage = [auDesignTime]
    IndexFieldNames = 'SessionID'
    Connection = scmConnection
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert, uvEUpdate]
    UpdateOptions.EnableDelete = False
    UpdateOptions.EnableInsert = False
    UpdateOptions.EnableUpdate = False
    SQL.Strings = (
      'USE SwimClubMeet;'
      
        '-- returns a '#39'safe'#39' session with entrants and racetimes ... for ' +
        'Podium designer.'
      'SELECT TOP 1 [Session].SessionID'
      ',Count([Event].[EventID]) as eventCount'
      '     , COUNT(EntrantId) AS entrantCount'
      'FROM [Session]'
      '    INNER JOIN [Event]'
      '        ON [Session].[SessionID] = [Event].[SessionID]'
      '    INNER JOIN [HeatIndividual]'
      '        ON [Event].[EventID] = [HeatIndividual].[EventID]'
      '    INNER JOIN [Entrant]'
      '        ON [HeatIndividual].[HeatID] = [Entrant].[HeatID]'
      'WHERE Entrant.MemberID IS NOT NULL'
      '      AND [Session].SessionStatusID <> 2'
      '      AND racetime IS NOT NULL'
      
        '      AND CAST(CAST(RaceTime AS DATETIME) AS FLOAT) <> 0 -- reso' +
        'lves assigned 00:00:00.000'
      '      AND IsDisqualified <> 1'
      '      AND IsScratched <> 1'
      
        '      AND dbo.ABSEventPlace([Event].[EventID], Entrant.MemberID)' +
        ' =3 '
      'GROUP BY [Session].SessionID'
      'ORDER BY eventCount ASC')
    Left = 88
    Top = 320
  end
end
