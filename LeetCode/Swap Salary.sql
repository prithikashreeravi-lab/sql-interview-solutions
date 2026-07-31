-- =====================================================
-- Problem: Swap Salary
-- Platform: LeetCode
-- Difficulty: Easy
-- =====================================================

/*
Problem Statement

Swap all 'm' and 'f' values in the
sex column using a single UPDATE
statement.

Requirements:

- Change every 'm' to 'f'
- Change every 'f' to 'm'
- Use only one UPDATE statement
- Do not use temporary tables
- Do not use any SELECT statement
*/

-- =====================================================
-- Table Schema
-- =====================================================

/*
Salary

+-------------+----------+
| Column Name | Type     |
+-------------+----------+
| id          | int      |
| name        | varchar  |
| sex         | ENUM     |
| salary      | int      |
+-------------+----------+

Primary Key:
- id

sex values:
- 'm'
- 'f'
*/

-- =====================================================
-- Solution
-- =====================================================

UPDATE Salary
SET sex = CASE
            WHEN sex = 'm' THEN 'f'
            ELSE 'm'
          END;

-- =====================================================
-- Explanation
-- =====================================================

/*
1. Update Every Row

   The UPDATE statement modifies
   every record in the Salary table.

2. Check Current Value

   CASE evaluates the existing
   value of the sex column.

3. Swap the Values

   - If sex = 'm', change it to 'f'
   - Otherwise, change it to 'm'

4. Single Statement Solution

   SQL evaluates the CASE expression
   using the original value of each
   row, so no temporary table or
   multiple UPDATE statements are
   required.
*/

-- =====================================================
-- Time Complexity
-- =====================================================

/*
O(n)

n = number of rows in Salary

- Each row is visited exactly once.
- No sorting or grouping is involved.
*/

-- =====================================================
-- Key Concepts
-- =====================================================

/*
- UPDATE
- CASE Expression
- Conditional Logic
- Data Modification (DML)
*/
