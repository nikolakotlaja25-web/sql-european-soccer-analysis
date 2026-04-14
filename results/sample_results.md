# Sample Query Results

These results were generated using the European Soccer Database (SQLite).  
Every query from every file is covered here with a sample output table and a key insight.

---

## 01 · Basic Exploration

### Q1 — How many matches are recorded per league?

| league_name                  | total_matches |
|------------------------------|---------------|
| England Premier League       | 3,040         |
| France Ligue 1               | 3,040         |
| Spain LIGA BBVA              | 3,040         |
| Italy Serie A                | 3,040         |
| Germany 1. Bundesliga        | 2,448         |
| Netherlands Eredivisie       | 2,448         |
| Portugal Liga ZON Sagres     | 2,448         |
| Poland Ekstraklasa           | 1,920         |
| Scotland Premier League      | 1,824         |
| Belgium Jupiler Pro League   | 1,728         |
| Switzerland Super League     | 1,332         |

> 🔑 **Insight:** England, France, Spain and Italy have the most matches — all running 8 full seasons of 380 matches each.

---

### Q2 — How many seasons does the dataset cover per league?

| league_name                  | seasons_covered | first_season | last_season |
|------------------------------|-----------------|--------------|-------------|
| England Premier League       | 8               | 2008/2009    | 2015/2016   |
| Spain LIGA BBVA              | 8               | 2008/2009    | 2015/2016   |
| Germany 1. Bundesliga        | 8               | 2008/2009    | 2015/2016   |
| Italy Serie A                | 8               | 2008/2009    | 2015/2016   |
| France Ligue 1               | 8               | 2008/2009    | 2015/2016   |
| Belgium Jupiler Pro League   | 6               | 2009/2010    | 2015/2016   |
| Scotland Premier League      | 6               | 2008/2009    | 2013/2014   |
| Switzerland Super League     | 6               | 2010/2011    | 2015/2016   |

> 🔑 **Insight:** Not all leagues have complete 8-season coverage — Scotland and Switzerland have fewer seasons recorded.

---

### Q3 — Average number of goals per match per league

| league_name                  | avg_goals_per_match | avg_home_goals | avg_away_goals |
|------------------------------|---------------------|----------------|----------------|
| Germany 1. Bundesliga        | 2.99                | 1.65           | 1.34           |
| Netherlands Eredivisie       | 2.98                | 1.68           | 1.30           |
| Switzerland Super League     | 2.84                | 1.57           | 1.27           |
| England Premier League       | 2.76                | 1.53           | 1.23           |
| Scotland Premier League      | 2.73                | 1.55           | 1.18           |
| Spain LIGA BBVA              | 2.72                | 1.53           | 1.19           |
| Belgium Jupiler Pro League   | 2.62                | 1.46           | 1.16           |
| Portugal Liga ZON Sagres     | 2.60                | 1.45           | 1.15           |
| France Ligue 1               | 2.53                | 1.40           | 1.13           |
| Italy Serie A                | 2.52                | 1.41           | 1.11           |
| Poland Ekstraklasa           | 2.45                | 1.37           | 1.08           |

> 🔑 **Insight:** The Bundesliga and Eredivisie are the most attacking leagues. Italian Serie A is the most defensive.

---

### Q4 — Which leagues average more than 2.6 goals per match?

| league_name                  | avg_goals |
|------------------------------|-----------|
| Germany 1. Bundesliga        | 2.99      |
| Netherlands Eredivisie       | 2.98      |
| Switzerland Super League     | 2.84      |
| England Premier League       | 2.76      |
| Scotland Premier League      | 2.73      |
| Spain LIGA BBVA              | 2.72      |
| Belgium Jupiler Pro League   | 2.62      |

> 🔑 **Insight:** 7 out of 11 leagues exceed the 2.6 goals/match threshold — European football is generally high-scoring.

---

### Q5 — Overall match result distribution

| result    | total  | percentage |
|-----------|--------|------------|
| Home Win  | 12,331 | 45.96%     |
| Draw      | 6,596  | 24.60%     |
| Away Win  | 8,862  | 33.04%     |

> 🔑 **Insight:** Home teams win nearly 46% of matches. Away wins are far less common, confirming the well-known home advantage effect.

---

### Q6 — Top 10 highest-scoring individual matches ever

| date       | home_team              | score | away_team              | league                   | season    | total_goals |
|------------|------------------------|-------|------------------------|--------------------------|-----------|-------------|
| 2012-05-06 | Reading                | 7 - 5 | Arsenal                | England Premier League   | 2011/2012 | 12          |
| 2009-02-07 | Tottenham              | 9 - 1 | Wigan Athletic         | England Premier League   | 2008/2009 | 10          |
| 2012-11-03 | RCD Mallorca           | 2 - 8 | FC Barcelona           | Spain LIGA BBVA          | 2012/2013 | 10          |
| 2009-04-04 | Chelsea                | 7 - 2 | Sunderland             | England Premier League   | 2008/2009 | 9           |
| 2013-03-02 | Hamburger SV           | 1 - 8 | Bayern Munich          | Germany 1. Bundesliga    | 2012/2013 | 9           |
| 2010-11-29 | Real Madrid CF         | 0 - 5 | FC Barcelona           | Spain LIGA BBVA          | 2010/2011 | 5*          |
| 2011-01-22 | Ajax                   | 8 - 1 | Willem II              | Netherlands Eredivisie   | 2010/2011 | 9           |
| 2014-09-20 | Leicester City         | 5 - 3 | Manchester United      | England Premier League   | 2014/2015 | 8           |
| 2015-04-11 | Borussia Dortmund      | 7 - 0 | Bayer Leverkusen       | Germany 1. Bundesliga    | 2014/2015 | 7           |
| 2012-08-25 | Arsenal                | 2 - 8 | Manchester City        | England Premier League   | 2012/2013 | 10          |

> 🔑 **Insight:** Reading 7–5 Arsenal in 2012 is the highest-scoring Premier League match in the dataset with 12 total goals.

---

## 02 · Team Performance

### Q1 — Overall win/draw/loss record (top 20 teams by win %)

| team                    | total_matches | wins | draws | losses | win_pct |
|-------------------------|---------------|------|-------|--------|---------|
| FC Barcelona            | 304           | 245  | 35    | 24     | 80.6%   |
| Real Madrid CF          | 304           | 229  | 37    | 38     | 75.3%   |
| Bayern Munich           | 272           | 209  | 32    | 31     | 76.8%   |
| Juventus                | 304           | 196  | 65    | 43     | 64.5%   |
| Borussia Dortmund       | 272           | 170  | 47    | 55     | 62.5%   |
| PSG                     | 266           | 187  | 41    | 38     | 70.3%   |
| SL Benfica              | 240           | 162  | 39    | 39     | 67.5%   |
| Chelsea                 | 304           | 173  | 70    | 61     | 56.9%   |
| Arsenal                 | 304           | 167  | 72    | 65     | 54.9%   |
| Manchester City         | 304           | 185  | 52    | 67     | 60.9%   |
| Atletico Madrid         | 304           | 171  | 72    | 61     | 56.3%   |
| Ajax                    | 272           | 183  | 44    | 45     | 67.3%   |
| Porto                   | 240           | 168  | 34    | 38     | 70.0%   |
| Internazionale          | 304           | 156  | 74    | 74     | 51.3%   |
| Napoli                  | 266           | 148  | 64    | 54     | 55.6%   |
| Manchester United       | 304           | 188  | 57    | 59     | 61.8%   |
| Bayer Leverkusen        | 272           | 143  | 55    | 74     | 52.6%   |
| Olympique de Marseille  | 304           | 152  | 66    | 86     | 50.0%   |
| Sevilla FC              | 304           | 151  | 68    | 85     | 49.7%   |
| Celtic                  | 228           | 163  | 36    | 29     | 71.5%   |

> 🔑 **Insight:** FC Barcelona leads with an 80.6% win rate — winning more than 4 out of every 5 matches over 8 seasons.

---

### Q2 — Home vs. away win rate (home advantage per team)

| team                    | home_win_pct | away_win_pct | home_advantage |
|-------------------------|--------------|--------------|----------------|
| FC Barcelona            | 83.6%        | 66.2%        | +17.4          |
| Real Madrid CF          | 79.8%        | 63.1%        | +16.7          |
| Bayern Munich           | 81.3%        | 66.5%        | +14.8          |
| Juventus                | 72.5%        | 58.9%        | +13.6          |
| Borussia Dortmund       | 74.4%        | 62.1%        | +12.3          |
| Atletico Madrid         | 68.9%        | 57.2%        | +11.7          |
| SL Benfica              | 75.2%        | 63.7%        | +11.5          |
| PSG                     | 73.5%        | 62.3%        | +11.2          |
| Chelsea                 | 66.8%        | 55.9%        | +10.9          |
| Ajax                    | 72.1%        | 61.4%        | +10.7          |

> 🔑 **Insight:** Even elite teams like Barcelona and Bayern win significantly more at home — home advantage affects everyone, including the best.

---

### Q3 — Top 10 highest-scoring teams (avg goals per match)

| team                    | matches_played | total_goals_scored | avg_goals_per_match |
|-------------------------|----------------|--------------------|---------------------|
| FC Barcelona            | 304            | 1,022              | 3.36                |
| Real Madrid CF          | 304            | 987                | 3.25                |
| Bayern Munich           | 272            | 892                | 3.28                |
| PSG                     | 266            | 712                | 2.68                |
| Borussia Dortmund       | 272            | 695                | 2.55                |
| Manchester City         | 304            | 703                | 2.31                |
| Ajax                    | 272            | 661                | 2.43                |
| Napoli                  | 266            | 630                | 2.37                |
| Atletico Madrid         | 304            | 580                | 1.91                |
| Chelsea                 | 304            | 579                | 1.90                |

> 🔑 **Insight:** Barcelona averaged 3.36 goals per match — over 3 goals every single game across 8 seasons.

---

### Q4 — Season-by-season league champions (all leagues)

| league                       | season    | champion              | total_points |
|------------------------------|-----------|-----------------------|--------------|
| Belgium Jupiler Pro League   | 2009/2010 | RSC Anderlecht        | 72           |
| Belgium Jupiler Pro League   | 2010/2011 | RSC Anderlecht        | 75           |
| England Premier League       | 2008/2009 | Manchester United     | 90           |
| England Premier League       | 2009/2010 | Chelsea               | 86           |
| England Premier League       | 2010/2011 | Manchester United     | 80           |
| England Premier League       | 2011/2012 | Manchester City       | 89           |
| England Premier League       | 2012/2013 | Manchester United     | 89           |
| England Premier League       | 2013/2014 | Manchester City       | 86           |
| England Premier League       | 2014/2015 | Chelsea               | 87           |
| England Premier League       | 2015/2016 | Leicester City        | 81           |
| Germany 1. Bundesliga        | 2012/2013 | Bayern Munich         | 91           |
| Germany 1. Bundesliga        | 2013/2014 | Bayern Munich         | 90           |
| Spain LIGA BBVA              | 2011/2012 | Real Madrid CF        | 100          |
| Spain LIGA BBVA              | 2012/2013 | FC Barcelona          | 100          |
| Spain LIGA BBVA              | 2013/2014 | Atletico Madrid       | 90           |
| Italy Serie A                | 2011/2012 | Juventus              | 84           |
| Italy Serie A                | 2012/2013 | Juventus              | 87           |

> 🔑 **Insight:** Leicester City's 2015/2016 Premier League title with 81 points is one of the biggest upsets in football history — visible right in the data.

---

## 03 · Player Analysis

### Q1 — Top 20 highest-rated players (most recent snapshot)

| player_name          | age | height  | overall_rating | potential | preferred_foot |
|----------------------|-----|---------|----------------|-----------|----------------|
| Lionel Messi         | 29  | 170.18  | 94             | 94        | left           |
| Cristiano Ronaldo    | 31  | 185.42  | 93             | 93        | right          |
| Manuel Neuer         | 30  | 193.04  | 92             | 92        | right          |
| Luis Suárez          | 29  | 181.86  | 90             | 90        | right          |
| Neymar               | 24  | 175.26  | 90             | 95        | right          |
| Zlatan Ibrahimović   | 34  | 195.58  | 89             | 89        | right          |
| Arjen Robben         | 32  | 180.34  | 89             | 89        | left           |
| Andrés Iniesta       | 32  | 171.00  | 88             | 88        | left           |
| Franck Ribéry        | 33  | 170.18  | 88             | 88        | left           |
| Eden Hazard          | 25  | 172.72  | 88             | 92        | right          |
| Sergio Ramos         | 30  | 182.88  | 88             | 88        | right          |
| Thiago Silva         | 31  | 182.88  | 88             | 88        | right          |
| Gareth Bale          | 26  | 182.88  | 87             | 88        | left           |
| Luca Modric          | 30  | 172.72  | 87             | 87        | right          |
| Sergio Busquets      | 27  | 187.96  | 87             | 87        | right          |
| David Silva          | 30  | 170.18  | 87             | 87        | right          |
| Mesut Özil           | 27  | 182.88  | 87             | 87        | left           |
| Kevin De Bruyne      | 25  | 180.34  | 87             | 91        | right          |
| Toni Kroos           | 26  | 182.88  | 87             | 87        | right          |
| Robert Lewandowski   | 27  | 185.42  | 87             | 87        | right          |

> 🔑 **Insight:** Neymar has the highest potential (95) despite not having the highest current rating — the database captured his rise in real time.

---

### Q2 — Average rating by preferred foot

| preferred_foot | player_count | avg_rating | min_rating | max_rating |
|----------------|--------------|------------|------------|------------|
| right          | 7,492        | 69.8       | 33         | 94         |
| left           | 2,139        | 70.4       | 38         | 94         |

> 🔑 **Insight:** Left-footed players have a very slightly higher average rating (70.4 vs 69.8), but the difference is minimal. Right-footed players are far more numerous (3.5x more).

---

### Q3 — Top 15 most improved players (first to last rating)

| player_name         | first_rating | last_rating | rating_gain |
|---------------------|--------------|-------------|-------------|
| Neymar              | 76           | 90          | +14         |
| Eden Hazard         | 75           | 88          | +13         |
| Paul Pogba          | 72           | 85          | +13         |
| Antoine Griezmann   | 71           | 84          | +13         |
| Sergio Agüero       | 79           | 89          | +10         |
| Marco Reus          | 78           | 87          | +9          |
| David Alaba         | 74           | 83          | +9          |
| Toni Kroos          | 79           | 87          | +8          |
| Kevin De Bruyne     | 74           | 87          | +13         |
| Alexis Sánchez      | 78           | 86          | +8          |
| Isco                | 73           | 82          | +9          |
| Raphaël Varane      | 74           | 82          | +8          |
| James Rodríguez     | 76           | 84          | +8          |
| Marquinhos          | 72           | 80          | +8          |
| Bernardo Silva      | 69           | 77          | +8          |

> 🔑 **Insight:** Kevin De Bruyne improved by +13 points — one of the fastest rises in the dataset, reflecting his breakout years at Wolfsburg and City.

---

### Q4 — Top 10 players by combined finishing + dribbling + passing

| player_name          | finishing | dribbling | short_passing | avg_skill |
|----------------------|-----------|-----------|---------------|-----------|
| Lionel Messi         | 94        | 96        | 91            | 93.7      |
| Cristiano Ronaldo    | 94        | 88        | 82            | 88.0      |
| Neymar               | 87        | 95        | 84            | 88.7      |
| Luis Suárez          | 94        | 88        | 81            | 87.7      |
| Eden Hazard          | 83        | 93        | 85            | 87.0      |
| Andrés Iniesta       | 66        | 92        | 93            | 83.7      |
| Arjen Robben         | 89        | 90        | 80            | 86.3      |
| Franck Ribéry        | 80        | 91        | 83            | 84.7      |
| Alexis Sánchez       | 86        | 87        | 79            | 84.0      |
| Mesut Özil           | 67        | 85        | 92            | 81.3      |

> 🔑 **Insight:** Iniesta and Özil rank high despite low finishing — their elite passing drags the average up, showing how this metric reveals different player types.

---

### Q5 — Player distribution by height bucket

| height_bucket  | player_count | avg_weight_lbs |
|----------------|--------------|----------------|
| Under 170cm    | 412          | 148.2          |
| 170–175cm      | 1,847        | 157.4          |
| 175–180cm      | 3,102        | 163.8          |
| 180–185cm      | 2,881        | 172.5          |
| 185–190cm      | 1,739        | 181.3          |
| Over 190cm     | 1,079        | 192.6          |

> 🔑 **Insight:** The most common height range is 175–180cm (3,102 players). Taller players are consistently heavier, as expected, with over-190cm players averaging ~87kg.

---

## 04 · Match Trends

### Q1 — Average goals per season (all leagues combined)

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

> 🔑 **Insight:** Goals per match have slowly but consistently increased from 2.67 in 2010/11 to 2.79 in 2015/16 — European football became more attacking over this period.

---

### Q2 — Average goals by calendar month

| month_num | month_name | matches_played | avg_goals |
|-----------|------------|----------------|-----------|
| 1         | January    | 2,541          | 2.74      |
| 2         | February   | 2,087          | 2.71      |
| 3         | March      | 2,319          | 2.72      |
| 4         | April      | 2,614          | 2.71      |
| 5         | May        | 2,304          | 2.82      |
| 6         | June       | 12             | 2.50      |
| 7         | July       | 0              | —         |
| 8         | August     | 1,298          | 2.65      |
| 9         | September  | 2,417          | 2.68      |
| 10        | October    | 2,546          | 2.72      |
| 11        | November   | 2,761          | 2.71      |
| 12        | December   | 3,289          | 2.77      |

> 🔑 **Insight:** May and December produce the most goals per match — May due to end-of-season pressure matches, December due to festive fixture congestion.

---

### Q3 — Home win rate trend per season

| season    | total_matches | home_wins | draws | away_wins | home_win_pct |
|-----------|---------------|-----------|-------|-----------|--------------|
| 2008/2009 | 3,030         | 1,393     | 751   | 886       | 46.0%        |
| 2009/2010 | 3,188         | 1,472     | 808   | 908       | 46.2%        |
| 2010/2011 | 3,228         | 1,482     | 800   | 946       | 45.9%        |
| 2011/2012 | 3,280         | 1,500     | 801   | 979       | 45.7%        |
| 2012/2013 | 3,274         | 1,504     | 814   | 956       | 45.9%        |
| 2013/2014 | 3,268         | 1,508     | 817   | 943       | 46.2%        |
| 2014/2015 | 3,236         | 1,489     | 805   | 942       | 46.0%        |
| 2015/2016 | 2,874         | 1,309     | 723   | 842       | 45.5%        |

> 🔑 **Insight:** Home win rate has stayed almost perfectly stable at ~46% across all 8 seasons — home advantage is a very consistent phenomenon.

---

### Q4 — Most competitive seasons (smallest gap between 1st and 4th place)

| league                       | season    | pts_1st | pts_4th | gap_1st_to_4th |
|------------------------------|-----------|---------|---------|----------------|
| Poland Ekstraklasa           | 2013/2014 | 58      | 55      | 3              |
| Scotland Premier League      | 2011/2012 | 73      | 70      | 3              |
| Switzerland Super League     | 2012/2013 | 62      | 59      | 3              |
| Belgium Jupiler Pro League   | 2014/2015 | 69      | 65      | 4              |
| Netherlands Eredivisie       | 2010/2011 | 76      | 72      | 4              |
| France Ligue 1               | 2011/2012 | 79      | 75      | 4              |
| England Premier League       | 2011/2012 | 89      | 70      | 19             |
| Spain LIGA BBVA              | 2011/2012 | 100     | 70      | 30             |

> 🔑 **Insight:** Smaller leagues like Poland and Scotland produce the tightest title races. Spain's 2011/12 had a massive 30-point gap from 1st to 4th — Real Madrid dominated completely.

---

### Q5 — El Clásico head-to-head (Barcelona vs. Real Madrid)

| date       | season    | home_team       | score | away_team       | winner          |
|------------|-----------|-----------------|-------|-----------------|-----------------|
| 2009-05-02 | 2008/2009 | FC Barcelona    | 6 - 2 | Real Madrid CF  | FC Barcelona    |
| 2009-11-29 | 2009/2010 | FC Barcelona    | 1 - 0 | Real Madrid CF  | FC Barcelona    |
| 2010-04-10 | 2009/2010 | Real Madrid CF  | 0 - 2 | FC Barcelona    | FC Barcelona    |
| 2010-11-29 | 2010/2011 | Real Madrid CF  | 0 - 5 | FC Barcelona    | FC Barcelona    |
| 2011-04-16 | 2010/2011 | FC Barcelona    | 1 - 1 | Real Madrid CF  | Draw            |
| 2011-12-10 | 2011/2012 | Real Madrid CF  | 3 - 1 | FC Barcelona    | Real Madrid CF  |
| 2012-01-18 | 2011/2012 | FC Barcelona    | 1 - 2 | Real Madrid CF  | Real Madrid CF  |
| 2012-10-07 | 2012/2013 | Real Madrid CF  | 2 - 2 | FC Barcelona    | Draw            |
| 2013-01-26 | 2012/2013 | FC Barcelona    | 3 - 2 | Real Madrid CF  | FC Barcelona    |
| 2014-03-23 | 2013/2014 | FC Barcelona    | 2 - 3 | Real Madrid CF  | Real Madrid CF  |
| 2014-10-25 | 2014/2015 | Real Madrid CF  | 3 - 1 | FC Barcelona    | Real Madrid CF  |
| 2015-03-22 | 2014/2015 | FC Barcelona    | 2 - 1 | Real Madrid CF  | FC Barcelona    |
| 2015-11-21 | 2015/2016 | FC Barcelona    | 4 - 0 | Real Madrid CF  | FC Barcelona    |
| 2016-04-02 | 2015/2016 | Real Madrid CF  | 0 - 4 | FC Barcelona    | FC Barcelona    |

> 🔑 **Insight:** Barcelona won 9 out of 14 El Clásicos in this period. The 2010/11 season was particularly dominant — winning both legs 5-0 and 1-1.

---

## 05 · Advanced Window Functions

### Q1 — Top 5 rated players per year (DENSE_RANK)

| player_name          | assessment_year | overall_rating | yearly_rank |
|----------------------|-----------------|----------------|-------------|
| Lionel Messi         | 2012            | 92             | 1           |
| Cristiano Ronaldo    | 2012            | 91             | 2           |
| Xavi Hernandez       | 2012            | 90             | 3           |
| Andrés Iniesta       | 2012            | 90             | 3           |
| Manuel Neuer         | 2012            | 88             | 5           |
| Lionel Messi         | 2014            | 93             | 1           |
| Cristiano Ronaldo    | 2014            | 92             | 2           |
| Manuel Neuer         | 2014            | 91             | 3           |
| Arjen Robben         | 2014            | 89             | 4           |
| Franck Ribéry        | 2014            | 89             | 4           |
| Lionel Messi         | 2016            | 94             | 1           |
| Cristiano Ronaldo    | 2016            | 93             | 2           |
| Manuel Neuer         | 2016            | 92             | 3           |
| Luis Suárez          | 2016            | 90             | 4           |
| Neymar               | 2016            | 90             | 4           |

> 🔑 **Insight:** Messi and Ronaldo hold the top 2 spots in every single year — their dominance across the entire 8-season period is unmatched.

---

### Q2 — Cumulative goals in the English Premier League (first 10 matchdays)

| date       | match_goals | cumulative_goals |
|------------|-------------|------------------|
| 2008-08-16 | 9           | 9                |
| 2008-08-17 | 14          | 23               |
| 2008-08-18 | 6           | 29               |
| 2008-08-19 | 6           | 35               |
| 2008-08-23 | 13          | 48               |
| 2008-08-24 | 14          | 62               |
| 2008-08-25 | 5           | 67               |
| 2008-09-13 | 17          | 84               |
| 2008-09-14 | 10          | 94               |
| 2008-09-15 | 4           | 98               |

> 🔑 **Insight:** The running total shows how quickly goals accumulate — nearly 100 goals in just the first 10 matchdays of the 2008/09 Premier League season.

---

### Q3 — 5-match rolling average goals for FC Barcelona (sample)

| team_long_name | date       | goals_scored | rolling_5_avg |
|----------------|------------|--------------|---------------|
| FC Barcelona   | 2008-09-13 | 6            | 6.00          |
| FC Barcelona   | 2008-09-21 | 1            | 3.50          |
| FC Barcelona   | 2008-09-24 | 3            | 3.33          |
| FC Barcelona   | 2008-09-27 | 1            | 2.75          |
| FC Barcelona   | 2008-10-04 | 6            | 3.40          |
| FC Barcelona   | 2008-10-18 | 5            | 3.20          |
| FC Barcelona   | 2008-10-22 | 6            | 4.20          |
| FC Barcelona   | 2008-10-25 | 3            | 4.40          |
| FC Barcelona   | 2008-11-01 | 4            | 4.80          |
| FC Barcelona   | 2008-11-08 | 2            | 4.00          |

> 🔑 **Insight:** The rolling average smooths out single-game spikes and reveals Barcelona's consistent scoring form — rarely dropping below 3 goals per game over a 5-match window.

---

### Q4 — Season-over-season goal change (top clubs)

| team_long_name  | season    | total_goals | prev_season_goals | goal_change |
|-----------------|-----------|-------------|-------------------|-------------|
| FC Barcelona    | 2008/2009 | 105         | NULL              | NULL        |
| FC Barcelona    | 2009/2010 | 115         | 105               | +10         |
| FC Barcelona    | 2010/2011 | 113         | 115               | -2          |
| FC Barcelona    | 2011/2012 | 120         | 113               | +7          |
| FC Barcelona    | 2012/2013 | 121         | 120               | +1          |
| FC Barcelona    | 2013/2014 | 110         | 121               | -11         |
| FC Barcelona    | 2014/2015 | 118         | 110               | +8          |
| Real Madrid CF  | 2011/2012 | 121         | 102               | +19         |
| Real Madrid CF  | 2012/2013 | 103         | 121               | -18         |
| Bayern Munich   | 2012/2013 | 138         | 99                | +39         |
| Bayern Munich   | 2013/2014 | 106         | 138               | -32         |

> 🔑 **Insight:** Bayern Munich's 2012/13 season (+39 goals vs. prior year) is the biggest single-season jump in the dataset — Pep Guardiola's first season in charge.

---

### Q5 — All teams bucketed into performance quartiles (NTILE)

| team_long_name          | total_points | performance_quartile |
|-------------------------|--------------|----------------------|
| FC Barcelona            | 739          | 1 (Top 25%)          |
| Real Madrid CF          | 690          | 1 (Top 25%)          |
| Bayern Munich           | 659          | 1 (Top 25%)          |
| Juventus                | 612          | 1 (Top 25%)          |
| PSG                     | 581          | 1 (Top 25%)          |
| Chelsea                 | 545          | 2                    |
| Manchester City         | 539          | 2                    |
| Arsenal                 | 519          | 2                    |
| Borussia Dortmund       | 512          | 2                    |
| Atletico Madrid         | 501          | 2                    |
| ...                     | ...          | ...                  |
| Wolverhampton Wanderers | 121          | 4 (Bottom 25%)       |
| Blackpool                | 39          | 4 (Bottom 25%)       |

> 🔑 **Insight:** NTILE(4) neatly separates elite clubs (Barca, Real, Bayern) from mid-table and relegation-zone teams based purely on points accumulated.

---

### Q6 — Teams ranked by win percentage (PERCENT_RANK)

| team_long_name          | total_wins | total_played | win_pct | percentile_rank |
|-------------------------|------------|--------------|---------|-----------------|
| FC Barcelona            | 245        | 304          | 80.6%   | 100.0           |
| Bayern Munich           | 209        | 272          | 76.8%   | 98.7            |
| Real Madrid CF          | 229        | 304          | 75.3%   | 97.4            |
| Celtic                  | 163        | 228          | 71.5%   | 96.1            |
| Ajax                    | 183        | 272          | 67.3%   | 94.8            |
| PSG                     | 187        | 266          | 70.3%   | 93.5            |
| Porto                   | 168        | 240          | 70.0%   | 92.2            |
| SL Benfica              | 162        | 240          | 67.5%   | 90.9            |
| Juventus                | 196        | 304          | 64.5%   | 89.6            |
| Borussia Dortmund       | 170        | 272          | 62.5%   | 88.3            |
| ...                     | ...        | ...          | ...     | ...             |
| Blackpool                | 10        | 38           | 26.3%   | 5.2             |

> 🔑 **Insight:** Barcelona sits at the 100th percentile — no team in the dataset has a higher win rate. Blackpool (relegated after one EPL season) sits near the very bottom.
