-- =====================================================
-- Problem: Unique Users Flagging Each Video
-- Platform: StrataScratch
-- Difficulty: Medium
-- =====================================================

/*
Problem Statement

For each video, find the number of unique users who flagged it.

A unique user is identified by the combination of:
- user_firstname
- user_lastname

Ignore rows where flag_id is NULL.

Output:
- video_id
- number of unique users who flagged the video
*/

-- =====================================================
-- Table Schema
-- =====================================================

/*
user_flags

flag_id          TEXT
user_firstname   TEXT
user_lastname    TEXT
video_id         TEXT
*/

-- =====================================================
-- Approach
-- =====================================================

/*
1. Remove rows where flag_id is missing.
2. Use DISTINCT to keep only unique combinations of:
   - user_firstname
   - user_lastname
   - video_id
3. Count the remaining rows for each video.
4. GROUP BY video_id to calculate unique flagging users per video.
*/

-- =====================================================
-- Solution
-- =====================================================

SELECT
    video_id,
    COUNT(*) AS num_unique_users
FROM (
    SELECT DISTINCT
        user_firstname,
        user_lastname,
        video_id
    FROM user_flags
    WHERE flag_id IS NOT NULL
) AS unique_users
GROUP BY video_id;

-- =====================================================
-- Concepts Used
-- =====================================================

/*
- DISTINCT
- Subqueries
- COUNT()
- GROUP BY
- NULL filtering
*/

-- =====================================================
-- Key Takeaways
-- =====================================================

/*
- DISTINCT removes duplicate combinations before counting.
- COUNT(*) counts the rows produced by the subquery.
- When uniqueness depends on multiple columns, SELECT DISTINCT
  on those columns is a reliable approach.
- Always apply filters before aggregation when certain rows
  should not be included.
- A user can flag multiple videos, so uniqueness must include
  video_id along with user identity.
*/
