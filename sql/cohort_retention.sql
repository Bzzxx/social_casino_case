WITH cohorts AS (
    SELECT
        player_id,
        FORMAT_DATE('%Y-%m', DATE(install_date)) AS cohort_month,
        DATE(install_date) AS install_date
    FROM `Casino_dataset.players`
),
cohort_sizes AS (
    SELECT
        cohort_month,
        COUNT(DISTINCT player_id) AS cohort_size
    FROM cohorts
    GROUP BY cohort_month

),
activity AS (
    SELECT
        c.player_id,
        c.cohort_month,
        d.days_since_install
    FROM cohorts c
    JOIN `Casino_dataset.player_daily_activity` d
        ON c.player_id = d.player_id
    WHERE d.days_since_install IN (1, 7, 14, 30)

)
SELECT
    cs.cohort_month,
    cs.cohort_size,
    ROUND(
        COUNT(DISTINCT CASE
            WHEN a.days_since_install = 1
            THEN a.player_id
        END)
        * 100.0 / cs.cohort_size,
        1
    ) AS d1_retention_pct,
    ROUND(
        COUNT(DISTINCT CASE
            WHEN a.days_since_install = 7
            THEN a.player_id
        END)
        * 100.0 / cs.cohort_size,
        1
    ) AS d7_retention_pct,
    ROUND(
        COUNT(DISTINCT CASE
            WHEN a.days_since_install = 14
            THEN a.player_id
        END)
        * 100.0 / cs.cohort_size,
        1
    ) AS d14_retention_pct,
    ROUND(
        COUNT(DISTINCT CASE
            WHEN a.days_since_install = 30
            THEN a.player_id
        END)
        * 100.0 / cs.cohort_size,
        1
    ) AS d30_retention_pct

FROM cohort_sizes cs
LEFT JOIN activity a
    ON cs.cohort_month = a.cohort_month
GROUP BY
    cs.cohort_month,
    cs.cohort_size
ORDER BY
    cs.cohort_month;