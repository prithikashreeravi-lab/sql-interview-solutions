# Returning Active Users

## Problem
Identify returning active users by finding users who made a repeat purchase within **7 days or less** of their previous transaction, excluding **same-day purchases**.

Return a list of `user_id`s.

---

## Approach

The problem requires comparing each transaction with the **previous transaction** made by the same user.

1. Partition transactions by `user_id`.
2. Order transactions by `created_at`.
3. Use the `LAG()` window function to retrieve the previous purchase date.
4. Calculate the difference between the current and previous purchase dates.
5. Keep only transactions where the difference is between **1 and 7 days**.
6. Return distinct `user_id`s.

**Time Complexity:** O(n log n) (due to sorting within each partition)

**Space Complexity:** O(n)

---

## SQL Solution

```sql
WITH cte AS (
    SELECT
        user_id,
        created_at,
        LAG(created_at) OVER (
            PARTITION BY user_id
            ORDER BY created_at
        ) AS prev_purchase
    FROM amazon_transactions
)

SELECT DISTINCT user_id
FROM cte
WHERE created_at - prev_purchase BETWEEN 1 AND 7;
```

---

## Key SQL Concepts

- Window Functions (`LAG`)
- `PARTITION BY`
- `ORDER BY`
- Common Table Expressions (CTEs)
- Date Arithmetic
- `DISTINCT`

---

## Why This Works

`LAG()` retrieves the previous purchase date for each user.

By subtracting the previous purchase date from the current purchase date, we obtain the number of days between consecutive purchases.

Filtering for differences between **1 and 7 days**:
- Includes purchases made within one week.
- Excludes same-day purchases (`0` days).
- Ignores purchases more than seven days apart.

Finally, `DISTINCT` ensures each qualifying user appears only once.

---

## Example

### Input

| user_id | created_at |
|---------|------------|
| 1 | 2024-01-01 |
| 1 | 2024-01-04 |
| 1 | 2024-01-15 |
| 2 | 2024-01-10 |
| 2 | 2024-01-10 |
| 2 | 2024-01-18 |

### After `LAG()`

| user_id | created_at | prev_purchase | Difference |
|---------|------------|---------------|-----------|
| 1 | 2024-01-01 | NULL | - |
| 1 | 2024-01-04 | 2024-01-01 | 3 ✅ |
| 1 | 2024-01-15 | 2024-01-04 | 11 |
| 2 | 2024-01-10 | NULL | - |
| 2 | 2024-01-10 | 2024-01-10 | 0 ❌ |
| 2 | 2024-01-18 | 2024-01-10 | 8 ❌ |

### Output

| user_id |
|---------|
| 1 |
