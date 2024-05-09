SELECT * 
FROM `qualified-glow-417301.PortfolioProjects.NWSL_Seasons` 
;
-- Show the season prior to a coach change after the season and the next 2 seasons
with ChangesPost as 
(
  SELECT *,
          LAG(Coach_Change, 1) OVER (Partition by Club ORDER BY Club) AS Season1,
       LAG(Coach_Change, 2) OVER (Partition by Club ORDER BY Club) AS Season2
  FROM `qualified-glow-417301.PortfolioProjects.NWSL_Seasons`
  Order by Club ASC, Season ASC
) 

Select *
From ChangesPost
WHERE Coach_Change = 'Post'
Or Season1= 'Post'
Or Season2= 'Post'
Order by Club,Season;


