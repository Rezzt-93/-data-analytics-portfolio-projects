-- Identify the time range covered by the dataset

SELECT
    MIN(season) AS first_season,
    MAX(season) AS last_season,
    COUNT(DISTINCT season) AS season_count
FROM nba_players;


-- Count player records in each NBA season

SELECT
    season,
    COUNT(player_id) AS player_count
FROM nba_players
GROUP BY season
ORDER BY season;
