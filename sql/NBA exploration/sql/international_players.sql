-- Calculate the percentage of international players across the entire analyzed period

WITH total_players AS (
    SELECT
        COUNT(DISTINCT player_id) AS player_count
    FROM nba_players
),
international_players AS (
    SELECT
        COUNT(DISTINCT player_id) AS player_count
    FROM nba_players
    WHERE country <> 'USA'
)
SELECT
    ROUND(
        international_players.player_count * 100.0
        / total_players.player_count,
        2
    ) AS international_player_percentage
FROM total_players
CROSS JOIN international_players;


-- Analyze the percentage of international players by season

WITH international_players AS (
    SELECT
        season,
        COUNT(DISTINCT player_id) AS international_player_count
    FROM nba_players
    WHERE country <> 'USA'
    GROUP BY season
),
total_players AS (
    SELECT
        season,
        COUNT(DISTINCT player_id) AS total_player_count
    FROM nba_players
    GROUP BY season
)
SELECT
    international_players.season,
    international_players.international_player_count,
    ROUND(
        international_players.international_player_count * 100.0
        / total_players.total_player_count,
        2
    ) AS international_player_percentage
FROM international_players
LEFT JOIN total_players
    ON international_players.season = total_players.season
ORDER BY international_players.season;


-- Identify the countries with the highest number of international players

SELECT
    country,
    COUNT(DISTINCT player_id) AS total_players
FROM nba_players
WHERE country <> 'USA'
GROUP BY country
ORDER BY total_players DESC
LIMIT 10;


-- Identify the highest-scoring international players

SELECT
    player_name,
    country,
    ROUND(AVG(pts), 2) AS average_points
FROM nba_players
WHERE country <> 'USA'
GROUP BY
    player_id,
    player_name,
    country
ORDER BY average_points DESC
LIMIT 10;
