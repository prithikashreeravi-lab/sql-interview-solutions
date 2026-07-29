-- =====================================================
-- Problem: Amazon Shopping Spree Users
-- Platform: DataLemur
-- Difficulty: Medium
-- =====================================================

/*
Problem Statement

Amazon wants to identify high-value customers
who go on shopping sprees.

A shopping spree occurs when a user makes
purchases on 3 or more consecutive days.

Return:
- user_id

Requirements:
- Identify users who have at least one
  3-day consecutive purchase streak.
- Return user IDs in ascending order.
*/

-- =====================================================
-- Table Schema
-- =====================================================

/*
transactions

+-------------------+---------------------------+
| Column Name       | Type                      |
+-------------------+---------------------------+
| user_id           | integer                   |
| amount            | float                     |
| transaction_date  | timestamp WITH time zone  |
+-------------------+---------------------------+
*/

-- =====================================================
-- Solution
-- =====================================================

WITH dates AS (
    SELECT DISTINCT
        user_id,
        DATE(transaction_date) AS transaction_date
    FROM transactions
),

cte AS (
    SELECT
        user_id,
        transaction_date,
        transaction_date
        - ROW_NUMBER() OVER (
            PARTITION BY user_id
            ORDER BY transaction_date
          )::int AS grp
    FROM dates
),

streak AS (
    SELECT
        user_id,
        grp,
        COUNT(*) AS consecutive_days
    FROM cte
    GROUP BY
        user_id,
        grp
)

SELECT DISTINCT
    user_id
FROM streak
WHERE consecutive_days >= 3
ORDER BY user_id;

-- =====================================================
-- Explanation
-- =====================================================

/*
1. Remove Duplicate Transaction Dates
   - A user may make multiple purchases
     on the same day.
   - DISTINCT ensures each day is counted
     only once for identifying streaks.

2. Identify Consecutive Date Groups
   - ROW_NUMBER() assigns a sequence number
     to each user's transaction date.

   - Subtracting ROW_NUMBER() from the date
     creates a grouping value.

   Example:

   Date        Row Number   Date - Row Number
   ----------  -----------  -----------------
   Jan 1          1             Dec 31
   Jan 2          2             Dec 31
   Jan 3          3             Dec 31

   Since consecutive dates produce the same
   group value, they belong to the same streak.

3. Count Days in Each Streak
   - GROUP BY user_id and grp combines
     consecutive dates together.
   - COUNT(*) calculates the length of each
     shopping streak.

4. Filter Shopping Sprees
   - Keep only streaks with 3 or more days.

5. Sort Results
   - Return user IDs in ascending order.
*/

-- =====================================================
-- Example
-- =====================================================

/*
Transactions

User   Date
-----  ----------
1      2024-01-01
1      2024-01-02
1      2024-01-03
1      2024-01-10
2      2024-01-01
2      2024-01-05
2      2024-01-06


After Grouping Consecutive Dates

User   Group       Consecutive Days
-----  ----------  ----------------
1      Group A             3
1      Group B             1
2      Group C             1
2      Group D             2


Final Result

user_id
-------
1

User 1 qualifies because they purchased
on 3 consecutive days.
*/

-- =====================================================
-- Time Complexity
-- =====================================================

/*
O(n log n)

- DISTINCT removes duplicate dates.
- ROW_NUMBER() sorts transactions
  by user and date.
- GROUP BY aggregates streaks.
- ORDER BY sorts final user IDs.
*/

-- =====================================================
-- Key Concepts
-- =====================================================

/*
- Common Table Expressions (CTEs)
- ROW_NUMBER()
- Window Functions
- PARTITION BY
- ORDER BY
- Date Arithmetic
- Gaps and Islands Pattern
- Consecutive Date Analysis
- GROUP BY
- HAVING / Filtering Aggregates
*/
