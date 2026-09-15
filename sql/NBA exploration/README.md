# NBA Players SQL Data Exploration

An SQL data exploration project analyzing NBA player records across 27 seasons, from 1996-97 to 2022-23.

The project demonstrates the practical use of SQL to answer analytical questions, aggregate season-level data, create player rankings, compare draft and college backgrounds, and examine the growth of international representation in the NBA.

# Table of Contents

- [Project Overview](#project-overview)
- [Dataset](#dataset)
- [Tools and SQL Skills](#tools-and-sql-skills)
- [Database Setup](#database-setup)
- [Analysis](#analysis)
  - [Dataset Overview](#1-dataset-overview)
  - [Season Leaders](#2-season-leaders)
  - [Draft and College Analysis](#3-draft-and-college-analysis)
  - [International Players](#4-international-players)
- [Key Findings](#key-findings)
- [Repository Structure](#repository-structure)
- [Limitations](#limitations)
- [Data Source](#data-source)
- [Author](#author)

# Project Overview

**The goal of this project is to demonstrate practical SQL skills by exploring NBA player data and answering structured analytical questions.**

The analysis focuses on four areas:

- The number of player records and the time range covered by the dataset    
- Season leaders based on combined points, rebounds, and assists per game    
- Player performance in relation to draft position and college background    
- The growth and performance of international players    

The project uses season-level data covering 27 NBA seasons, from 1996-97 through 2022-23.    

# Dataset

**The dataset contains season-level NBA player records covering 27 seasons, from 1996-97 through 2022-23.**

**Each record includes information about:**

`Player name, age, height, and weight`    
`Team and season`    
`College and country`    
`Draft year, round, and number`    
`Games played`    
`Points, rebounds, and assists per game`    
`Selected advanced performance metrics`    
    
The source CSV contains 12,844 records and 22 columns.
    
> The original CSV index was stored as `player_index` and used as the primary key for individual rows. A separate `player_id` was generated using `DENSE_RANK()` based on `player_name`, `college`, and `draft_year`. This identifier enabled player records to be aggregated across multiple seasons and helped distinguish players with identical names.

# Tools and SQL Skills

## Tools

- **SQL** for data exploration, aggregation, ranking, and trend analysis    
- **PostgreSQL** as the database environment used to execute the queries    
- **CSV** files for source data and query results    

## SQL Skills Demonstrated

- Data filtering with `WHERE`
- Aggregation with `COUNT()`, `AVG()`, `MIN()`, and `MAX()`
- Grouping and aggregated filtering with `GROUP BY` and `HAVING`
- Sorting and limiting results with `ORDER BY` and `LIMIT`
- Common Table Expressions using `WITH`
- Combining query results with `LEFT JOIN` and `CROSS JOIN`
- Window functions using `RANK()` and `PARTITION BY`
- Percentage and ranking calculations
- Creation of a player-level identifier using `DENSE_RANK()`

# Database Setup

The source CSV was imported into the `nba_players` table. The original CSV index was stored as `player_index` and used as the primary key for individual records.

A separate `player_id` was generated using `DENSE_RANK()` based on:

- `player_name`
- `college`
- `draft_year`

This identifier enabled records belonging to the same player to be aggregated across multiple seasons while helping distinguish players with identical names.

The complete table creation and identifier logic are available in [`sql/01_database_setup.sql`](sql/01_database_setup.sql).

# Analysis

## 1. Dataset Overview

The first queries established the scope of the analysis and compared the number of player records across seasons.

The dataset covers:

- **27 NBA seasons**
- **First season:** 1996-97
- **Last season:** 2022-23
- **12,844 season-level player records**

The number of player records increased from **441 in 1996-97** to a peak of **605 in 2021-22**. The final season included in the dataset, 2022-23, contained **539 player records**.

The full SQL queries are available in [`sql/02_dataset_overview.sql`](sql/02_dataset_overview.sql), while the season-level results are stored in [`results/players_by_season.csv`](results/players_by_season.csv).

## 2. Season Leaders

A ranking query was used to identify the player with the highest combined points, rebounds, and assists per game in each season.

The query uses:

- CTE (Common Table Expressions)
- `RANK()`
- `PARTITION BY`
- Season-level aggregation

Selected results include:
```text
1996-97: Shaquille O'Neal, 41.8 combined average    
2007-08: LeBron James, 45.1    
2016-17: Russell Westbrook, 52.7    
2020-21: Nikola Jokic, 45.5    
2022-23: Luka Doncic, 49.0    
```
Russell Westbrook recorded the highest season-leading combined average in the dataset, reaching **52.7 combined points, rebounds, and assists per game in 2016-17**.

The complete query is available in [`sql/03_season_leaders.sql`](sql/03_season_leaders.sql), and the full results are stored in [`results/season_leaders.csv`](results/season_leaders.csv).

## 3. Draft and College Analysis

The analysis compared player scoring performance by draft position and college background.

### Draft Position

Among first-round selections, players chosen with the first overall pick recorded the highest average scoring result at **16.46 points per game**. However, scoring averages did not decline consistently with each subsequent draft position.

Several players selected outside the first round also achieved strong scoring averages:
```text
- Nikola Jokic, 41st pick: 20.40 points per game    
- Gilbert Arenas, 30th pick: 18.36    
- Monta Ellis, 40th pick: 17.66    
- Christian Wood, undrafted: 15.36    
- Fred VanVleet, undrafted: 14.19    
```
These results show that productive scorers were also found in the second round and among undrafted players.

### College Background

To reduce the influence of small groups, the college comparison included only colleges represented by at least `10 players.`

The highest average scoring results were recorded by:
```text
- Oklahoma: 11.32 points per game across 13 players    
- Wake Forest: 11.24 across 17 players    
- Connecticut: 10.46 across 31 players    
- Kentucky: 10.25 across 77 players    
- Duke: 10.00 across 68 players    
```
Oklahoma and Wake Forest recorded the highest averages, while Kentucky and Duke combined strong scoring results with much larger player representation.

The complete queries are available in [`sql/04_draft_and_college_analysis.sql`](sql/04_draft_and_college_analysis.sql), and the results are stored in [`results/draft_and_college_results.csv`](results/draft_and_college_results.csv).

## 4. International Players

The international player analysis examined the overall share, long-term development, leading countries, and scoring performance of players recorded outside the USA.

### International Representation

International players accounted for:

- **433 unique players**
- **16.18% of all unique players** in the complete analyzed period

### Growth Across Seasons

International representation increased substantially over time:
```text
- 1996-97: 9 players, representing 2.04%    
- 2005-06: 80 players, representing 17.47%    
- 2016-17: 115 players, representing 23.66%    
- 2022-23: 126 players, representing 23.38%    
```
The share of international players increased across most of the analyzed period, despite occasional season-to-season declines. By 2022-23, international players represented nearly one-quarter of all recorded players, compared with only 2.04% in 1996-97.

### Leading Countries

The countries with the highest number of international players were:
```text
- Canada: 48 players    
- France: 37    
- Australia: 31    
- Croatia: 15    
- Serbia: 15    
```
### Leading International Scorers

The highest career scoring averages among international players were recorded by:
```text
- Luka Doncic, Slovenia: 27.70 points per game    
- Joel Embiid, Cameroon: 26.54    
- Kyrie Irving, Australia: 23.77    
- Giannis Antetokounmpo, Greece: 23.25    
- Shai Gilgeous-Alexander, Canada: 21.88    
```
The results indicate that the NBA became substantially more international during the analyzed period. This growth was visible not only in the number of international players but also in the strong individual performance recorded by players from several countries.

The complete queries are available in [`sql/05_international_players.sql`](sql/05_international_players.sql). The results are stored in [`results/international_players_by_season.csv`](results/international_players_by_season.csv) and [`results/international_players_summary.csv`](results/international_players_summary.csv).

# Key Findings

- **International representation increased substantially.**
  International players accounted for 2.04% of player records in 1996-97 and 23.38% in 2022-23. The increase occurred across most of the analyzed period, indicating a clear long-term shift toward a more international league.
- **Canada was the largest source of international players.**
  Canada contributed 48 unique players, followed by France with 37 and Australia with 31.
- **International growth was accompanied by strong individual performance.**
  Luka Doncic recorded the highest average scoring result among international players at 27.70 points per game, followed by Joel Embiid at 26.54.
- **The first overall draft pick produced the highest scoring average among first-round positions.**
  Players selected first averaged 16.46 points per game. However, scoring averages did not decline consistently with each subsequent draft position.
- **Strong scorers were also found outside the first round.**
  Nikola Jokic, selected with the 41st pick, averaged 20.40 points per game. Several second-round and undrafted players also appeared among the leading scorers in these groups.
- **College scoring averages and player representation showed different patterns.**
  Oklahoma and Wake Forest recorded the highest scoring averages among colleges represented by at least 10 players, while Kentucky and Duke combined strong averages with considerably larger groups of players.
- **Russell Westbrook recorded the highest season-leading combined average.**
  His combined points, rebounds, and assists reached 52.7 per game in the 2016-17 season.

# Repository Structure

```text
nba-sql-data-exploration/
|
|-- README.md
|
|-- data/
|   `-- all_seasons.csv
|
|-- sql/
|   |-- 01_database_setup.sql
|   |-- 02_dataset_overview.sql
|   |-- 03_season_leaders.sql
|   |-- 04_draft_and_college_analysis.sql
|   `-- 05_international_players.sql
|
`-- results/
    |-- players_by_season.csv
    |-- season_leaders.csv
    |-- draft_and_college_results.csv
    |-- international_players_by_season.csv
    `-- international_players_summary.csv
```

- `data/` contains the source dataset used in the analysis.
- `sql/` contains the database setup and analytical SQL queries.
- `results/` contains the query results used to support the findings presented in this README.

# Limitations

- The dataset covers the 1996-97 through 2022-23 seasons and does not represent the complete history of the NBA.
- Player statistics are recorded as season-level averages rather than game-level results.
- Career scoring averages were calculated by averaging the available season-level values and were not weighted by games played.
- The `country` column reflects the country assigned to each player in the source dataset.
- College comparisons describe patterns in the available data and should not be interpreted as evidence that a college directly influenced later NBA performance.
- Draft position and scoring results may be related, but this descriptive analysis does not establish a causal relationship.
- Players were identified using a generated `player_id` based on player name, college, and draft year.

# Data Source

This project uses the **NBA Players** dataset published on Kaggle. The dataset contains biographic information and season-level player statistics covering the 1996-97 through 2022-23 seasons.

- **Source file:** `all_seasons.csv`
- **Dataset:** [NBA Players Data on Kaggle](https://www.kaggle.com/datasets/justinas/nba-players-data/data)
- **Rows:** 12,844
- **Columns:** 22

The source CSV is included in the `data/` folder to support reproducibility.

# Author

_Created by Bartłomiej Czop_

[LinkedIn](https://www.linkedin.com/in/bartlomiej-czop/) · [Portfolio](https://rezzt-93.github.io/index.html) · [Email](mailto:bartlomiej.czop1@gmail.com)
