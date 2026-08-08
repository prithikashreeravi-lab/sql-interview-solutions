-- =====================================================
-- Problem: Facebook Reactivated Users
-- Platform: DataLemur
-- Difficulty: Hard
-- =====================================================

/*
Problem Statement

Given Facebook user login data for 2022,
calculate the number of reactivated users
for each month.

A reactivated user is defined as a user who
was inactive during the previous month but
logged in during the current month.

If a user's first login in 2022 occurs during
a given month, we assume they had previously
logged in during 2021. Therefore, their first
login month in 2022 is considered a
reactivation month.

Return the month in numerical format along
with the number of reactivated users.
*/

-- =====================================================
-- Table Schema
-- =====================================================

/*
user_logins

+--------------+----------+
| Column Name  | Type     |
+--------------+----------+
| user_id      | integer  |
| login_date   | datetime |
+--------------+----------+
*/

-- =====================================================
-- Solution
-- =====================================================

WITH monthly_logins AS (

    /*
    Step 1:
    Get each user's unique login months.
    */

    SELECT DISTINCT
        user_id,
        DATE_TRUNC('month', login_date)::date AS login_month
    FROM user_logins

),

reactivated_users AS (

    /*
    Step 2:
    Compare each user's current month
    with their previous month.
    */

    SELECT
        curr.user_id,
        curr.login_month
    FROM monthly_logins curr

    LEFT JOIN monthly_logins prev
        ON curr.user_id = prev.user_id
        AND curr.login_month =
            prev.login_month + INTERVAL '1 month'

    /*
    Step 3:
    Keep users who did not log in
    during the previous month.
    */

    WHERE prev.user_id IS NULL
)

SELECT
    EXTRACT(MONTH FROM login_month) AS month,
    COUNT(*) AS reactivated_users
FROM reactivated_users
GROUP BY login_month
ORDER BY login_month;

-- =====================================================
-- Explanation
-- =====================================================

/*

1. Find Monthly Logins

   DATE_TRUNC('month') converts each
   login date into its corresponding
   month.

   DISTINCT ensures each user is counted
   only once per month, even if they
   logged in multiple times.

2. Compare Current and Previous Month

   The table is joined to itself using
   the user_id.

   The condition:

       curr.login_month =
       prev.login_month + INTERVAL '1 month'

   checks whether the user logged in
   during the immediately previous month.

3. Find Reactivated Users

   LEFT JOIN keeps all current-month
   logins, even when no previous-month
   login exists.

   WHERE prev.user_id IS NULL therefore
   identifies users who were inactive
   during the previous month.

4. Handle First Login in 2022

   If a user has no earlier login month
   in the 2022 dataset, they will also
   have prev.user_id IS NULL.

   Based on the problem's assumption,
   these users are considered reactivated
   because we assume they logged in
   during 2021.

5. Count Reactivated Users

   GROUP BY login_month groups the
   reactivated users by month.

   COUNT(*) calculates the number of
   reactivated users for each month.

6. Return the Month

   EXTRACT(MONTH FROM login_month)
   returns the month in numerical format.

*/

-- =====================================================
-- Time Complexity
-- =====================================================

/*
O(n log n)

n = number of rows in user_logins

- DISTINCT identifies unique user-month
  combinations.
- The self JOIN compares current and
  previous-month activity.
- GROUP BY aggregates reactivated users.
*/

-- =====================================================
-- Key Concepts
-- =====================================================

/*

- Common Table Expressions (CTEs)
- DATE_TRUNC()
- EXTRACT()
- Self JOIN
- LEFT JOIN
- INTERVAL Arithmetic
- DISTINCT
- GROUP BY
- COUNT()
- Month-over-Month Analysis
- User Reactivation
*/
