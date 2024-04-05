WITH Medians AS (
    SELECT 
        country,
        PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY daily_vaccinations) OVER (PARTITION BY country) AS median_daily_vaccinations
    FROM 
        your_table_name
    WHERE 
        daily_vaccinations IS NOT NULL
    GROUP BY 
        country
),
FilledData AS (
    SELECT 
        t.*,
        COALESCE(t.daily_vaccinations, m.median_daily_vaccinations, 0) AS filled_daily_vaccinations
    FROM 
        your_table_name t
    LEFT JOIN 
        Medians m ON t.country = m.country
)
SELECT * FROM FilledData;