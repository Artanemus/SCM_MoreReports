USE SwimClubMeet;

-- Select rows from a Table or View '[Session]' in schema '[dbo]'
SELECT SessionID
     , CONCAT(FORMAT(SessionStart, 'MMM ddd dd yyyy'), ' - ', Caption) AS TitleStr
FROM [dbo].[Session]
WHERE SessionStatusID <> 2
ORDER BY SessionStart DESC;
