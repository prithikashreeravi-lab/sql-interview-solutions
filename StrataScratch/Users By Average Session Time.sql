-- =====================================================
-- Problem: Average Session Time
-- Platform: StrataScratch
-- Difficulty: Medium
-- =====================================================

/*
Problem Statement

Calculate each user's average session time, where a session is defined as the
time difference between a page_load and a page_exit.

Assume each user has only one session per day.

If there are multiple page_load or page_exit events on the same day:
- Use the latest page_load
- Use the earliest page_exit

Only consider sessions where page_load occurs before page_exit.

Output:
- user_id
- average_session_time
*/

-- =====================================================
-- Table Schema
-- =====================================================

/*
facebook_web_log

action      TEXT
timestamp   TIMESTAMP
user_id     BIGINT
*/

-- =====================================================
-- Approach
-- =====================================================

/*
1. Group by user_id and date.
2. Find the latest page_load using MAX().
3. Find the earliest page_exit using MIN().
4. Filter out invalid sessions.
5. Calculate session duration.
6. Average the duration for each user.
*/

-- =====================================================
-- Solution
-- =====================================================

WITH sessions AS (
    SELECT
        user_id,
        DATE(timestamp) AS session_day,
        MAX(CASE WHEN action = 'page_load' THEN timestamp END) AS load_time,
        MIN(CASE WHEN action = 'page_exit' THEN timestamp END) AS exit_time
    FROM facebook_web_log
    GROUP BY
        user_id,
        DATE(timestamp)
)

SELECT
    user_id,
    AVG(exit_time - load_time) AS average_session_time
FROM sessions
WHERE load_time < exit_time
GROUP BY user_id;

-- =====================================================
-- Concepts Used
-- =====================================================

/*
- CTE
- CASE WHEN
- Conditional Aggregation
- MAX()
- MIN()
- GROUP BY
- DATE()
- AVG()
- Timestamp Arithmetic
*/
