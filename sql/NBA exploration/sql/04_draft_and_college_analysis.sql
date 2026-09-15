-- Analyze first-round scoring by draft position

SELECT
    draft_number,
    ROUND(AVG(pts), 2) AS average_points
FROM nba_players
WHERE draft_round = '1'
GROUP BY draft_number
ORDER BY average_points DESC;


-- Identify the highest-scoring second-round and undrafted players

SELECT
    draft_round,
    draft_number,
    player_name,
    ROUND(AVG(pts), 2) AS average_points
FROM nba_players
WHERE draft_round = '2'
   OR draft_number = 'Undrafted'
GROUP BY
    player_id,
    player_name,
    draft_round,
    draft_number
ORDER BY average_points DESC
LIMIT 20;


-- Compare scoring performance by college
-- Include only colleges represented by at least 10 players

SELECT
    college,
    COUNT(DISTINCT player_id) AS total_players,
    ROUND(AVG(pts), 2) AS average_points
FROM nba_players
WHERE college IS NOT NULL
  AND college <> ''
  AND college <> 'None'
GROUP BY college
HAVING COUNT(DISTINCT player_id) >= 10
ORDER BY average_points DESC
LIMIT 20;
