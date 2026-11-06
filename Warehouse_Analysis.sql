sql = -- Warehouse Safety & Operational Performance Analysis
-- Independent practice project using illustrative sample data.
-- This is Sample data.

CREATE TABLE warehouse_incidents (
    incident_id INTEGER,
    warehouse VARCHAR(10),
    severity VARCHAR(20),
    incident_type VARCHAR(50),
    orders INTEGER,
    lost_days INTEGER
);

INSERT INTO warehouse_incidents VALUES
(1001, 'BLR1', 'High',   'Equipment', 1000, 5),
(1002, 'CHN1', 'HIGH',   'Safety',     800, 8),
(1003, 'HYD1', 'Low',    'Equipment', 1200, 2),
(1004, 'MAA1', 'Medium', 'Safety',     900, 4),
(1005, 'CHN1', 'High',   'Equipment',  800, 10),
(1006, 'BLR1', 'Medium', 'Safety',    1000, 3),
(1007, 'HYD1', 'HIGH',   'Safety',    1200, 6),
(1008, 'MAA1', 'Low',    'Equipment',  900, 1),
(1009, 'CHN1', 'Medium', 'Safety',     800, 5),
(1005, 'CHN1', 'High',   'Equipment',  800, 10), -- intentional duplicate
(1011, 'BLR1', 'High',   'Equipment', 1000, 7),
(1012, 'HYD1', 'Medium', 'Safety',    1200, 3);

-- 1. Find duplicate incident IDs
SELECT
    incident_id,
    COUNT(*) AS record_count
FROM warehouse_incidents
GROUP BY incident_id
HAVING COUNT(*) > 1;

-- 2. Deduplicate records and standardise severity
WITH ranked AS (
    SELECT *,
           ROW_NUMBER() OVER (
               PARTITION BY incident_id
               ORDER BY incident_id
           ) AS rn
    FROM warehouse_incidents
),
cleaned AS (
    SELECT
        incident_id,
        warehouse,
        UPPER(severity) AS severity,
        incident_type,
        orders,
        lost_days
    FROM ranked
    WHERE rn = 1
)
SELECT *
FROM cleaned;

-- 3. Calculate warehouse-level KPIs
-- Orders is repeated on each incident row but represents the
-- warehouse-level denominator. MAX(orders) avoids summing repeats.
WITH ranked AS (
    SELECT *,
           ROW_NUMBER() OVER (
               PARTITION BY incident_id
               ORDER BY incident_id
           ) AS rn
    FROM warehouse_incidents
),
cleaned AS (
    SELECT
        incident_id,
        warehouse,
        UPPER(severity) AS severity,
        incident_type,
        orders,
        lost_days
    FROM ranked
    WHERE rn = 1
)
SELECT
    warehouse,
    COUNT(*) AS total_incidents,
    SUM(CASE WHEN severity = 'HIGH' THEN 1 ELSE 0 END) AS high_incidents,
    ROUND(
        100.0 * SUM(CASE WHEN severity = 'HIGH' THEN 1 ELSE 0 END)
        / COUNT(*), 2
    ) AS high_severity_percentage,
    SUM(lost_days) AS total_lost_days,
    MAX(orders) AS warehouse_orders,
    ROUND(100.0 * COUNT(*) / NULLIF(MAX(orders), 0), 3) AS incident_rate_percentage,
    ROUND(1.0 * SUM(lost_days) / COUNT(*), 2) AS lost_days_per_incident
FROM cleaned
GROUP BY warehouse
ORDER BY incident_rate_percentage DESC;

-- 4. Severity distribution by warehouse
WITH ranked AS (
    SELECT *,
           ROW_NUMBER() OVER (
               PARTITION BY incident_id
               ORDER BY incident_id
           ) AS rn
    FROM warehouse_incidents
)
SELECT
    warehouse,
    SUM(CASE WHEN UPPER(severity) = 'HIGH' THEN 1 ELSE 0 END) AS high_count,
    SUM(CASE WHEN UPPER(severity) = 'MEDIUM' THEN 1 ELSE 0 END) AS medium_count,
    SUM(CASE WHEN UPPER(severity) = 'LOW' THEN 1 ELSE 0 END) AS low_count
FROM ranked
WHERE rn = 1
GROUP BY warehouse
ORDER BY warehouse;

