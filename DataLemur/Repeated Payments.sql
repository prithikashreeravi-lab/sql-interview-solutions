-- =====================================================
-- Problem: Repeated Payments
-- Platform: DataLemur
-- Difficulty: Hard
-- =====================================================

/*
Problem Statement

Sometimes payment transactions are repeated
accidentally because of user error, API failures,
or retry issues.

Identify repeated payments made:

- At the same merchant
- Using the same credit card
- For the same amount
- Within 10 minutes of the previous payment

The first transaction is NOT considered
a repeated payment.

Return:

- payment_count
*/

-- =====================================================
-- Table Schema
-- =====================================================

/*
transactions

+-----------------------+----------+
| Column Name           | Type     |
+-----------------------+----------+
| transaction_id        | integer  |
| merchant_id           | integer  |
| credit_card_id        | integer  |
| amount                | integer  |
| transaction_timestamp | datetime |
+-----------------------+----------+
*/

-- =====================================================
-- Solution
-- =====================================================

WITH ranked_transactions AS (
    SELECT
        *,
        LAG(transaction_timestamp) OVER (
            PARTITION BY
                merchant_id,
                credit_card_id,
                amount
            ORDER BY transaction_timestamp
        ) AS previous_transaction_time
    FROM transactions
)

SELECT
    COUNT(*) AS payment_count
FROM ranked_transactions
WHERE
    previous_transaction_time IS NOT NULL
    AND transaction_timestamp
        <= previous_transaction_time + INTERVAL '10 minutes';

-- =====================================================
-- Explanation
-- =====================================================

/*
1. Group Similar Transactions

   Partition by:

   - merchant_id
   - credit_card_id
   - amount

   This groups transactions that could
   potentially be duplicates.


2. Find Previous Transaction

   LAG(transaction_timestamp)

   Retrieves the timestamp of the
   immediately previous transaction
   within each group.


3. Check the Time Difference

   transaction_timestamp
       <= previous_transaction_time
          + INTERVAL '10 minutes'

   If the current transaction occurred
   within 10 minutes of the previous one,
   it is considered a repeated payment.


4. Count Repeated Payments

   The first transaction in each group
   has no previous transaction, so it
   is automatically excluded.

*/

-- =====================================================
-- Time Complexity
-- =====================================================

/*
O(n log n)

n = number of transactions

- Window function sorts each partition.
- Each transaction is processed once.
*/

-- =====================================================
-- Key Concepts
-- =====================================================

/*
- Common Table Expression (CTE)
- Window Functions
- LAG()
- PARTITION BY
- ORDER BY
- Datetime Arithmetic
*/
