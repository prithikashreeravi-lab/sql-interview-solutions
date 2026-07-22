-- =====================================================
-- Problem: Returning Active Users
-- Platform: StrataScratch
-- Difficulty: Medium
-- =====================================================

/*
Problem Statement

Identify returning active users by finding users who made a second purchase
within 1 to 7 days after their first purchase.

Ignore same-day purchases.

Output:
- user_id
*/

-- =====================================================
-- Table Schema
-- =====================================================

/*
amazon_transactions

created_at   DATE
id           BIGINT
item         TEXT
revenue      BIGINT
user_id      BIGINT
*/

-- =====================================================
-- Approach
-- =====================================================

/*
1. Find each user's first purchase date using MIN(created_at).
2. Join the first purchase back to the transactions table.
3. Keep only purchases made between 1 and 7 days after the first purchase.
4. Exclude same-day purchases by starting the range at first_purchase_date + 1.
5. Use DISTINCT to return each qualifying user only once.
*/

-- =====================================================
-- Solution
-- =====================================================

WITH first_purchase AS (
    SELECT
        user_id,
        MIN(created_at) AS first_purchase_date
    FROM amazon_transactions
    GROUP BY user_id
)

SELECT DISTINCT
    a.user_id
FROM amazon_transactions a
JOIN first_purchase f
    ON a.user_id = f.user_id
WHERE a.created_at BETWEEN f.first_purchase_date + 1
                       AND f.first_purchase_date + 7;

-- =====================================================
-- Concepts Used
-- =====================================================

/*
- Common Table Expression (CTE)
- MIN()
- GROUP BY
- INNER JOIN
- Date Arithmetic
- BETWEEN
- DISTINCT
*/

-- =====================================================
-- Key Takeaways
-- =====================================================

/*
- Use MIN() to identify the first event for each user.
- Join aggregated results back to the original table to compare later events.
- PostgreSQL allows adding integers to DATE values (e.g., date + 1 adds one day).
- BETWEEN is inclusive, so using +1 excludes same-day purchases.
- DISTINCT prevents duplicate user_ids when multiple qualifying purchases exist.
*/
