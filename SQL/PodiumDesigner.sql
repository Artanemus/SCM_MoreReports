USE SwimClubMeet;
-- returns a 'safe' session with entrants and racetimes ... for Podium designer.
SELECT TOP 1 [Session].SessionID
,Count([Event].[EventID]) as eventCount
     , COUNT(EntrantId) AS entrantCount
FROM [Session]
    INNER JOIN [Event]
        ON [Session].[SessionID] = [Event].[SessionID]
    INNER JOIN [HeatIndividual]
        ON [Event].[EventID] = [HeatIndividual].[EventID]
    INNER JOIN [Entrant]
        ON [HeatIndividual].[HeatID] = [Entrant].[HeatID]
WHERE Entrant.MemberID IS NOT NULL
      AND [Session].SessionStatusID <> 2
      AND racetime IS NOT NULL
      AND CAST(CAST(RaceTime AS DATETIME) AS FLOAT) <> 0 -- resolves assigned 00:00:00.000
      AND IsDisqualified <> 1
      AND IsScratched <> 1
      AND dbo.ABSEventPlace([Event].[EventID], Entrant.MemberID) =3 
GROUP BY [Session].SessionID
ORDER BY eventCount ASC