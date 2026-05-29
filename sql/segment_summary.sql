WITH session_metrics AS (
    SELECT
        player_id,
        COUNT(*) AS total_sessions,
        ROUND(AVG(duration_seconds) / 60, 1) AS avg_session_min
    FROM `Casino_dataset.sessions`
    GROUP BY player_id
),
purchase_metrics AS (
    SELECT
        player_id,
        COUNT(*) AS purchases,
        ROUND(SUM(price_usd), 2) AS revenue_usd
    FROM `Casino_dataset.purchases`
    GROUP BY player_id
),
social_metrics AS (
    SELECT
        from_player_id AS player_id,
        COUNT(*) AS social_interactions
    FROM `Casino_dataset.social_interactions`
    GROUP BY from_player_id
),

player_metrics AS (
    SELECT
        p.player_id,
        p.archetype,
        p.is_payer,
        p.is_churned,
        p.lifetime_days,
        COALESCE(s.total_sessions, 0) AS total_sessions,
        COALESCE(s.avg_session_min, 0) AS avg_session_min,
        COALESCE(pm.revenue_usd, 0) AS revenue_usd,
        COALESCE(pm.purchases, 0) AS purchases,
        COALESCE(sm.social_interactions, 0) AS social_interactions
    FROM `Casino_dataset.players` p
    LEFT JOIN session_metrics s
        ON p.player_id = s.player_id
    LEFT JOIN purchase_metrics pm
        ON p.player_id = pm.player_id
    LEFT JOIN social_metrics sm
        ON p.player_id = sm.player_id
)

SELECT
    archetype,
    COUNT(*) AS total_players,
    ROUND(AVG(lifetime_days), 1)
        AS avg_lifetime_days,
    ROUND(AVG(total_sessions), 1)
        AS avg_sessions,
    ROUND(AVG(avg_session_min), 1)
        AS avg_session_min,
    ROUND(AVG(revenue_usd), 2)
        AS arpu,
    ROUND(
        AVG(
            CASE
                WHEN revenue_usd > 0
                THEN revenue_usd
            END
        ),
        2
    ) AS arppu,
    ROUND(AVG(social_interactions), 1)
        AS avg_social_interactions,
    ROUND(
        AVG(CAST(is_churned AS INT64)) * 100,
        1
    ) AS churn_rate_pct,
    ROUND(
        AVG(CAST(is_payer AS INT64)) * 100,
        1
    ) AS payer_conversion_pct

FROM player_metrics
GROUP BY archetype
ORDER BY arpu DESC;