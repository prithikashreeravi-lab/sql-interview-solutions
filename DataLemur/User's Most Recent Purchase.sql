-- =====================================================
-- Problem: User's Most Recent Purchase
-- Platform: DataLemur
-- Difficulty:Medium
-- =====================================================

/*
Problem Statement

Given Walmart user transactions,
retrieve each user's most recent
transaction date along with the
number of products they purchased
on that date.

Return:

- transaction_date
- user_id
- purchase_count

Sort the output by transaction_date
in ascending order.
*/

-- =====================================================
-- Table Schema
-- =====================================================

/*
user_transactions

+------------------+-----------+
| Column Name      | Type      |
+------------------+-----------+
| product_id       | integer   |
| user_id          | integer   |
| spend            | decimal   |
| transaction_date | timestamp |
+------------------+-----------+
*/

-- =====================================================
-- Solution
-- =====================================================

WITH recent_purchases AS (
    SELECT
        transaction_date,
        user_id,
        COUNT(product_id) AS purchase_count,
        RANK() OVER (
            PARTITION BY user_id
            ORDER BY transaction_date DESC
        ) AS rnk
    FROM user_transactions
    GROUP BY
        transaction_date,
        user_id
)

SELECT
    transaction_date,
    user_id,
    purchase_count
FROM recent_purchases
WHERE rnk = 1
ORDER BY transaction_date ASC;

-- =====================================================
-- Explanation
-- =====================================================

/*
1. Group Transactions

   Group by:

   - user_id
   - transaction_date

   COUNT(product_id) calculates
   how many products each user
   purchased on each transaction
   date.

2. Rank Transactions

   RANK() assigns a ranking to
   every transaction date for
   each user.

   The most recent transaction
   receives rank = 1.

3. Keep Latest Purchase

   Filter rows where rnk = 1
   to return only the latest
   transaction for each user.

4. Sort Results

   Display the output in
   chronological order using
   transaction_date ASC.
*/

-- =====================================================
-- Time Complexity
-- =====================================================

/*
O(n log n)

n = number of rows in user_transactions

- GROUP BY aggregates purchases.
- RANK() sorts transactions
  within each user.
- Final filtering is O(n).
*/

-- =====================================================
-- Key Concepts
-- =====================================================

/*
- Common Table Expression (CTE)
- GROUP BY
- COUNT()
- Window Functions
- RANK()
- PARTITION BY
- ORDER BY
*/
