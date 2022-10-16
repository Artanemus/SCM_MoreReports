USE SwimClubMeet;

DECLARE @switch AS BIT;

SET @switch = 0; -- :SWITCH

IF (@switch = 0)
    SELECT [MemberID]
         , [MembershipNum]
         , [MembershipStr] AS Registration
         , [MembershipDue]
         , [FirstName]
         , [LastName]
         , [MembershipType].Caption AS MembershipType
         , [House].Caption AS HouseName
         , [Member].[IsSwimmer]
         , [IsActive]
         , [IsArchived]
    FROM [SwimClubMeet].[dbo].[Member]
        LEFT JOIN MembershipType
            ON Member.MembershipTypeID = MembershipType.MembershipTypeID
        LEFT JOIN House
            ON Member.HouseID = House.HouseID
    WHERE IsArchived <> 1
          AND IsActive = 1
          AND Member.IsSwimmer = 1
          AND MembershipNum IS NOT NULL;

ELSE
    DECLARE @dtstart AS DATETIME;
DECLARE @dtend AS DATETIME;
DECLARE @s AS DATETIME;
DECLARE @e AS DATETIME;

SET @dtStart = '2021.8.1'; -- :STARTDT
SET @dtEnd = '2022.4.1'; -- :ENDDT

-- zero time on start date
SET @s = DATEADD(d, DATEDIFF(d, @dtStart, 0), @dtStart);
-- set end date's time to midnight
SET @dtEnd = DATEADD(DAY, 1, @dtEnd);
SET @e = DATEADD(d, DATEDIFF(d, 0, @dtEnd), 0);

SELECT [MemberID]
     , [MembershipNum]
     , [MembershipStr] AS Registration
     , [MembershipDue]
     , [FirstName]
     , [LastName]
     , [MembershipType].Caption AS MembershipType
     , [House].Caption AS HouseName
     , [Member].[IsSwimmer]
     , [IsActive]
     , [IsArchived]
FROM [SwimClubMeet].[dbo].[Member]
    LEFT JOIN MembershipType
        ON Member.MembershipTypeID = MembershipType.MembershipTypeID
    LEFT JOIN House
        ON Member.HouseID = House.HouseID
WHERE IsArchived <> 1
      AND IsActive = 1
      AND Member.IsSwimmer = 1
      AND MembershipNum IS NOT NULL
      AND
      (
          CreatedOn >= @s
          AND CreatedOn <= @e
      );

