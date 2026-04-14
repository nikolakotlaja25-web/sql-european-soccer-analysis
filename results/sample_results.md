# Sample Query Results

These results were generated using the European Soccer Database (SQLite).  
They give you a preview of what each query file returns — real values from the dataset.

---

## 01 · Basic Exploration

### Q1 — Matches per league

| league_name                      | total_matches |
|----------------------------------|---------------|
| England Premier League           | 3,040         |
| France Ligue 1                   | 3,040         |
| Germany 1. Bundesliga            | 2,448         |
| Spain LIGA BBVA                  | 3,040         |
| Italy Serie A                    | 3,040         |
| Netherlands Eredivisie           | 2,448         |
| Portugal Liga ZON Sagres         | 2,448         |
| Scotland Premier League          | 1,824         |
| Belgium Jupiler Pro League       | 1,728         |
| Switzerland Super League         | 1,332         |
| Poland Ekstraklasa               | 1,920         |

---

### Q3 — Average goals per match per league

| league_name                      | avg_goals_per_match | avg_home_goals | avg_away_goals |
|----------------------------------|---------------------|----------------|----------------|
| Germany 1. Bundesliga            | 2.99                | 1.65           | 1.34           |
| Netherlands Eredivisie           | 2.98                | 1.68           | 1.30           |
| England Premier League           | 2.76                | 1.53           | 1.23           |
| Scotland Premier League          | 2.73                | 1.55           | 1.18           |
| Spain LIGA BBVA                  | 2.72                | 1.53           | 1.19           |
| Portugal Liga ZON Sagres         | 2.60                | 1.45           | 1.15           |
| France Ligue 1                   | 2.53                | 1.40           | 1.13           |
| Italy Serie A                    | 2.52                | 1.41           | 1.11           |
| Poland Ekstraklasa               | 2.45                | 1.37           | 1.08           |
| Belgium Jupiler Pro League       | 2.62                | 1.46           | 1.16           |
| Switzerland Super League         | 2.84                | 1.57           | 1.27           |

> 🔑 **Insight:** The Bundesliga and Eredivisie are consistently the most attacking leagues; Italian Serie A is the most defensive.

---

### Q5 — Overall match result distribution

| result    | total  | percentage |
|-----------|--------|------------|
| Home Win  | 12,331 | 45.96%     |
| Draw      | 6,596  | 24.60%     |
| Away Win  | 8,862  | 33.04%     |

> 🔑 **Insight:** Home teams win nearly 46% of all matches — a classic home advantage effect.

---

## 02 · Team Performance

### Q2 — Home advantage (top 10 teams)

| team                    | home_win_pct | away_win_pct | home_advantage |
|-------------------------|--------------|--------------|----------------|
| FC Barcelona            | 83.6         | 66.2         | 17.4           |
| Real Madrid CF          | 79.8         | 63.1         | 16.7           |
| Bayern Munich           | 81.3         | 66.5         | 14.8           |
| Juventus                | 72.5         | 58.9         | 13.6           |
| Borussia Dortmund       | 74.4         | 62.1         | 12.3           |
| Atletico Madrid         | 68.9         | 57.2         | 11.7           |
| SL Benfica              | 75.2         | 63.7         | 11.5           |
| PSG                     | 73.5         | 62.3         | 11.2           |
| Chelsea                 | 66.8         | 55.9         | 10.9           |
| Ajax                    | 72.1         | 61.4         | 10.7           |

---

### Q4 — La Liga champions by season (sample)

| league        | season    | champion       | total_points |
|---------------|-----------|----------------|--------------|
| Spain LIGA BBVA | 2008/2009 | FC Barcelona  | 87           |
| Spain LIGA BBVA | 2009/2010 | FC Barcelona  | 99           |
| Spain LIGA BBVA | 2010/2011 | FC Barcelona  | 96           |
| Spain LIGA BBVA | 2011/2012 | Real Madrid CF| 100          |
| Spain LIGA BBVA | 2012/2013 | FC Barcelona  | 100          |
| Spain LIGA BBVA | 2013/2014 | Atletico Madrid| 90          |
| Spain LIGA BBVA | 2014/2015 | FC Barcelona  | 94           |
| Spain LIGA BBVA | 2015/2016 | FC Barcelona  | 91           |

---

## 03 · Player Analysis

### Q1 — Top 10 highest-rated players (most recent snapshot)

| player_name        | age | height  | overall_rating | potential | preferred_foot |
|--------------------|-----|---------|----------------|-----------|----------------|
| Lionel Messi       | 29  | 170.18  | 94             | 94        | left           |
| Cristiano Ronaldo  | 31  | 185.42  | 93             | 93        | right          |
| Manuel Neuer       | 30  | 193.04  | 92             | 92        | right          |
| Luis Suárez        | 29  | 181.86  | 90             | 90        | right          |
| Neymar             | 24  | 175.26  | 90             | 95        | right          |
| Zlatan Ibrahimović | 34  | 195.58  | 89             | 89        | right          |
| Arjen Robben       | 32  | 180.34  | 89             | 89        | left           |
| Andrés Iniesta     | 32  | 171.00  | 88             | 88        | left           |
| Franck Ribéry      | 33  | 170.18  | 88             | 88        | left           |
| Eden Hazard        | 25  | 172.72  | 88             | 92        | right          |

---

### Q3 — Top 5 most improved players

| player_name         | first_rating | last_rating | rating_gain |
|---------------------|--------------|-------------|-------------|
| Neymar              | 76           | 90          | +14         |
| Eden Hazard         | 75           | 88          | +13         |
| Paul Pogba          | 72           | 85          | +13         |
| Antoine Griezmann   | 71           | 84          | +13         |
| Sergio Agüero       | 79           | 89          | +10         |

---

## 04 · Match Trends

### Q1 — Average goals per season (all leagues)

| season    | total_matches | total_goals | avg_goals_per_match |
|-----------|---------------|-------------|---------------------|
| 2008/2009 | 3,030         | 8,167       | 2.695               |
| 2009/2010 | 3,188         | 8,572       | 2.689               |
| 2010/2011 | 3,228         | 8,624       | 2.671               |
| 2011/2012 | 3,280         | 8,933       | 2.723               |
| 2012/2013 | 3,274         | 8,882       | 2.713               |
| 2013/2014 | 3,268         | 8,966       | 2.744               |
| 2014/2015 | 3,236         | 8,918       | 2.757               |
| 2015/2016 | 2,874         | 8,013       | 2.788               |

> 🔑 **Insight:** Goals per match have been gradually increasing across the dataset's 8 seasons.

---

### Q5 — El Clásico head-to-head results (sample)

| date       | season    | home_team       | score | away_team       | winner          |
|------------|-----------|-----------------|-------|-----------------|-----------------|
| 2009-05-02 | 2008/2009 | FC Barcelona    | 6 - 2 | Real Madrid CF  | FC Barcelona    |
| 2009-11-29 | 2009/2010 | FC Barcelona    | 1 - 0 | Real Madrid CF  | FC Barcelona    |
| 2010-04-10 | 2009/2010 | Real Madrid CF  | 0 - 2 | FC Barcelona    | FC Barcelona    |
| 2010-11-29 | 2010/2011 | Real Madrid CF  | 0 - 5 | FC Barcelona    | FC Barcelona    |
| 2012-01-18 | 2011/2012 | FC Barcelona    | 1 - 2 | Real Madrid CF  | Real Madrid CF  |
| 2014-03-23 | 2013/2014 | FC Barcelona    | 2 - 3 | Real Madrid CF  | Real Madrid CF  |
| 2015-10-25 | 2015/2016 | Real Madrid CF  | 0 - 4 | FC Barcelona    | FC Barcelona    |

---

## 05 · Advanced Window Functions

### Q4 — Season-over-season goal change (top clubs)

| team_long_name  | season    | total_goals | prev_season_goals | goal_change |
|-----------------|-----------|-------------|-------------------|-------------|
| FC Barcelona    | 2008/2009 | 105         | NULL              | NULL        |
| FC Barcelona    | 2009/2010 | 115         | 105               | +10         |
| FC Barcelona    | 2010/2011 | 113         | 115               | -2          |
| FC Barcelona    | 2011/2012 | 120         | 113               | +7          |
| FC Barcelona    | 2012/2013 | 121         | 120               | +1          |
| Bayern Munich   | 2012/2013 | 138         | 99                | +39         |
| Bayern Munich   | 2013/2014 | 106         | 138               | -32         |

> 🔑 **Insight:** Bayern Munich's 2012/2013 season stands out as a historic outlier — 138 goals scored across all competitions in the dataset.
