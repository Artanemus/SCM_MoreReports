Use SwimClubMeet;

-- Drop the table if it already exists
IF OBJECT_ID('tempDB..#tmp', 'U') IS NOT NULL
DROP TABLE #tmp
;

-- Find the first ever race that the member participated in.
-- Must have racetime.
-- Get session date.
SELECT 
		 [MemberID]
        ,Min([Session].SessionStart) as minDT
        INTO #tmp
FROM [SwimClubMeet].[dbo].[Entrant] 
INNER JOIN HeatIndividual on Entrant.HeatID = HeatIndividual.HeatID
INNER JOIN event ON HeatIndividual.EventID = Event.EventID
INNER JOIN Session ON Event.SessionID = [Session].[SessionID]
WHERE Entrant.RaceTime is not null
GROUP BY MemberID;

-- if no creation date given ... use the date found in #tmp...
UPDATE [dbo].[Member]
SET
    [CreatedON] = #tmp.minDT
FROM Member
    -- Add more columns and values here
INNER JOIN #tmp on Member.MemberID = #tmp.MemberID
WHERE CreatedOn IS NULL;

-- clean-up Drop table 
DROP TABLE #tmp;


