-- =====================================================
-- Problem: Exchange Seats
-- Platform: LeetCode
-- Difficulty: Medium
-- =====================================================

/*
Problem Statement

Swap the seat ID of every two consecutive students.

If the number of students is odd,
the last student's ID should remain unchanged.

Return the result table ordered by id
in ascending order.

Return:
- id
- student
*/

-- =====================================================
-- Table Schema
-- =====================================================

/*
Seat

id       INT
student  VARCHAR
*/

-- =====================================================
-- Solution
-- =====================================================

```sql
SELECT
    CASE
        WHEN id % 2 = 1
             AND id <> (SELECT MAX(id) FROM Seat)
            THEN id + 1
        WHEN id % 2 = 0
            THEN id - 1
        ELSE id
    END AS id,
    student
FROM Seat
ORDER BY id;
```

-- =====================================================
-- Key Concepts Practiced
-- =====================================================

/*
1. CASE WHEN
   - Assigns a new seat ID based on whether the current ID
     is odd or even.

2. Modulo Operator (%)
   - Identifies odd and even IDs.
   - Odd: id % 2 = 1
   - Even: id % 2 = 0

3. Scalar Subquery
   - SELECT MAX(id) FROM Seat
   - Finds the last student ID.
   - Prevents swapping the final student when the total
     number of students is odd.

4. Column Alias
   - AS id renames the calculated value so it becomes
     the output ID.

5. ORDER BY
   - Sorts the result using the newly assigned IDs.
   - CASE changes the ID values but does not reorder rows,
     so ORDER BY is required to display the swapped seats
     correctly.

6. Conditional Logic
   - Odd IDs → id + 1
   - Even IDs → id - 1
   - Last odd ID → unchanged
```
