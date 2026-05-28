# Who Plays, Who Stays, Who Pays (Python, SQL (Google BigQuery), Statistics, Machine Learning)

Behavioral analytics project exploring retention, monetization, social engagement, and churn prediction in a mobile social casino game.

---

## Business Context

Social casino games rely heavily on player retention and monetization.
Understanding which users stay engaged, convert into payers, and eventually churn is critical for product growth.

This project simulates a real-world product analytics workflow using a synthetic behavioral dataset generated with Fabricate.tonic.ai.

## Key Business Questions

- What player segments exist and how do they differ?
- Which users generate the highest revenue?
- What affects player lifetime and retention?
- How do social interactions influence engagement?
- Where does churn happen most frequently?
- Can churn be predicted from player behavior?

## Dataset Overview

The project combines multiple behavioral tables:

| Table | Description |
|---|---|
| players | player profile and archetype |
| sessions | gameplay sessions |
| purchases | in-game transactions |
| social_interactions | player-to-player interactions |
| player_daily_activity | daily aggregated engagement |
| session_events | gameplay event logs |

- ~3,000 players
- ~80,000 sessions
- ~11,000 purchases
- ~41,000 social interactions

## Analytical Workflow

This project includes:

- exploratory data analysis (EDA)
- segmentation analysis
- cohort retention analysis
- monetization analysis
- social engagement analysis
- statistical testing
- churn prediction modeling

---

## Key Insights

- Whale payer users generate disproportionate revenue despite representing a small share of the player base.
- The largest retention drop occurs between D1 and D7.
- Socially active players demonstrate significantly longer lifetime.
- Early-session activity patterns are strong churn indicators.
- Platform differences had limited impact on payer conversion.

## Visualizations

### Retention Cohort Analysis
[image]

### Revenue by Player Segment
[image]

### Churn Prediction Feature Importance
[image]

---

## Project Structure
```text
social-casino-analytics/
├── README.md
├── notebook/
│   └── Social_Casino_Analytics.ipynb
├── data/
│   ├── players.csv
│   ├── sessions.csv
│   ├── purchases.csv
│   ├── social_interactions.csv
│   ├── player_daily_activity.csv
│   └── session_events.csv
├── images/
│   ├── cohort_heatmap.png
│   ├── revenue_by_segment.png
│   └── churn_feature_importance.png
├── sql/
│   ├── aggregation_1.sql
│   ├── aggregation_2.sql
│   └── aggregation_3.sql
└── requirements.txt
```

## Project Workflow

Fabricate.ai CSVs
        ↓
BigQuery SQL aggregations
        ↓
Python analysis & ML
        ↓
Business insights & recommendations
