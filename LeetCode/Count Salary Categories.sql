-- =====================================================
-- Problem: Count Salary Categories
-- Platform: LeetCode
-- Difficulty: Medium
-- =====================================================

/*
Problem Statement

The Accounts table contains the monthly income
for each bank account.

Classify each account into one of the following
salary categories:

- "Low Salary"
    Income < $20,000

- "Average Salary"
    Income between $20,000 and $50,000 (inclusive)

- "High Salary"
    Income > $50,000

Return the number of accounts in each category.

The result must always contain all three categories,
even if the count for a category is 0.

Return:
- category
- accounts_count
*/

-- =====================================================
-- Table Schema
-- =====================================================

/*
Accounts

account_id   INT
income       INT
*/


-- =====================================================
-- Solution
-- =====================================================

SELECT
    'Low Salary' AS category,
    COUNT(CASE WHEN income < 20000 THEN 1 END) AS accounts_count
FROM Accounts

UNION ALL

SELECT
    'Average Salary',
    COUNT(CASE WHEN income BETWEEN 20000 AND 50000 THEN 1 END)
FROM Accounts

UNION ALL

SELECT
    'High Salary',
    COUNT(CASE WHEN income > 50000 THEN 1 END)
FROM Accounts;


-- =====================================================
-- Key Concepts Practiced
-- =====================================================

/*
1. CASE WHEN
   - Categorizes incomes based on salary ranges

2. COUNT(expression)
   - Counts only rows where the CASE expression
     returns a non-NULL value

3. BETWEEN
   - Checks if income falls within an
     inclusive range ($20,000–$50,000)

4. UNION ALL
   - Combines the three category results
     into a single output

5. Constant Values
   - Uses fixed strings as category names
     in the output

6. Conditional Aggregation
   - Counts records that satisfy different
     conditions without filtering rows
*/
