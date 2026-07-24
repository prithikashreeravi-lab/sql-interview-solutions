-- =====================================================
-- Problem: Immediate Food Delivery II
-- Platform: LeetCode
-- Difficulty: Medium
-- =====================================================

/*
Problem Statement

An order is called:

- Immediate:
  customer_pref_delivery_date = order_date

- Scheduled:
  customer_pref_delivery_date > order_date

The first order of a customer is the order with
the earliest order_date.

Find the percentage of customers whose first order
was immediate.

Round the answer to 2 decimal places.

Return:
- immediate_percentage
*/

-- =====================================================
-- Table Schema
-- =====================================================

/*
Delivery

delivery_id                    INT
customer_id                    INT
order_date                     DATE
customer_pref_delivery_date    DATE
*/

-- =====================================================
-- Solution
-- =====================================================

WITH cte AS (
    SELECT
        *,
        ROW_NUMBER() OVER (
            PARTITION BY customer_id
            ORDER BY order_date
        ) AS rn
    FROM Delivery
)

SELECT
    ROUND(
        AVG(
            CASE
                WHEN order_date = customer_pref_delivery_date
                THEN 1
                ELSE 0
            END
        ) * 100.0,
        2
    ) AS immediate_percentage
FROM cte
WHERE rn = 1;

-- =====================================================
-- Key Concepts Practiced
-- =====================================================

/*
1. ROW_NUMBER()
   - Assigns a rank to each customer's orders.
   - The earliest order gets rn = 1.

2. PARTITION BY
   - Restarts numbering for each customer.

3. ORDER BY
   - Sorts orders from earliest to latest.

4. CTE (Common Table Expression)
   - Stores ranked orders for reuse.

5. CASE WHEN
   - Converts immediate orders to 1.
   - Converts scheduled orders to 0.

6. AVG()
   - Calculates the proportion of immediate orders.

7. *100.0
   - Converts the proportion to a percentage.

8. ROUND()
   - Formats the percentage to 2 decimal places.
*/

-- =====================================================
-- Key Takeaways
-- =====================================================

/*
- ROW_NUMBER() is the easiest way to identify the
  first order for each customer.

- PARTITION BY customer_id ensures each customer's
  orders are ranked independently.

- Filtering with rn = 1 leaves only the first order
  of every customer.

- AVG(CASE WHEN ...) works because:
      Immediate = 1
      Scheduled = 0

  The average of 1s and 0s equals the proportion
  of immediate orders.

- Multiplying by 100 converts the proportion into
  a percentage.

- This pattern is very common in SQL interviews for
  "first/last record per group" problems.
*/
