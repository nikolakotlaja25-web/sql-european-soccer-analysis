# Database Schema — European Soccer Database

The dataset is distributed as a **SQLite database** (`database.sqlite`) containing **7 tables** and over **25,000 matches** across 11 European leagues from the 2008/09 to 2015/16 seasons.

---

## Entity Relationship Overview

```
Country ──< League ──< Match >── Team (home)
                              └── Team (away)
Team ──< Team_Attributes
Player ──< Player_Attributes
```

---

## Table Descriptions

### `Country`
Lookup table for countries where leagues are played.

| Column | Type    | Description           |
|--------|---------|-----------------------|
| id     | INTEGER | Primary key           |
| name   | TEXT    | Country name (e.g. "Spain") |

**Row count:** 11

---

### `League`
Each country's top domestic league.

| Column     | Type    | Description                        |
|------------|---------|------------------------------------|
| id         | INTEGER | Primary key                        |
| country_id | INTEGER | FK → Country.id                    |
| name       | TEXT    | League name (e.g. "La Liga BBVA")  |

**Row count:** 11

---

### `Match`
The core table. Each row is one match.

| Column              | Type    | Description                              |
|---------------------|---------|------------------------------------------|
| id                  | INTEGER | Primary key                              |
| country_id          | INTEGER | FK → Country.id                          |
| league_id           | INTEGER | FK → League.id                           |
| season              | TEXT    | e.g. "2014/2015"                         |
| stage               | INTEGER | Match-week number                        |
| date                | TEXT    | Match date (YYYY-MM-DD HH:MM:SS)         |
| home_team_api_id    | INTEGER | FK → Team.team_api_id                    |
| away_team_api_id    | INTEGER | FK → Team.team_api_id                    |
| home_team_goal      | INTEGER | Goals scored by home team                |
| away_team_goal      | INTEGER | Goals scored by away team                |
| home_player_1..11   | INTEGER | FK → Player.player_api_id (lineup)       |
| away_player_1..11   | INTEGER | FK → Player.player_api_id (lineup)       |
| B365H / B365D / B365A | REAL | Bet365 odds: home win / draw / away win  |
| *other odds columns* | REAL   | Odds from multiple bookmakers            |

**Row count:** ~25,979

---

### `Team`
Club information.

| Column            | Type    | Description                          |
|-------------------|---------|--------------------------------------|
| id                | INTEGER | Primary key                          |
| team_api_id       | INTEGER | Unique ID used in Match references   |
| team_fifa_api_id  | INTEGER | FIFA game internal ID                |
| team_long_name    | TEXT    | Full club name (e.g. "FC Barcelona") |
| team_short_name   | TEXT    | Abbreviation (e.g. "BAR")            |

**Row count:** 299

---

### `Team_Attributes`
Tactical/style attributes per team per date (from FIFA game data).

| Column                    | Type    | Description                             |
|---------------------------|---------|-----------------------------------------|
| id                        | INTEGER | Primary key                             |
| team_api_id               | INTEGER | FK → Team.team_api_id                   |
| team_fifa_api_id          | INTEGER | FIFA ID                                 |
| date                      | TEXT    | Snapshot date                           |
| buildUpPlaySpeed          | INTEGER | Speed of build-up play (1–100)          |
| buildUpPlaySpeedClass     | TEXT    | "Slow" / "Balanced" / "Fast"            |
| buildUpPlayDribbling      | INTEGER | Tendency to dribble (1–100)             |
| buildUpPlayPassing        | INTEGER | Passing style (1–100)                   |
| buildUpPlayPassingClass   | TEXT    | "Short" / "Mixed" / "Long"              |
| chanceCreationPassing     | INTEGER | Passing in attack (1–100)               |
| chanceCreationCrossing    | INTEGER | Crossing frequency (1–100)              |
| chanceCreationShooting    | INTEGER | Shooting tendency (1–100)               |
| defencePressure           | INTEGER | Defensive pressure (1–100)              |
| defenceAggression         | INTEGER | Defensive aggression (1–100)            |
| defenceTeamWidth          | INTEGER | Defensive team width (1–100)            |

**Row count:** ~1,458

---

### `Player`
Player biographical data.

| Column             | Type    | Description                        |
|--------------------|---------|------------------------------------|
| id                 | INTEGER | Primary key                        |
| player_api_id      | INTEGER | Unique ID used in attributes/match |
| player_name        | TEXT    | Full name                          |
| player_fifa_api_id | INTEGER | FIFA game ID                       |
| birthday           | TEXT    | Date of birth                      |
| height             | REAL    | Height in cm                       |
| weight             | INTEGER | Weight in pounds                   |

**Row count:** ~11,060

---

### `Player_Attributes`
Skill ratings per player per date (multiple snapshots over time).

| Column               | Type    | Description                                   |
|----------------------|---------|-----------------------------------------------|
| id                   | INTEGER | Primary key                                   |
| player_api_id        | INTEGER | FK → Player.player_api_id                     |
| player_fifa_api_id   | INTEGER | FIFA ID                                       |
| date                 | TEXT    | Snapshot date                                 |
| overall_rating       | INTEGER | Overall FIFA rating (0–100)                   |
| potential            | INTEGER | Potential FIFA rating (0–100)                 |
| preferred_foot       | TEXT    | "left" or "right"                             |
| attacking_work_rate  | TEXT    | "low" / "medium" / "high"                     |
| defensive_work_rate  | TEXT    | "low" / "medium" / "high"                     |
| crossing             | INTEGER | 0–100 skill rating                            |
| finishing            | INTEGER | 0–100 skill rating                            |
| heading_accuracy     | INTEGER | 0–100 skill rating                            |
| short_passing        | INTEGER | 0–100 skill rating                            |
| dribbling            | INTEGER | 0–100 skill rating                            |
| acceleration         | INTEGER | 0–100 skill rating                            |
| sprint_speed         | INTEGER | 0–100 skill rating                            |
| stamina              | INTEGER | 0–100 skill rating                            |
| strength             | INTEGER | 0–100 skill rating                            |
| long_shots           | INTEGER | 0–100 skill rating                            |
| aggression           | INTEGER | 0–100 skill rating                            |
| interceptions        | INTEGER | 0–100 skill rating                            |
| positioning          | INTEGER | 0–100 skill rating                            |
| vision               | INTEGER | 0–100 skill rating                            |
| penalties            | INTEGER | 0–100 skill rating                            |
| gk_diving            | INTEGER | Goalkeeper diving (0–100)                     |
| gk_handling          | INTEGER | Goalkeeper handling (0–100)                   |
| gk_kicking           | INTEGER | Goalkeeper kicking (0–100)                    |
| gk_reflexes          | INTEGER | Goalkeeper reflexes (0–100)                   |

**Row count:** ~183,978

---

## Key Join Relationships

```sql
-- Match → League → Country
Match.league_id        → League.id
League.country_id      → Country.id

-- Match → Team (both sides)
Match.home_team_api_id → Team.team_api_id
Match.away_team_api_id → Team.team_api_id

-- Match → Player (via lineup columns)
Match.home_player_1    → Player.player_api_id

-- Player → Attributes (one-to-many, time series)
Player.player_api_id   → Player_Attributes.player_api_id

-- Team → Attributes (one-to-many, time series)
Team.team_api_id       → Team_Attributes.team_api_id
```

---

## Leagues Covered

| Country     | League                          |
|-------------|----------------------------------|
| Belgium     | Jupiler Pro League               |
| England     | Premier League                   |
| France      | Ligue 1                          |
| Germany     | Bundesliga                       |
| Italy       | Serie A                          |
| Netherlands | Eredivisie                       |
| Poland      | Ekstraklasa                      |
| Portugal    | Liga ZON Sagres                  |
| Scotland    | Scottish Premier League          |
| Spain       | La Liga BBVA                     |
| Switzerland | Super League                     |

---

## Seasons Covered

`2008/2009` · `2009/2010` · `2010/2011` · `2011/2012` · `2012/2013` · `2013/2014` · `2014/2015` · `2015/2016`
