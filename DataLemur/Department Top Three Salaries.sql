-- =====================================================
-- Problem: Department Top Three Salaries
-- Platform: DataLemur
-- Difficulty: Medium
-- =====================================================

/*
Problem Statement

As part of an analysis of salary distribution,
identify the employees whose salaries rank among
the top three distinct salaries within each department.

Return:
- department_name
- employee name
- salary

Requirements:
- Employees with the same salary should receive
  the same rank.
- Return all employees whose salary rank is
  less than or equal to 3.
- Sort by department name (ascending),
  salary (descending), and employee name
  (ascending).
*/

-- =====================================================
-- Table Schema
-- =====================================================

/*
employee

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| employee_id   | integer |
| name          | string  |
| salary        | integer |
| department_id | integer |
| manager_id    | integer |
+---------------+---------+
*/

/*
department

+-----------------+---------+
| Column Name     | Type    |
+-----------------+---------+
| department_id   | integer |
| department_name | string  |
+-----------------+---------+
*/

-- =====================================================
-- Solution
-- =====================================================

WITH cte AS (
    SELECT
        e.name,
        e.salary,
        d.department_name,
        DENSE_RANK() OVER (
            PARTITION BY e.department_id
            ORDER BY e.salary DESC
        ) AS rnk
    FROM employee e
    JOIN department d
        ON e.department_id = d.department_id
)

SELECT
    department_name,
    name,
    salary
FROM cte
WHERE rnk <= 3
ORDER BY
    department_name ASC,
    salary DESC,
    name ASC;

-- =====================================================
-- Explanation
-- =====================================================

/*
1. Join the Tables
   - Join employee with department to retrieve
     each employee's department name.

2. Apply DENSE_RANK()
   - Partition by department_id so each department
     is ranked independently.
   - Order salaries in descending order so the
     highest salary receives Rank 1.
   - Employees with the same salary receive the
     same rank.

3. Filter Top Three Salaries
   - Keep only employees whose dense rank is
     less than or equal to 3.
   - Since DENSE_RANK() ranks distinct salaries,
     all employees tied within the top three
     salary levels are included.

4. Sort the Output
   - Department name in ascending order.
   - Salary in descending order.
   - Employee name alphabetically for salary ties.

--------------------------------------------------------
Example
--------------------------------------------------------

Employee

Name     Department    Salary
-------  ------------  ------
Alice    HR             9000
Bob      HR             9000
Charlie  HR             8000
David    HR             7000
Emma     HR             6000

After DENSE_RANK()

Name     Salary   Rank
-------  ------   ----
Alice     9000      1
Bob       9000      1
Charlie   8000      2
David     7000      3
Emma      6000      4

Final Result

Name      Department   Salary
--------  -----------  ------
Alice     HR            9000
Bob       HR            9000
Charlie   HR            8000
David     HR            7000

--------------------------------------------------------
Time Complexity
--------------------------------------------------------

O(n log n)

- JOIN processes the employee and department
  tables.
- DENSE_RANK() requires sorting salaries within
  each department.
- Final ORDER BY sorts the filtered results.

--------------------------------------------------------
Key Concepts
--------------------------------------------------------

- Common Table Expressions (CTEs)
- INNER JOIN
- Window Functions
- DENSE_RANK()
- PARTITION BY
- ORDER BY
- Ranking
- Filtering Ranked Results
