USE SwimClubMeet;

DECLARE @EventID AS INTEGER;
SET @EventID = 506;

SELECT TOP 3
       [Event].[EventID]
     , [EventNum]
     , [Event].[Caption] AS DetailStr
     , [Event].[SessionID]
     , [EventTypeID]
     , [Event].[StrokeID]
     , [Event].[DistanceID]
     , [EventStatusID]
     , CONCAT(distance.Caption, ' - ', Stroke.Caption) AS EventStr
     , Session.Caption AS SessionStr
     , CONCAT(FirstName, ' ', LastName) AS FullName
     , dbo.SwimTimeToString(RaceTime) AS RaceTimeStr
     , RaceTime
     , EntrantID
     ,CAST(CAST(racetime AS DATETIME) AS FLOAT)  as fl
FROM [SwimClubMeet].[dbo].[Event]
    INNER JOIN Distance
        ON [Event].DistanceID = Distance.DistanceID
    INNER JOIN Stroke
        ON [Event].StrokeID = Stroke.StrokeID
    INNER JOIN [Session]
        ON [Event].[SessionID] = [Session].[SessionID]
    INNER JOIN HeatIndividual
        ON [Event].EventID = HeatIndividual.EventID
    INNER JOIN entrant
        ON HeatIndividual.HeatID = Entrant.HeatID
    INNER JOIN Member
        ON Entrant.MemberID = Member.MemberID
WHERE racetime IS NOT NULL
and CAST(CAST(RaceTime AS DATETIME) AS FLOAT) <> 0 -- resolves assigned 00:00:00.000
      AND entrant.MemberID IS NOT NULL
      AND IsDisqualified <> 1
      AND IsScratched <> 1
      AND [Event].EventID = @EventID
ORDER BY racetime ASC