-- Create the main table for NBA player data

CREATE TABLE nba_players (
    player_index INT PRIMARY KEY,
    player_name VARCHAR(100) NOT NULL,
    team_abbreviation VARCHAR(100),
    age INT,
    player_height FLOAT,
    player_weight FLOAT,
    college VARCHAR(100),
    country VARCHAR(100),
    draft_year VARCHAR(100),
    draft_round VARCHAR(100),
    draft_number VARCHAR(100),
    gp INT,
    pts FLOAT,
    reb FLOAT,
    ast FLOAT,
    net_rating FLOAT,
    oreb_pct FLOAT,
    dreb_pct FLOAT,
    usg_pct FLOAT,
    ts_pct FLOAT,
    ast_pct FLOAT,
    season VARCHAR(100)
);


-- Add a player-level identifier for aggregating records across seasons

ALTER TABLE nba_players
ADD COLUMN player_id INT;

UPDATE nba_players
SET player_id = generated.player_id
FROM (
    SELECT
        player_index,
        DENSE_RANK() OVER (
            ORDER BY player_name, college, draft_year
        ) AS player_id
    FROM nba_players
) AS generated
WHERE nba_players.player_index = generated.player_index;
