-- =====================================================
-- Problem: Average Total Compensation by Employee Title and Gender
-- Platform: StrataScratch
-- Difficulty: Medium
-- =====================================================

/*
Problem Statement

Find the average total compensation based on employee title and gender.

Total compensation is calculated as:

    Salary + Total Bonus

Requirements:
- An employee may receive multiple bonuses.
- Employees without any bonus should be excluded.
- Output:
    - employee_title
    - sex
    - average total compensation
*/

-- =====================================================
-- Table Schema
-- =====================================================

/*
sf_employee

address          TEXT
age              BIGINT
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

sf_bonus

bonus            BIGINT
worker_ref_id    BIGINT
*/

-- =====================================================
-- Approach
-- =====================================================

/*
1. Aggregate all bonus records for each employee using SUM().
2. Join the aggregated bonus table with sf_employee using an INNER JOIN.
3. Calculate each employee's total compensation:
       salary + total_bonus
4. Group the results by employee_title and sex.
5. Calculate the average total compensation using AVG().
*/

-- =====================================================
-- Solution
-- =====================================================

SELECT
    e.employee_title,
    e.sex,
    AVG(e.salary + b.total_bonus) AS avg_total_compensation
FROM sf_employee e
JOIN (
    SELECT
        worker_ref_id,
        SUM(bonus) AS total_bonus
    FROM sf_bonus
    GROUP BY worker_ref_id
) b
    ON e.id = b.worker_ref_id
GROUP BY
    e.employee_title,
    e.sex;

-- =====================================================
-- Concepts Used
-- =====================================================

/*
- INNER JOIN
- Subquery (Derived Table)
- GROUP BY
- SUM()
- AVG()
- Aggregate Functions
*/

-- =====================================================
-- Key Takeaways
-- =====================================================

/*
- Aggregate bonus records before joining to avoid duplicating employee salaries.
- INNER JOIN automatically excludes employees who did not receive a bonus.
- SUM() combines multiple bonus payments into one total per employee.
- AVG() calculates the average total compensation for each employee title and gender.
- When one table contains multiple records per employee, aggregate first before joining.
*/
