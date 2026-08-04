-- =====================================================
-- Problem: Monthly Active Users (MAU)
-- Platform: DataLemur
-- Difficulty: Hard
-- =====================================================

/*
Problem Statement

Given Facebook user activity,
calculate the number of Monthly
Active Users (MAUs) for July 2022.

A Monthly Active User is defined
as a user who performed at least
one action in both the current
month (July 2022) and the previous
month (June 2022).

Return the month in numerical
format along with the number of
monthly active users.
*/

-- =====================================================
-- Table Schema
-- =====================================================

/*
user_actions

+--------------+----------+
| Column Name  | Type     |
+--------------+----------+
| user_id      | integer  |
| event_id     | integer  |
| event_type   | string   |
| event_date   | datetime |
+--------------+----------+
*/

-- =====================================================
-- Solution
-- =====================================================

WITH active_users AS (

    SELECT
        user_id
    FROM user_actions
    WHERE EXTRACT(MONTH FROM event_date) = 6
      AND EXTRACT(YEAR FROM event_date) = 2022

    INTERSECT

    SELECT
        user_id
    FROM user_actions
    WHERE EXTRACT(MONTH FROM event_date) = 7
      AND EXTRACT(YEAR FROM event_date) = 2022
)

SELECT
    7 AS month,
    COUNT(*) AS monthly_active_users
FROM active_users;

-- =====================================================
-- Explanation
-- =====================================================

/*
1. Find June Active Users

   Select all users who
   performed at least one
   action during June 2022.

2. Find July Active Users

   Select all users who
   performed at least one
   action during July 2022.

3. Find Common Users

   INTERSECT returns only the
   user_ids that exist in both
   result sets.

   These users were active in
   both June and July.

4. Count Active Users

   COUNT(*) calculates the total
   number of users returned by
   INTERSECT.

5. Return the Month

   Output the month number (7)
   along with the total Monthly
   Active Users.
*/

-- =====================================================
-- Time Complexity
-- =====================================================

/*
O(n)

n = number of rows in
    user_actions

- First query scans June data.
- Second query scans July data.
- INTERSECT finds common users.
- COUNT(*) counts the result.
*/

-- =====================================================
-- Key Concepts
-- =====================================================

/*
- Common Table Expressions (CTEs)
- INTERSECT
- EXTRACT()
- COUNT()
- Date Filtering
*/
