-- =====================================================
-- Problem: Department Growth Analysis
-- Platform: StrataScratch
-- Difficulty: Medium
-- =====================================================

/*
Problem Statement

The workforce planning team is analyzing department growth
since the company's expansion.

For each department with 5 or more employees hired after 2020,
return:
- department name
- headcount
- total payroll
- average salary

Only include departments that meet the employee count threshold.
*/

-- =====================================================
-- Table Schema
-- =====================================================

/*
techcorp_workforce

department     TEXT
first_name     TEXT
id             BIGINT
joining_date   DATE
last_name      TEXT
phone_number   TEXT
salary         BIGINT
*/

-- =====================================================
-- Approach
-- =====================================================

/*
1. Filter employees who joined after 2020.
2. Group employees by department.
3. Count employees in each department to calculate headcount.
4. Sum salaries to calculate total payroll.
5. Calculate average salary using AVG().
6. Use HAVING to keep only departments with 5 or more employees.
*/

-- =====================================================
-- Solution
-- =====================================================

SELECT
    department,
    COUNT(*) AS headcount,
    SUM(salary) AS total_payroll,
    AVG(salary) AS average_salary
FROM techcorp_workforce
WHERE joining_date >= '2021-01-01'
GROUP BY department
HAVING COUNT(*) >= 5;

-- =====================================================
-- Concepts Used
-- =====================================================

/*
- WHERE filtering
- GROUP BY
- HAVING
- COUNT()
- SUM()
- AVG()
- Date filtering
*/

-- =====================================================
-- Key Takeaways
-- =====================================================

/*
- WHERE filters individual rows before aggregation.
- GROUP BY creates one result row per department.
- Aggregate functions calculate metrics for each group.
- HAVING filters aggregated results after GROUP BY.
- Use HAVING instead of WHERE when filtering based on COUNT(), SUM(), AVG(), etc.
- "After 2020" means dates starting from 2021-01-01.
*/
