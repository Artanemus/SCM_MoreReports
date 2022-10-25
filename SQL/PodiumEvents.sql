USE SwimClubMeet;

-- Select rows from a Table or View '[Event]' in schema '[dbo]'
SELECT 
		 [EventID]
		,[EventNum]
		,[ClosedDT]
		,[SessionID]
		,[EventTypeID]
		,Event.[StrokeID]
		,Event.[DistanceID]
		,[EventStatusID]
        ,Concat(Distance.Caption, ' ', Stroke.Caption) AS TitleStr
		,Event.[Caption] As DetailStr
FROM [SwimClubMeet].[dbo].[Event]
INNER JOIN Distance ON Event.DistanceID = Distance.DistanceID
INNER JOIN Stroke ON Event.StrokeID = Stroke.StrokeID
Order by SessionID DESC, EventNum ASC