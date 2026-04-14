-- ============================================================
-- FILE: 04_match_trends.sql
-- TOPIC: Match Trends & Seasonal Analysis
-- DIFFICULTY: Intermediate
-- DESCRIPTION: Analyze scoring trends over time, seasonal
--              patterns, and league competitiveness using
--              date functions, correlated subqueries, and CTEs.
-- ============================================================


-- ------------------------------------------------------------
-- Q1. Average goals per match per season (all leagues combined)
--     — does football get more or less attacking over time?
-- ------------------------------------------------------------
SELECT
    season,
    COUNT(*)                                                    AS total_matches,
    SUM(home_team_goal + away_team_goal)                        AS total_goals,
    ROUND(AVG(home_team_goal + away_team_goal), 3)             AS avg_goals_per_match
FROM Match
GROUP BY season
ORDER BY season;


-- ------------------------------------------------------------
-- Q2. Monthly goal rate — which month produces the most goals?
-- ------------------------------------------------------------
SELECT
    CAST(strftime('%m', date) AS INT)                           AS month_num,
    CASE strftime('%m', date)
        WHEN '01' THEN 'January'   WHEN '02' THEN 'February'
        WHEN '03' THEN 'March'     WHEN '04' THEN 'April'
        WHEN '05' THEN 'May'       WHEN '06' THEN 'June'
        WHEN '07' THEN 'July'      WHEN '08' THEN 'August'
        WHEN '09' THEN 'September' WHEN '10' THEN 'October'
        WHEN '11' THEN 'November'  WHEN '12' THEN 'December'
    END                                                         AS month_name,
    COUNT(*)                                                    AS matches_played,
    ROUND(AVG(home_team_goal + away_team_goal), 2)             AS avg_goals
FROM Match
WHERE date IS NOT NULL
GROUP BY month_num
ORDER BY month_num;


-- ------------------------------------------------------------
-- Q3. Home win rate trend per season — is home advantage shrinking?
-- ------------------------------------------------------------
SELECT
    season,
    COUNT(*)                                                            AS total_matches,
    SUM(CASE WHEN home_team_goal > away_team_goal THEN 1 ELSE 0 END)  AS home_wins,
    SUM(CASE WHEN home_team_goal = away_team_goal THEN 1 ELSE 0 END)  AS draws,
    SUM(CASE WHEN home_team_goal < away_team_goal THEN 1 ELSE 0 END)  AS away_wins,
    ROUND(
        SUM(CASE WHEN home_team_goal > away_team_goal THEN 1.0 ELSE 0 END)
        / COUNT(*) * 100, 1
    )                                                                   AS home_win_pct
FROM Match
GROUP BY season
ORDER BY season;


-- ------------------------------------------------------------
-- Q4. Most competitive seasons per league
--     (smallest gap between 1st and 4th place in points)
-- ------------------------------------------------------------
WITH season_points AS (
    SELECT league_id, season, home_team_api_id AS team_api_id,
        SUM(CASE
            WHEN home_team_goal > away_team_goal THEN 3
            WHEN home_team_goal = away_team_goal THEN 1
            ELSE 0 END) AS pts
    FROM Match GROUP BY league_id, season, home_team_api_id
    UNION ALL
    SELECT league_id, season, away_team_api_id,
        SUM(CASE
            WHEN away_team_goal > home_team_goal THEN 3
            WHEN away_team_goal = home_team_goal THEN 1
            ELSE 0 END)
    FROM Match GROUP BY league_id, season, away_team_api_id
),
combined AS (
    SELECT league_id, season, team_api_id, SUM(pts) AS total_pts
    FROM season_points GROUP BY league_id, season, team_api_id
),
ranked AS (
    SELECT *,
        RANK() OVER (PARTITION BY league_id, season ORDER BY total_pts DESC) AS rnk
    FROM combined
)
SELECT
    l.name                                  AS league,
    r.season,
    MAX(CASE WHEN rnk = 1 THEN total_pts END) AS pts_1st,
    MAX(CASE WHEN rnk = 4 THEN total_pts END) AS pts_4th,
    MAX(CASE WHEN rnk = 1 THEN total_pts END) -
    MAX(CASE WHEN rnk = 4 THEN total_pts END) AS gap_1st_to_4th
FROM ranked r
JOIN League l ON r.league_id = l.id
WHERE rnk <= 4
GROUP BY l.name, r.season
HAVING pts_4th IS NOT NULL
ORDER BY gap_1st_to_4th ASC
LIMIT 15;


-- ------------------------------------------------------------
-- Q5. Head-to-head record between two specific teams
--     (edit team names to compare any rivalry)
-- ------------------------------------------------------------
WITH h2h AS (
    SELECT
        m.date,
        m.season,
        t_h.team_long_name   AS home_team,
        m.home_team_goal,
        m.away_team_goal,
        t_a.team_long_name   AS away_team
    FROM Match m
    JOIN Team t_h ON m.home_team_api_id = t_h.team_api_id
    JOIN Team t_a ON m.away_team_api_id = t_a.team_api_id
    WHERE
        (t_h.team_long_name = 'FC Barcelona' AND t_a.team_long_name = 'Real Madrid CF')
        OR
        (t_h.team_long_name = 'Real Madrid CF' AND t_a.team_long_name = 'FC Barcelona')
)
SELECT
    date,
    season,
    home_team,
    home_team_goal || ' - ' || away_team_goal AS score,
    away_team,
    CASE
        WHEN home_team_goal > away_team_goal THEN home_team
        WHEN away_team_goal > home_team_goal THEN away_team
        ELSE 'Draw'
    END AS winner
FROM h2h
ORDER BY date;
