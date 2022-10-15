Use SwimClubMeet;

SELECT 
		 [MemberID]
		,[MembershipNum]
		,[MembershipStr]
		,[MembershipDue]
		,[FirstName]
		,[LastName]
		,[DOB]
		,[IsActive]
		,[IsArchived]
		,[Email]
		,[EnableEmailOut]
		,[GenderID]
		,[SwimClubID]
		,[MembershipTypeID]
		,[CreatedOn]
		,[ArchivedOn]
		,[EnableEmailNomineeForm]
		,[EnableEmailSessionReport]
		,[HouseID]
		,[IsSwimmer]
FROM [SwimClubMeet].[dbo].[Member] 
WHERE IsArchived <> 1 and IsActive = 1 and IsSwimmer = 1 and MembershipNum is not NULL 


