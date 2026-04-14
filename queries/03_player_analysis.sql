-- ============================================================
-- FILE: 03_player_analysis.sql
-- TOPIC: Player Analysis
-- DIFFICULTY: Intermediate
-- DESCRIPTION: Explore player ratings, physical attributes,
--              and skill trends. Introduces subqueries,
--              CTEs, and multi-column aggregations.
-- ============================================================


-- ------------------------------------------------------------
-- Q1. Top 20 highest-rated players (most recent overall rating)
-- ------------------------------------------------------------
WITH latest_rating AS (
    SELECT
        player_api_id,
        overall_rating,
        potential,
        preferred_foot,
        ROW_NUMBER() OVER (
            PARTITION BY player_api_id
            ORDER BY date DESC
        ) AS rn
    FROM Player_Attributes
    WHERE overall_rating IS NOT NULL
)
SELECT
    p.player_name,
    CAST((julianday('now') - julianday(p.birthday)) / 365.25 AS INT)  AS age,
    p.height,
    p.weight,
    lr.overall_rating,
    lr.potential,
    lr.preferred_foot
FROM latest_rating lr
JOIN Player p ON lr.player_api_id = p.player_api_id
WHERE lr.rn = 1
ORDER BY lr.overall_rating DESC
LIMIT 20;


-- ------------------------------------------------------------
-- Q2. Average rating by preferred foot (left vs. right)
-- ------------------------------------------------------------
WITH latest_rating AS (
    SELECT
        player_api_id,
        overall_rating,
        preferred_foot,
        ROW_NUMBER() OVER (
            PARTITION BY player_api_id ORDER BY date DESC
        ) AS rn
    FROM Player_Attributes
    WHERE overall_rating IS NOT NULL
      AND preferred_foot IN ('left', 'right')
)
SELECT
    preferred_foot,
    COUNT(*)                            AS player_count,
    ROUND(AVG(overall_rating), 2)       AS avg_rating,
    MIN(overall_rating)                 AS min_rating,
    MAX(overall_rating)                 AS max_rating
FROM latest_rating
WHERE rn = 1
GROUP BY preferred_foot;


-- ------------------------------------------------------------
-- Q3. Players who improved the most between their first and
--     latest recorded rating (biggest potential realized)
-- ------------------------------------------------------------
WITH first_and_last AS (
    SELECT
        player_api_id,
        FIRST_VALUE(overall_rating) OVER (
            PARTITION BY player_api_id ORDER BY date ASC
        ) AS first_rating,
        LAST_VALUE(overall_rating) OVER (
            PARTITION BY player_api_id
            ORDER BY date ASC
            ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
        ) AS last_rating
    FROM Player_Attributes
    WHERE overall_rating IS NOT NULL
),
improvement AS (
    SELECT DISTINCT
        player_api_id,
        first_rating,
        last_rating,
        (last_rating - first_rating) AS rating_gain
    FROM first_and_last
)
SELECT
    p.player_name,
    i.first_rating,
    i.last_rating,
    i.rating_gain
FROM improvement i
JOIN Player p ON i.player_api_id = p.player_api_id
WHERE i.rating_gain > 0
ORDER BY i.rating_gain DESC
LIMIT 15;


-- ------------------------------------------------------------
-- Q4. Skill breakdown — top 10 players by finishing, dribbling,
--     and passing (compare specializations)
-- ------------------------------------------------------------
WITH latest AS (
    SELECT
        player_api_id,
        finishing,
        dribbling,
        short_passing,
        ROW_NUMBER() OVER (
            PARTITION BY player_api_id ORDER BY date DESC
        ) AS rn
    FROM Player_Attributes
    WHERE finishing IS NOT NULL
)
SELECT
    p.player_name,
    l.finishing,
    l.dribbling,
    l.short_passing,
    ROUND((l.finishing + l.dribbling + l.short_passing) / 3.0, 1) AS avg_skill
FROM latest l
JOIN Player p ON l.player_api_id = p.player_api_id
WHERE l.rn = 1
ORDER BY avg_skill DESC
LIMIT 10;


-- ------------------------------------------------------------
-- Q5. Distribution of players by height bucket
-- ------------------------------------------------------------
SELECT
    CASE
        WHEN height < 170                  THEN 'Under 170cm'
        WHEN height BETWEEN 170 AND 175    THEN '170–175cm'
        WHEN height BETWEEN 175 AND 180    THEN '175–180cm'
        WHEN height BETWEEN 180 AND 185    THEN '180–185cm'
        WHEN height BETWEEN 185 AND 190    THEN '185–190cm'
        ELSE 'Over 190cm'
    END                         AS height_bucket,
    COUNT(*)                    AS player_count,
    ROUND(AVG(weight), 1)       AS avg_weight_lbs
FROM Player
GROUP BY height_bucket
ORDER BY MIN(height);
