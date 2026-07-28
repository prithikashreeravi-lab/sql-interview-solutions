-- =====================================================
-- Problem: 3-Day Rolling Average of Tweets
-- Platform: DataLemur
-- Difficulty: Medium
-- =====================================================

/*
Problem Statement

Given a table of tweet data over a specified time period,
calculate the 3-day rolling average of tweets for each user.

Return:
- user_id
- tweet_date
- rolling_avg_3d (rounded to 2 decimal places)

Notes:
- The rolling average includes the current day and the previous
  two rows for the same user.
- The result should be rounded to 2 decimal places.
*/

-- =====================================================
-- Table Schema
-- =====================================================

/*
tweets

+-------------+-----------+
| Column Name | Type      |
+-------------+-----------+
| user_id     | integer   |
| tweet_date  | timestamp |
| tweet_count | integer   |
+-------------+-----------+
*/

-- =====================================================
-- Solution
-- =====================================================

SELECT
    user_id,
    tweet_date,
    ROUND(
        AVG(tweet_count) OVER (
            PARTITION BY user_id
            ORDER BY tweet_date
            ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
        ),
        2
    ) AS rolling_avg_3d
FROM tweets;

-- =====================================================
-- Explanation
-- =====================================================

/*
1. PARTITION BY user_id
   - Separates the data for each user.
   - The rolling average is calculated independently for every user.

2. ORDER BY tweet_date
   - Arranges each user's tweets chronologically.

3. ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
   - Creates a moving window consisting of:
       • Current row
       • Previous row
       • Two rows before
   - Maximum window size = 3 rows.

4. AVG(tweet_count)
   - Calculates the average tweet count within the window.

5. ROUND(..., 2)
   - Rounds the rolling average to two decimal places.

Example Window

Date        Tweets   Window           Average
----------  ------   ---------------  -------
Jan 1         5      [5]               5.00
Jan 2         7      [5,7]             6.00
Jan 3         6      [5,7,6]           6.00
Jan 4         8      [7,6,8]           7.00
Jan 5         4      [6,8,4]           6.00

Time Complexity:
O(n log n)
(The window function requires sorting by user_id and tweet_date.)

Key Concepts:
- Window Functions
- AVG()
- PARTITION BY
- ORDER BY
- ROWS BETWEEN
- Rolling (Moving) Average
*/
