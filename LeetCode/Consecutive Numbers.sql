-- =====================================================
-- Problem: Consecutive Numbers
-- Platform: LeetCode
-- Difficulty: Medium
-- =====================================================

/*
Problem Statement

Find all numbers that appear at least
three times consecutively.

Return:
- ConsecutiveNums
*/

-- =====================================================
-- Table Schema
-- =====================================================

/*
Logs

id    INT
num   VARCHAR
*/

-- =====================================================
-- Solution
-- =====================================================

```sql
SELECT DISTINCT
    num AS ConsecutiveNums
FROM (
    SELECT
        id,
        num,
        LAG(num, 1) OVER (ORDER BY id) AS prev1,
        LAG(num, 2) OVER (ORDER BY id) AS prev2
    FROM Logs
) t
WHERE num = prev1
  AND num = prev2;
```

-- =====================================================
-- Key Concepts Practiced
-- =====================================================

/*
1. LAG() Window Function
   - Retrieves values from previous rows without using
     a self join.

2. OVER(ORDER BY id)
   - Ensures rows are processed in sequential ID order,
     allowing comparison with previous records.

3. Multiple LAG() Calls
   - prev1 retrieves the previous row's value.
   - prev2 retrieves the value two rows before.

4. Consecutive Value Detection
   - Checks whether the current value matches both
     previous values to identify three consecutive
     occurrences.

5. Subquery
   - Stores the LAG() results so they can be filtered
     in the outer query.

6. DISTINCT
   - Returns each qualifying number only once, even if
     it appears more than three consecutive times.

7. Column Alias
   - AS ConsecutiveNums renames the output column to
     match the required result.
```
