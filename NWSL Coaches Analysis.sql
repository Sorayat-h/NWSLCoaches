-- Show the season before a coach change after the season and the next 2 seasons, include calculations for win %, points per game, and position for the next 2 seasons
with ChangesPost as 
(
  SELECT *, round(Points/Games_Played,2) as Points_Per_Game, round((Wins/Games_Played)*100,2) as Win_Percentage,
          LAG(Coach_Change, 1) OVER (Partition by Club ORDER BY Club) AS Season1,
       LAG(Coach_Change, 2) OVER (Partition by Club ORDER BY Club) AS Season2,
        Lead(Position, 1) OVER (Partition by Club ORDER BY Club) AS Position_Year1,
        Lead(Position, 2) OVER (Partition by Club ORDER BY Club) AS Position_Year2,
        Lead(round(Points/Games_Played,2), 1) OVER (Partition by Club ORDER BY Club) AS Points_Per_Year1,
        Lead(round(Points/Games_Played,2), 2) OVER (Partition by Club ORDER BY Club) AS Points_Per_Year2,
        Lead(round((Wins/Games_Played)*100,2), 1) OVER (Partition by Club ORDER BY Club) AS Win_Percentage_Year1,
        Lead(round((Wins/Games_Played)*100,2), 2) OVER (Partition by Club ORDER BY Club) AS Win_Percentage_Year2,
  FROM `qualified-glow-417301.PortfolioProjects.NWSL_Seasons`
  Order by Club ASC, Season ASC
) 

Select *
From ChangesPost
WHERE Coach_Change = 'Post'
Or Season1= 'Post'
Or Season2= 'Post'
Order by Club,Season;


