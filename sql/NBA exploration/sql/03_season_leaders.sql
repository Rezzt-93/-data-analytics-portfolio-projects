-- Identify the player with the highest combined points, rebounds, and assists per game in each season

WITH player_ranking AS (
    SELECT
        season,
        player_name,
        ROUND(SUM(pts + reb + ast), 2) AS combined_average,
        RANK() OVER (
            PARTITION BY season
            ORDER BY SUM(pts + reb + ast) DESC
        ) AS player_rank
    FROM nba_players
    GROUP BY
        player_id,
        player_name,
        season
)
SELECT
    season,
    player_name,
    combined_average
FROM player_ranking
WHERE player_rank = 1
ORDER BY season;
