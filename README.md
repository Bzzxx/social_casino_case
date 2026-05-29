# Who Plays, Who Stays, Who Pays
Behavioral analytics for retention, monetization, and churn prediction in a social casino game.

This project analyzes player behavior in a synthetic social casino dataset to understand retention, churn, monetization, and the impact of social activity on lifetime.

---

## Tech Stack

- SQL (Google BigQuery)
- Python
- Pandas
- NumPy
- Plotly
- Matplotlib
- Seaborn
- Scikit-Learn

## Business Context

Social casino games depend on keeping players active and turning engaged users into payers.
This project looks at which players stay longer, which ones churn faster, and what behaviors are linked to better retention.

## Key Business Questions

- How is the player base distributed across segments?
- Which segments stay active the longest?
- Where does churn happen most often?
- How do social interactions affect lifetime?
- Which acquisition channels bring better players?
- Can churn be predicted from behavior?

## Dataset Overview

The project uses several behavioral tables:

| Table | Description |
|---|---|
| players | player profile and segment |
| sessions | gameplay sessions |
| purchases | in-game transactions |
| social_interactions | player-to-player interactions |
| player_daily_activity | daily aggregated activity |

- ~3,000 players
- ~80,000 sessions
- ~11,000 purchases
- ~41,000 social interactions

## Analytical Workflow

- cleaned and validated the data
- built segment-level metrics in SQL
- analyzed retention by cohort
- compared lifetime across channels and segments
- tested the link between social activity and lifetime
- trained churn prediction models

---

## Key Insights

- Casual players make up the largest share of the audience.
- Whale and engaged players stay active the longest and churn the least.
- Retention drops from D1 to D30 across all cohorts.
- Socially active players have much longer lifetimes than non-social players.
- Session activity and social interactions are the strongest churn predictors.

## Visualizations


![Player Distribution](images/player_distribution.png)


![Cohort Retention](images/cohort_heatmap.png)


![Feature Importance](images/feature_importance_v2.png)

## Project Notes

- I found and fixed a fan-out join issue that was inflating business metrics.
- Recent cohorts should be interpreted carefully because the 30-day retention window is incomplete.
- The churn model was tested without leakage-prone features such as lifetime and recency.
---

## Project Structure
```text
social-casino-case/
│
├── README.md
│
├── notebook/
│   └── Social_Casino_Case.ipynb
│
├── sql/
│   ├── player_segments.sql
│   ├── segment_summary.sql
│   └── cohort_retention.sql
│
├── data/
│   ├── raw/
│   │   ├── players.csv
│   │   ├── sessions.csv
│   │   ├── purchases.csv
│   │   ├── social_interactions.csv
│   │   └── player_daily_activity.csv
│   │
│   └── processed/
│       ├── player_segments.csv
│       ├── segment_summary.csv
│       └── cohort_retention.csv
│
└── images/
    ├── player_distribution.png
    ├── churn_rate.png
    ├── cohort_heatmap.png
    ├── social_activity_vs_lifetime.png
    ├── roc_curve.png
    └── feature_importance.png
```
