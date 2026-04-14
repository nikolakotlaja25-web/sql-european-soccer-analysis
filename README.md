# ⚽ European Soccer SQL Analysis

A collection of **intermediate-level SQL queries** analyzing 8 seasons of European football data (2008–2016) across 11 leagues. Built as a portfolio project for demonstrating real-world SQL skills using a publicly available Kaggle dataset.

---

## Dataset

**Source:** [European Soccer Database — Kaggle](https://www.kaggle.com/datasets/hugomathien/soccer)

**Author:** Hugo Mathien  
**License:** Open Database License (ODbL)  
**Format:** SQLite database (`database.sqlite`, ~300 MB)

The database contains **~26,000 matches**, **11,000+ players**, and **299 teams** across Belgium, England, France, Germany, Italy, the Netherlands, Poland, Portugal, Scotland, Spain, and Switzerland.

---

## Skills Demonstrated

| SQL Concept              | Where Used                                |
|--------------------------|-------------------------------------------|
| `JOIN` (multi-table)     | 01, 02, 03, 04, 05                       |
| `GROUP BY` / `HAVING`    | 01, 02, 03, 04                           |
| `CASE WHEN`              | 01, 02, 04, 05                           |
| Subqueries               | 01, 03                                   |
| Common Table Expressions (`WITH`) | 02, 03, 04, 05                |
| `UNION ALL`              | 02, 03, 05                               |
| Window functions (`RANK`, `LAG`, `NTILE`, `PERCENT_RANK`) | 03, 05 |
| Rolling averages         | 05                                       |
| Running totals           | 05                                       |
| Date functions           | 03, 04                                   |
| Bucketing / histograms   | 01, 03, 05                               |

---

## Project Structure

```
sql-european-soccer-analysis/
│
├── README.md                        ← You are here
│
├── schema/
│   └── schema_description.md        ← Full table & column reference + ERD
│
├── queries/
│   ├── 01_basic_exploration.sql     ← Foundational queries (SELECT, GROUP BY, HAVING)
│   ├── 02_team_performance.sql      ← Win rates, home advantage, season champions
│   ├── 03_player_analysis.sql       ← Ratings, skill comparisons, improvement trends
│   ├── 04_match_trends.sql          ← Seasonal patterns, goal trends, head-to-head
│   └── 05_advanced_window_functions.sql ← RANK, LAG, rolling avg, NTILE, PERCENT_RANK
│
└── results/
    └── sample_results.md            ← Sample output tables with insights
```

---

## How to Use

### 1. Download the dataset

Go to the Kaggle page and download `database.sqlite`:  
[https://www.kaggle.com/datasets/hugomathien/soccer](https://www.kaggle.com/datasets/hugomathien/soccer)

Place the file in the root of this repository.

### 2. Open in your SQL tool

Any of these tools work with SQLite:

- **DB Browser for SQLite** (free, GUI) — [https://sqlitebrowser.org](https://sqlitebrowser.org)
- **DBeaver** (free, GUI, multi-database) — [https://dbeaver.io](https://dbeaver.io)
- **VSCode** with the SQLite extension
- Python with `sqlite3` or `pandas`

### 3. Run the queries

Open any `.sql` file and run individual queries (separated by blank lines). They are self-contained — no setup scripts or imports needed beyond the `.sqlite` file.

---

## Query Files at a Glance

### `01_basic_exploration.sql`
Get familiar with the data. Covers match counts per league, goal averages, home vs. away win rates, and the top 10 highest-scoring matches ever.

### `02_team_performance.sql`
Digs into team records. Uses CTEs and `UNION ALL` to calculate win/draw/loss percentages, quantify the home advantage per team, and identify league champions by season using a full points-table calculation.

### `03_player_analysis.sql`
Explores FIFA player rating snapshots. Finds the top-rated players, compares left- vs. right-footed players, surfaces the players who improved most over their career, and shows skill specializations.

### `04_match_trends.sql`
Analyzes how football has evolved. Checks if goals per match are rising or falling, finds seasonal patterns by calendar month, tracks home win rates year by year, and runs a head-to-head El Clásico breakdown.

### `05_advanced_window_functions.sql`
The deepest queries. Uses `RANK`, `DENSE_RANK`, `LAG`, `LEAD`, `NTILE`, `PERCENT_RANK`, rolling averages, and running totals to answer questions that flat aggregations can't.

---

## Sample Insights

- **German Bundesliga** averages ~3 goals per match — the most attacking league in the dataset.
- **Home teams win ~46%** of all matches; away teams win only ~33%.
- **Neymar** improved his FIFA rating by +14 points across the dataset's timeline.
- **Bayern Munich's 2012/13 season** produced 138 goals — a massive outlier.
- The **2015/16 La Liga** season was decided by just 1 point between Barcelona and Real Madrid.

Full tables with values are in [`results/sample_results.md`](results/sample_results.md).

---

## Compatibility Notes

Queries are written for **SQLite** syntax. A few notes if you migrate to another engine:

| Feature                          | SQLite | PostgreSQL | MySQL  | BigQuery |
|----------------------------------|--------|------------|--------|----------|
| `strftime('%Y', date)`           | ✅     | Use `EXTRACT(YEAR FROM date)` | `YEAR(date)` | `EXTRACT(YEAR FROM date)` |
| `julianday()`                    | ✅     | Use `AGE()` | `DATEDIFF()` | `DATE_DIFF()` |
| `QUALIFY` clause (file 05, Q1)   | ❌     | ❌ (use subquery) | ❌ | ✅ |
| Window functions (`RANK`, `LAG`) | ✅ (3.25+) | ✅ | ✅ (8.0+) | ✅ |

---

## License

Dataset: [Open Database License (ODbL)](https://opendatacommons.org/licenses/odbl/)  
SQL code in this repo: MIT License — free to use, modify, and share.

---

*Built with the [European Soccer Database](https://www.kaggle.com/datasets/hugomathien/soccer) from Kaggle.*
