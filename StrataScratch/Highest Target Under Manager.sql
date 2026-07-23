-- =====================================================
-- Problem: Highest Target Under Manager
-- Platform: StrataScratch
-- Difficulty: Medium
-- =====================================================

/*
Problem Statement

Identify the employee(s) working under manager_id = 13
who have achieved the highest target.

Return:
- first_name
- target

If multiple employees have the same highest target,
return all of them.
*/

-- =====================================================
-- Table Schema
-- =====================================================

/*
salesforce_employees

address          TEXT
age              BIGINT
bonus            BIGINT
city             TEXT
department       TEXT
email            TEXT
employee_title   TEXT
first_name       TEXT
id               BIGINT
last_name        TEXT
manager_id       BIGINT
salary           BIGINT
sex              TEXT
target           BIGINT
*/

-- =====================================================
-- Approach
-- =====================================================

/*
1. Filter employees reporting to manager_id = 13.
2. Find the highest target achieved among those employees.
3. Return the employee(s) whose target matches the highest value.
4. Return first_name and target.
*/

-- =====================================================
-- Solution
-- =====================================================

SELECT
    first_name,
    target
FROM salesforce_employees
WHERE manager_id = 13
  AND target = (
        SELECT MAX(target)
        FROM salesforce_employees
        WHERE manager_id = 13
    );

-- =====================================================
-- Concepts Used
-- =====================================================

/*
- WHERE filtering
- Subquery
- MAX()
- Comparison with aggregate value
*/

-- =====================================================
-- Key Takeaways
-- =====================================================

/*
- Break the problem into two steps:
  1. Find the maximum target.
  2. Retrieve the employee(s) with that target.
- A scalar subquery is useful when comparing rows to a single aggregate value.
- This approach naturally returns all employees tied for the highest target.
- An alternative solution is to use DENSE_RANK() and filter for rank = 1.
*/
