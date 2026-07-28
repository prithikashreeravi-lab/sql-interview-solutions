-- =====================================================
-- Problem: Odd and Even Measurements
-- Platform: DataLemur
-- Difficulty: Medium
-- =====================================================

/*
Problem Statement

Google collects sensor measurements throughout
the day, with multiple measurements recorded
at different times.

For each day, calculate:

- odd_sum  → Sum of the 1st, 3rd, 5th, ...
             measurements of the day.
- even_sum → Sum of the 2nd, 4th, 6th, ...
             measurements of the day.

Return:
- measurement_day
- odd_sum
- even_sum

Order the result by measurement_day.
*/

-- =====================================================
-- Table Schema
-- =====================================================

/*
measurements

+-------------------+----------+
| Column Name       | Type     |
+-------------------+----------+
| measurement_id    | integer  |
| measurement_value | decimal  |
| measurement_time  | datetime |
+-------------------+----------+
*/

-- =====================================================
-- Solution
-- =====================================================

WITH cte AS (
    SELECT
        *,
        ROW_NUMBER() OVER (
            PARTITION BY CAST(measurement_time AS DATE)
            ORDER BY measurement_time
        ) AS rn
    FROM measurements
)

SELECT
    CAST(measurement_time AS DATE) AS measurement_day,
    SUM(
        CASE
            WHEN rn % 2 = 1 THEN measurement_value
            ELSE 0
        END
    ) AS odd_sum,
    SUM(
        CASE
            WHEN rn % 2 = 0 THEN measurement_value
            ELSE 0
        END
    ) AS even_sum
FROM cte
GROUP BY
    CAST(measurement_time AS DATE)
ORDER BY
    measurement_day;

-- =====================================================
-- Explanation
-- =====================================================

/*
1. Assign Row Numbers
   - Use ROW_NUMBER() to number each measurement
     within a day.
   - PARTITION BY resets the numbering for each day.
   - ORDER BY measurement_time ensures the earliest
     measurement is numbered 1, the next is 2,
     and so on.

2. Identify Odd and Even Measurements
   - rn % 2 = 1 identifies odd-numbered
     measurements.
   - rn % 2 = 0 identifies even-numbered
     measurements.

3. Calculate Daily Totals
   - SUM() with CASE expressions separately
     totals the odd and even measurements
     for each day.

4. Sort the Result
   - Display each day's totals in
     chronological order.

--------------------------------------------------------
Example
--------------------------------------------------------

Measurements

Time     Value
-------  -----
08:00      10
09:00      20
10:00      15
11:00      30
12:00      25

After ROW_NUMBER()

Time     Value   rn
-------  -----   --
08:00      10     1
09:00      20     2
10:00      15     3
11:00      30     4
12:00      25     5

Odd Measurements
10 + 15 + 25 = 50

Even Measurements
20 + 30 = 50

Final Result

Day          Odd Sum   Even Sum
-----------  -------   --------
2022-08-01      50         50

--------------------------------------------------------
Time Complexity
--------------------------------------------------------

O(n log n)

- ROW_NUMBER() sorts measurements within
  each day.
- GROUP BY aggregates daily totals.
- Final ORDER BY sorts the result by date.

--------------------------------------------------------
Key Concepts
--------------------------------------------------------

- Common Table Expressions (CTEs)
- ROW_NUMBER()
- Window Functions
- PARTITION BY
- ORDER BY
- CASE WHEN
- SUM()
- Conditional Aggregation
- GROUP BY
