-- =====================================================
-- Problem: Monthly Transactions I
-- Platform: LeetCode
-- Difficulty: Medium
-- =====================================================

/*
Problem Statement

The Transactions table stores information
about incoming transactions.

For each month and country, calculate:

- Total number of transactions
- Total transaction amount
- Number of approved transactions
- Total amount of approved transactions

Return:
- month
- country
- trans_count
- approved_count
- trans_total_amount
- approved_total_amount
*/

-- =====================================================
-- Table Schema
-- =====================================================

/*
Transactions

id            INT
country       VARCHAR
state         ENUM('approved', 'declined')
amount        INT
trans_date    DATE
*/


-- =====================================================
-- Solution (PostgreSQL)
-- =====================================================

SELECT
    TO_CHAR(trans_date, 'YYYY-MM') AS month,
    country,
    COUNT(*) AS trans_count,
    COUNT(*) FILTER (WHERE state = 'approved') AS approved_count,
    SUM(amount) AS trans_total_amount,
    COALESCE(
        SUM(amount) FILTER (WHERE state = 'approved'),
        0
    ) AS approved_total_amount
FROM Transactions
GROUP BY
    TO_CHAR(trans_date, 'YYYY-MM'),
    country;


-- =====================================================
-- Alternative Solution (MySQL)
-- =====================================================

/*
SELECT
    DATE_FORMAT(trans_date, '%Y-%m') AS month,
    country,
    COUNT(*) AS trans_count,
    SUM(CASE WHEN state = 'approved' THEN 1 ELSE 0 END) AS approved_count,
    SUM(amount) AS trans_total_amount,
    SUM(CASE WHEN state = 'approved' THEN amount ELSE 0 END) AS approved_total_amount
FROM Transactions
GROUP BY
    DATE_FORMAT(trans_date, '%Y-%m'),
    country;
*/


-- =====================================================
-- Key Concepts Practiced
-- =====================================================

/*
1. Date Formatting
   - TO_CHAR(trans_date, 'YYYY-MM')
     extracts the year and month
     from the transaction date.

2. GROUP BY
   - Groups transactions by
     month and country.

3. COUNT(*)
   - Counts all transactions
     in each group.

4. FILTER Clause (PostgreSQL)
   - Counts only approved
     transactions.

5. SUM()
   - Calculates the total
     transaction amount.

6. Conditional Aggregation
   - SUM(amount) FILTER (...)
     calculates the total amount
     of approved transactions.

7. COALESCE()
   - Replaces NULL with 0 when
     a group has no approved
     transactions.
*/


-- =====================================================
-- Interview Explanation
-- =====================================================

/*
1. Group the data by month and country.

2. Count all transactions and sum
   their amounts.

3. Use conditional aggregation to
   calculate the count and total
   amount of approved transactions.

4. Use COALESCE to return 0 instead
   of NULL when there are no approved
   transactions in a group.
*/
