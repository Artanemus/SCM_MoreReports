Use SwimClubMeet;

SELECT 
		 [MemberID]
		,[MembershipNum]
		,Substring( Concat(FirstName, ' ', Upper(LastName)), 0, 50) AS FName
FROM [SwimClubMeet].[dbo].[Member]
WHERE IsArchived <> 1
      AND IsActive = 1
      AND Member.IsSwimmer = 1
      AND MembershipNum IS NOT NULL; 
