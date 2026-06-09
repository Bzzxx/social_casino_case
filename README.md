# Who Plays, Who Stays, Who Pays
Behavioral analytics for retention, monetization, and churn prediction in a social casino game.

---
Notebook:
[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)]
(https://colab.research.google.com/drive/1Nxp1lvYVci_Sbrxb4lLtc4PVTh87f4nL#scrollTo=SbSuCzibFdvC)
---

Behavioral analytics for retention, monetization, and churn prediction in a social casino game.

## Tech Stack

BigQuery · Python · pandas · scikit-learn · Plotly · Matplotlib · Seaborn

## Business Context

Social casino games depend on keeping players engaged and converting active users into payers.

## The goal of this analysis was to understand:

- who the players are,
- which segments create the most value,
- what drives retention,
- where churn happens,
- and whether churn can be predicted from player behavior.

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

 Casual players account for roughly half of the player base.
- Whale and engaged players stay active the longest and show the lowest churn rates.
- Retention declines consistently from D1 to D30 across cohorts.
- Socially active players demonstrate substantially longer lifetimes.
- Session activity and social interactions are among the strongest churn predictors.
- Random Forest outperformed Logistic Regression in churn prediction.

## Visualizations


![Player Distribution](images/player_distribution.png)


![Cohort Retention](images/cohort_heatmap.png)


![Feature Importance](images/feature_importance_v2.png)

---

## Notes From the Analysis

### Fan-out Join Issue

A direct join between player, session, purchase, and social tables produced inflated metrics because of row multiplication.

To avoid this issue, each behavioral table was aggregated separately before joining at the player level.

### Cohort Interpretation

Recent cohorts (November–December 2024) should be interpreted carefully because not all players had a complete 30-day observation window.

### Churn Modeling

Leakage-prone variables such as `lifetime_days` and `recency_days` were excluded from the final churn model to better reflect a realistic prediction scenario.
---

## Project Structure
```text
social-casino-case/

├── README.md

├── notebook/
│   └── Social_Casino_Case.ipynb

├── sql/
│   ├── player_segments.sql
│   ├── segment_summary.sql
│   └── cohort_retention.sql

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

└── images/
    ├── player_distribution.png
    ├── churn_rate.png
    ├── cohort_heatmap.png
    ├── social_activity_vs_lifetime.png
    ├── roc_curve.png
    └── feature_importance_v2.png
```
---

## What I Learned

During this project I practiced:

- designing analytical datasets in BigQuery
- cohort and retention analysis
- behavioral segmentation
- identifying data quality issues
- avoiding fan-out joins
- statistical testing
- building and evaluating churn prediction models
- translating analytical findings into business recommendations
