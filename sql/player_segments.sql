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
)

SELECT
    p.player_id,
    p.archetype,
    p.country_code,
    p.platform,
    p.device_tier,
    p.acquisition_channel,
    p.is_payer,
    p.is_churned,
    p.lifetime_days,
    p.install_date,
    p.last_active_date,

    COALESCE(s.total_sessions, 0) AS total_sessions,
    COALESCE(s.avg_session_min, 0) AS avg_session_min,
    COALESCE(pur.purchases, 0) AS purchases,
    COALESCE(pur.revenue_usd, 0) AS revenue_usd,
    COALESCE(si.social_interactions, 0) AS social_interactions,
    DATE_DIFF(
        DATE('2024-12-31'),
        DATE(p.last_active_date),
        DAY
    ) AS recency_days,
    CASE
        WHEN COALESCE(pur.revenue_usd, 0) >= 50 THEN 'high_value'
        WHEN COALESCE(pur.revenue_usd, 0) >= 10 THEN 'mid_value'
        ELSE 'low_value'
    END AS payer_segment

FROM `Casino_dataset.players` p

LEFT JOIN session_metrics s
    USING(player_id)
LEFT JOIN purchase_metrics pur
    USING(player_id)
LEFT JOIN social_metrics si
    USING(player_id)
ORDER BY revenue_usd DESC;