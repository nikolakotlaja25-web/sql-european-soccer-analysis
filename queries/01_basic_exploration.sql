-- ============================================================
-- FILE: 01_basic_exploration.sql
-- TOPIC: Basic Data Exploration
-- DIFFICULTY: Beginner → Intermediate
-- DESCRIPTION: Get familiar with the dataset structure and
--              run foundational queries using SELECT, WHERE,
--              GROUP BY, ORDER BY, and HAVING.
-- ============================================================


-- ------------------------------------------------------------
-- Q1. How many matches are recorded per league?
-- ------------------------------------------------------------
SELECT
    l.name         AS league_name,
    COUNT(m.id)    AS total_matches
FROM Match m
JOIN League l ON m.league_id = l.id
GROUP BY l.name
ORDER BY total_matches DESC;


-- ------------------------------------------------------------
-- Q2. How many seasons does the dataset cover per league?
-- ------------------------------------------------------------
SELECT
    l.name                        AS league_name,
    COUNT(DISTINCT m.season)      AS seasons_covered,
    MIN(m.season)                 AS first_season,
    MAX(m.season)                 AS last_season
FROM Match m
JOIN League l ON m.league_id = l.id
GROUP BY l.name
ORDER BY seasons_covered DESC;


-- ------------------------------------------------------------
-- Q3. What is the average number of goals per match per league?
-- ------------------------------------------------------------
SELECT
    l.name                                                        AS league_name,
    ROUND(AVG(m.home_team_goal + m.away_team_goal), 2)           AS avg_goals_per_match,
    ROUND(AVG(m.home_team_goal), 2)                              AS avg_home_goals,
    ROUND(AVG(m.away_team_goal), 2)                              AS avg_away_goals
FROM Match m
JOIN League l ON m.league_id = l.id
GROUP BY l.name
ORDER BY avg_goals_per_match DESC;


-- ------------------------------------------------------------
-- Q4. Which leagues have an average of more than 2.6 goals/match?
-- (Demonstrates HAVING clause)
-- ------------------------------------------------------------
SELECT
    l.name                                              AS league_name,
    ROUND(AVG(m.home_team_goal + m.away_team_goal), 2) AS avg_goals
FROM Match m
JOIN League l ON m.league_id = l.id
GROUP BY l.name
HAVING avg_goals > 2.6
ORDER BY avg_goals DESC;


-- ------------------------------------------------------------
-- Q5. What percentage of matches end in a home win, draw, or away win?
-- ------------------------------------------------------------
SELECT
    CASE
        WHEN home_team_goal > away_team_goal THEN 'Home Win'
        WHEN home_team_goal = away_team_goal THEN 'Draw'
        ELSE 'Away Win'
    END                                                 AS result,
    COUNT(*)                                            AS total,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM Match), 2) AS percentage
FROM Match
GROUP BY result
ORDER BY total DESC;


-- ------------------------------------------------------------
-- Q6. Top 10 highest-scoring individual matches ever recorded
-- ------------------------------------------------------------
SELECT
    m.date,
    t_home.team_long_name   AS home_team,
    m.home_team_goal,
    m.away_team_goal,
    t_away.team_long_name   AS away_team,
    l.name                  AS league,
    m.season,
    (m.home_team_goal + m.away_team_goal) AS total_goals
FROM Match m
JOIN Team t_home ON m.home_team_api_id = t_home.team_api_id
JOIN Team t_away ON m.away_team_api_id = t_away.team_api_id
JOIN League l    ON m.league_id = l.id
ORDER BY total_goals DESC
LIMIT 10;
