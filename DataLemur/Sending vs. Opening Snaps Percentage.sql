-- =====================================================
-- Problem: Sending vs. Opening Snaps Percentage
-- Platform: DataLemur
-- Difficulty: Medium
-- =====================================================

/*
Problem Statement

Snapchat records the time users spend on
different activities, including sending,
opening, and chatting.

Calculate the percentage of total time spent
sending and opening snaps for each age group.

Return:
- age_bucket
- send_pct
- open_pct

Requirements:
- send_pct =
  (time spent sending / total send & open time) × 100
- open_pct =
  (time spent opening / total send & open time) × 100
- Ignore 'chat' activities.
- Round percentages to 2 decimal places.
*/

-- =====================================================
-- Table Schema
-- =====================================================

/*
activities

+---------------+----------+
| Column Name   | Type     |
+---------------+----------+
| activity_id   | integer  |
| user_id       | integer  |
| activity_type | string   |
| time_spent    | float    |
| activity_date | datetime |
+---------------+----------+

age_breakdown

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| user_id     | integer |
| age_bucket  | string  |
+-------------+---------+
*/

-- =====================================================
-- Solution
-- =====================================================

SELECT
    b.age_bucket,

    ROUND(
        100.0 * SUM(
            CASE
                WHEN a.activity_type = 'send'
                THEN a.time_spent
                ELSE 0
            END
        ) /
        NULLIF(
            SUM(
                CASE
                    WHEN a.activity_type IN ('send', 'open')
                    THEN a.time_spent
                    ELSE 0
                END
            ),
            0
        ),
        2
    ) AS send_pct,

    ROUND(
        100.0 * SUM(
            CASE
                WHEN a.activity_type = 'open'
                THEN a.time_spent
                ELSE 0
            END
        ) /
        NULLIF(
            SUM(
                CASE
                    WHEN a.activity_type IN ('send', 'open')
                    THEN a.time_spent
                    ELSE 0
                END
            ),
            0
        ),
        2
    ) AS open_pct

FROM activities AS a
JOIN age_breakdown AS b
    ON a.user_id = b.user_id

GROUP BY
    b.age_bucket;

-- =====================================================
-- Explanation
-- =====================================================

/*
1. Join the Tables

   - Join activities with age_breakdown
     using user_id.
   - This associates every activity with
     the user's age group.


2. Calculate Sending Time

   SUM(
       CASE
           WHEN activity_type = 'send'
           THEN time_spent
           ELSE 0
       END
   )

   - Adds only the time spent sending snaps.


3. Calculate Opening Time

   SUM(
       CASE
           WHEN activity_type = 'open'
           THEN time_spent
           ELSE 0
       END
   )

   - Adds only the time spent opening snaps.


4. Calculate Total Relevant Time

   SUM(
       CASE
           WHEN activity_type IN ('send', 'open')
           THEN time_spent
           ELSE 0
       END
   )

   - Includes only send and open activities.
   - Ignores chat activities.


5. Compute Percentages

   send_pct =
   (send_time / total_time) × 100

   open_pct =
   (open_time / total_time) × 100

   - Using 100.0 ensures floating-point
     division instead of integer division.


6. Prevent Division by Zero

   NULLIF(total_time, 0)

   - Returns NULL when total_time is zero,
     preventing divide-by-zero errors.


7. Round Results

   ROUND(value, 2)

   - Rounds both percentages to
     two decimal places.
*/

-- =====================================================
-- Time Complexity
-- =====================================================

/*
O(n)

- JOIN scans the matching rows.
- GROUP BY aggregates each age bucket.
- SUM() calculations are performed in
  a single pass through the data.
*/

-- =====================================================
-- Key Concepts
-- =====================================================

/*
- INNER JOIN
- GROUP BY
- CASE WHEN
- Conditional Aggregation
- SUM()
- ROUND()
- NULLIF()
- Percentage Calculations
*/
