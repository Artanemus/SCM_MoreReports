USE SwimClubMeet;

DECLARE @SessionID AS INTEGER;
SET @SessionID = 64;

SELECT [Event].[EventID]
     --, dbo.ABSEventPlace([Event].[EventID], Entrant.MemberID) AS Place
     , [Event].[SessionID]
     , [EventNum]
     , CONCAT(distance.Caption, ' - ', Stroke.Caption) AS EventStr
     , [Event].[Caption] AS EventDetailStr
     , CONCAT(FirstName, ' ', LastName) AS FullName
     , dbo.SwimTimeToString(RaceTime) AS RaceTimeStr
     , [Session].Caption AS SessionStr
     , FORMAT(SessionStart, 'ddd, dd MMM yyyy') AS SessionDate
FROM [SwimClubMeet].[dbo].[Session]
    INNER JOIN [Event]
        ON [Session].SessionID = [Event].SessionID
    INNER JOIN Distance
        ON [Event].DistanceID = Distance.DistanceID
    INNER JOIN Stroke
        ON [Event].StrokeID = Stroke.StrokeID
    INNER JOIN HeatIndividual
        ON [Event].EventID = HeatIndividual.EventID
    INNER JOIN entrant
        ON HeatIndividual.HeatID = Entrant.HeatID
    INNER JOIN Member
        ON Entrant.MemberID = Member.MemberID
WHERE [Session].SessionID = @SessionID
      AND [Session].SessionStatusID <> 2
      AND racetime IS NOT NULL
      AND CAST(CAST(RaceTime AS DATETIME) AS FLOAT) <> 0 -- resolves assigned 00:00:00.000
      AND entrant.MemberID IS NOT NULL
      AND IsDisqualified <> 1
      AND IsScratched <> 1
      AND dbo.ABSEventPlace([Event].[EventID], Entrant.MemberID) = 3
ORDER BY EventNum ASC