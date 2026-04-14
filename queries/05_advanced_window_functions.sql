-- ============================================================
-- FILE: 05_advanced_window_functions.sql
-- TOPIC: Advanced Window Functions & Analytics
-- DIFFICULTY: Intermediate–Advanced
-- DESCRIPTION: Deep-dive analytics using window functions:
--              RANK, DENSE_RANK, LAG, LEAD, running totals,
--              moving averages, and percentile bucketing.
-- ============================================================


-- ------------------------------------------------------------
-- Q1. Rank players by overall rating within each year they
--     were assessed (dense rank, so no gaps in ranking)
-- ------------------------------------------------------------
SELECT
    p.player_name,
    CAST(strftime('%Y', pa.date) AS INT)        AS assessment_year,
    pa.overall_rating,
    DENSE_RANK() OVER (
        PARTITION BY CAST(strftime('%Y', pa.date) AS INT)
        ORDER BY pa.overall_rating DESC
    )                                            AS yearly_rank
FROM Player_Attributes pa
JOIN Player p ON pa.player_api_id = p.player_api_id
WHERE pa.overall_rating IS NOT NULL
  AND CAST(strftime('%Y', pa.date) AS INT) IN (2012, 2014, 2016)
QUALIFY yearly_rank <= 5   -- top 5 per year
ORDER BY assessment_year, yearly_rank;

-- NOTE: If your SQL engine doesn't support QUALIFY, use a subquery:
-- SELECT * FROM (...above query without QUALIFY...) WHERE yearly_rank <= 5;


-- ------------------------------------------------------------
-- Q2. Running total of goals in the English Premier League
--     (cumulative goals by match date)
-- ------------------------------------------------------------
WITH epl_matches AS (
    SELECT
        m.date,
        m.home_team_goal + m.away_team_goal AS match_goals
    FROM Match m
    JOIN League l ON m.league_id = l.id
    WHERE l.name = 'England Premier League'
      AND m.date IS NOT NULL
    ORDER BY m.date
)
SELECT
    date,
    match_goals,
    SUM(match_goals) OVER (ORDER BY date ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)
        AS cumulative_goals
FROM epl_matches
ORDER BY date;


-- ------------------------------------------------------------
-- Q3. 5-match rolling average goals per team
--     (how consistent is a team's scoring form?)
-- ------------------------------------------------------------
WITH team_matches AS (
    SELECT
        home_team_api_id    AS team_api_id,
        date,
        home_team_goal      AS goals_scored
    FROM Match
    UNION ALL
    SELECT
        away_team_api_id,
        date,
        away_team_goal
    FROM Match
),
ordered AS (
    SELECT
        team_api_id,
        date,
        goals_scored,
        ROW_NUMBER() OVER (PARTITION BY team_api_id ORDER BY date) AS match_num
    FROM team_matches
)
SELECT
    t.team_long_name,
    o.date,
    o.goals_scored,
    ROUND(
        AVG(o.goals_scored) OVER (
            PARTITION BY o.team_api_id
            ORDER BY o.match_num
            ROWS BETWEEN 4 PRECEDING AND CURRENT ROW
        ), 2
    )                   AS rolling_5_avg
FROM ordered o
JOIN Team t ON o.team_api_id = t.team_api_id
WHERE t.team_long_name = 'FC Barcelona'
ORDER BY o.date;


-- ------------------------------------------------------------
-- Q4. LAG/LEAD — compare each team's goal count in current vs.
--     previous season (season-over-season change)
-- ------------------------------------------------------------
WITH season_goals AS (
    SELECT
        home_team_api_id    AS team_api_id,
        season,
        SUM(home_team_goal) AS goals
    FROM Match GROUP BY home_team_api_id, season
    UNION ALL
    SELECT
        away_team_api_id,
        season,
        SUM(away_team_goal)
    FROM Match GROUP BY away_team_api_id, season
),
combined AS (
    SELECT team_api_id, season, SUM(goals) AS total_goals
    FROM season_goals
    GROUP BY team_api_id, season
)
SELECT
    t.team_long_name,
    c.season,
    c.total_goals,
    LAG(c.total_goals) OVER (
        PARTITION BY c.team_api_id ORDER BY c.season
    )                                            AS prev_season_goals,
    c.total_goals - LAG(c.total_goals) OVER (
        PARTITION BY c.team_api_id ORDER BY c.season
    )                                            AS goal_change
FROM combined c
JOIN Team t ON c.team_api_id = t.team_api_id
WHERE t.team_long_name IN ('FC Barcelona', 'Real Madrid CF', 'Bayern Munich')
ORDER BY t.team_long_name, c.season;


-- ------------------------------------------------------------
-- Q5. NTILE — bucket all teams into performance quartiles
--     based on total points earned across all seasons
-- ------------------------------------------------------------
WITH all_results AS (
    SELECT home_team_api_id AS team_api_id,
        SUM(CASE WHEN home_team_goal > away_team_goal THEN 3
                 WHEN home_team_goal = away_team_goal THEN 1 ELSE 0 END) AS pts
    FROM Match GROUP BY home_team_api_id
    UNION ALL
    SELECT away_team_api_id,
        SUM(CASE WHEN away_team_goal > home_team_goal THEN 3
                 WHEN away_team_goal = home_team_goal THEN 1 ELSE 0 END)
    FROM Match GROUP BY away_team_api_id
),
team_totals AS (
    SELECT team_api_id, SUM(pts) AS total_points
    FROM all_results GROUP BY team_api_id
)
SELECT
    t.team_long_name,
    tt.total_points,
    NTILE(4) OVER (ORDER BY tt.total_points DESC) AS performance_quartile
FROM team_totals tt
JOIN Team t ON tt.team_api_id = t.team_api_id
ORDER BY tt.total_points DESC;


-- ------------------------------------------------------------
-- Q6. PERCENT_RANK — where does each team fall in the
--     distribution of all-time win percentages?
-- ------------------------------------------------------------
WITH win_rates AS (
    SELECT
        home_team_api_id AS team_api_id,
        SUM(CASE WHEN home_team_goal > away_team_goal THEN 1 ELSE 0 END) AS wins,
        COUNT(*) AS played
    FROM Match GROUP BY home_team_api_id
    UNION ALL
    SELECT
        away_team_api_id,
        SUM(CASE WHEN away_team_goal > home_team_goal THEN 1 ELSE 0 END),
        COUNT(*)
    FROM Match GROUP BY away_team_api_id
),
totals AS (
    SELECT team_api_id,
        SUM(wins)   AS total_wins,
        SUM(played) AS total_played
    FROM win_rates GROUP BY team_api_id
)
SELECT
    t.team_long_name,
    tot.total_wins,
    tot.total_played,
    ROUND(tot.total_wins * 100.0 / tot.total_played, 1) AS win_pct,
    ROUND(
        PERCENT_RANK() OVER (
            ORDER BY tot.total_wins * 100.0 / tot.total_played
        ) * 100, 1
    )                                                    AS percentile_rank
FROM totals tot
JOIN Team t ON tot.team_api_id = t.team_api_id
WHERE tot.total_played >= 50
ORDER BY win_pct DESC
LIMIT 20;
