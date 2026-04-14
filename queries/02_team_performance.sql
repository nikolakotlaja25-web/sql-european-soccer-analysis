-- ============================================================
-- FILE: 02_team_performance.sql
-- TOPIC: Team Performance Analysis
-- DIFFICULTY: Intermediate
-- DESCRIPTION: Analyze team win rates, goals scored, and
--              home vs. away performance using multi-table
--              JOINs, subqueries, and aggregations.
-- ============================================================


-- ------------------------------------------------------------
-- Q1. Overall win/draw/loss record for every team (all seasons)
-- ------------------------------------------------------------
WITH team_results AS (
    SELECT
        home_team_api_id AS team_api_id,
        CASE
            WHEN home_team_goal > away_team_goal THEN 'W'
            WHEN home_team_goal = away_team_goal THEN 'D'
            ELSE 'L'
        END AS result
    FROM Match

    UNION ALL

    SELECT
        away_team_api_id AS team_api_id,
        CASE
            WHEN away_team_goal > home_team_goal THEN 'W'
            WHEN away_team_goal = home_team_goal THEN 'D'
            ELSE 'L'
        END AS result
    FROM Match
)
SELECT
    t.team_long_name                            AS team,
    COUNT(*)                                    AS total_matches,
    SUM(CASE WHEN tr.result = 'W' THEN 1 END)  AS wins,
    SUM(CASE WHEN tr.result = 'D' THEN 1 END)  AS draws,
    SUM(CASE WHEN tr.result = 'L' THEN 1 END)  AS losses,
    ROUND(
        SUM(CASE WHEN tr.result = 'W' THEN 1.0 END) / COUNT(*) * 100,
        1
    )                                           AS win_pct
FROM team_results tr
JOIN Team t ON tr.team_api_id = t.team_api_id
GROUP BY t.team_long_name
HAVING total_matches >= 50
ORDER BY win_pct DESC
LIMIT 20;


-- ------------------------------------------------------------
-- Q2. Home advantage: compare home vs. away win rates per team
-- ------------------------------------------------------------
WITH home_stats AS (
    SELECT
        home_team_api_id                                                AS team_api_id,
        COUNT(*)                                                        AS home_played,
        SUM(CASE WHEN home_team_goal > away_team_goal THEN 1 ELSE 0 END) AS home_wins
    FROM Match
    GROUP BY home_team_api_id
),
away_stats AS (
    SELECT
        away_team_api_id                                                AS team_api_id,
        COUNT(*)                                                        AS away_played,
        SUM(CASE WHEN away_team_goal > home_team_goal THEN 1 ELSE 0 END) AS away_wins
    FROM Match
    GROUP BY away_team_api_id
)
SELECT
    t.team_long_name                                          AS team,
    h.home_played,
    h.home_wins,
    ROUND(h.home_wins * 100.0 / h.home_played, 1)           AS home_win_pct,
    a.away_played,
    a.away_wins,
    ROUND(a.away_wins * 100.0 / a.away_played, 1)           AS away_win_pct,
    ROUND(
        (h.home_wins * 100.0 / h.home_played) -
        (a.away_wins * 100.0 / a.away_played),
        1
    )                                                        AS home_advantage
FROM home_stats h
JOIN away_stats a  ON h.team_api_id = a.team_api_id
JOIN Team t        ON h.team_api_id = t.team_api_id
WHERE h.home_played >= 20
ORDER BY home_advantage DESC
LIMIT 15;


-- ------------------------------------------------------------
-- Q3. Top 10 highest-scoring teams (average goals scored per match)
-- ------------------------------------------------------------
WITH goals AS (
    SELECT home_team_api_id AS team_api_id, home_team_goal AS goals FROM Match
    UNION ALL
    SELECT away_team_api_id AS team_api_id, away_team_goal AS goals FROM Match
)
SELECT
    t.team_long_name                    AS team,
    COUNT(*)                            AS matches_played,
    SUM(g.goals)                        AS total_goals_scored,
    ROUND(AVG(g.goals), 2)             AS avg_goals_per_match
FROM goals g
JOIN Team t ON g.team_api_id = t.team_api_id
GROUP BY t.team_long_name
HAVING matches_played >= 50
ORDER BY avg_goals_per_match DESC
LIMIT 10;


-- ------------------------------------------------------------
-- Q4. Season-by-season league champion (most points)
--     Points system: Win = 3, Draw = 1, Loss = 0
-- ------------------------------------------------------------
WITH season_results AS (
    SELECT
        league_id,
        season,
        home_team_api_id AS team_api_id,
        CASE
            WHEN home_team_goal > away_team_goal THEN 3
            WHEN home_team_goal = away_team_goal THEN 1
            ELSE 0
        END AS points
    FROM Match

    UNION ALL

    SELECT
        league_id,
        season,
        away_team_api_id AS team_api_id,
        CASE
            WHEN away_team_goal > home_team_goal THEN 3
            WHEN away_team_goal = home_team_goal THEN 1
            ELSE 0
        END AS points
    FROM Match
),
season_totals AS (
    SELECT
        league_id,
        season,
        team_api_id,
        SUM(points) AS total_points
    FROM season_results
    GROUP BY league_id, season, team_api_id
),
ranked AS (
    SELECT *,
        RANK() OVER (PARTITION BY league_id, season ORDER BY total_points DESC) AS rnk
    FROM season_totals
)
SELECT
    l.name               AS league,
    r.season,
    t.team_long_name     AS champion,
    r.total_points
FROM ranked r
JOIN League l ON r.league_id = l.id
JOIN Team   t ON r.team_api_id = t.team_api_id
WHERE r.rnk = 1
ORDER BY l.name, r.season;
