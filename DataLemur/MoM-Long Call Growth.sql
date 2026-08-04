-- =====================================================
-- Problem: Month-over-Month Long Call Growth
-- Platform: DataLemur
-- Difficulty: Hard
-- =====================================================

/*
Problem Statement

UnitedHealth Group (UHG) wants to
measure the month-over-month growth
rate of long calls made through the
Advocate4Me program.

A long call is defined as a call
lasting more than 5 minutes
(300 seconds).

Return the year, month, and the
month-over-month growth percentage
for long calls.

Round the growth percentage to
1 decimal place and order the
results chronologically.
*/

-- =====================================================
-- Table Schema
-- =====================================================

/*
callers

+----------------------+-----------+
| Column Name          | Type      |
+----------------------+-----------+
| policy_holder_id     | integer   |
| case_id              | varchar   |
| call_category        | varchar   |
| call_date            | timestamp |
| call_duration_secs   | integer   |
+----------------------+-----------+
*/

-- =====================================================
-- Solution
-- =====================================================

WITH monthly_calls AS (
    SELECT
        EXTRACT(YEAR FROM call_date) AS yr,
        EXTRACT(MONTH FROM call_date) AS mn,
        SUM(
            CASE
                WHEN call_duration_secs > 300 THEN 1
                ELSE 0
            END
        ) AS long_calls
    FROM callers
    GROUP BY
        EXTRACT(YEAR FROM call_date),
        EXTRACT(MONTH FROM call_date)
),
growth AS (
    SELECT
        *,
        LAG(long_calls) OVER (
            ORDER BY yr, mn
        ) AS prev_long_calls
    FROM monthly_calls
)

SELECT
    yr,
    mn,
    ROUND(
        100.0 * (long_calls - prev_long_calls)
        / prev_long_calls,
        1
    ) AS long_calls_growth_pct
FROM growth
ORDER BY
    yr,
    mn;

-- =====================================================
-- Explanation
-- =====================================================

/*
1. Count Monthly Long Calls

   Extract the year and month
   from each call date.

   Count only calls lasting
   more than 300 seconds.

2. Find Previous Month

   Use the LAG() window function
   to retrieve the previous
   month's long-call count.

3. Calculate Growth Rate

   Apply the formula:

   ((Current - Previous)
    / Previous) × 100

4. Round the Result

   ROUND(..., 1) formats the
   percentage to one decimal
   place.

5. Sort Chronologically

   Order by year first and then
   month to ensure the results
   are in chronological order.
*/

-- =====================================================
-- Time Complexity
-- =====================================================

/*
O(n log n)

n = number of rows in callers

- GROUP BY scans all calls.
- LAG() processes grouped rows
  in chronological order.
- Final ORDER BY sorts the
  monthly results.
*/

-- =====================================================
-- Key Concepts
-- =====================================================

/*
- Common Table Expressions (CTEs)
- CASE WHEN
- SUM()
- EXTRACT()
- GROUP BY
- Window Functions
- LAG()
- Percentage Calculation
- ROUND()
- ORDER BY
*/
