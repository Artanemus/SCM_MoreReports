USE SwimClubMeet;

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


