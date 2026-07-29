-- =====================================================
-- Problem: Mode of Order Occurrences
-- Platform: DataLemur
-- Difficulty: Medium
-- =====================================================

/*
Problem Statement

Alibaba tracks the number of items in each order
and how frequently orders with that item count occur.

Find the mode of the order occurrences.

Return:
- item_count

Requirements:
- The mode is the item_count value(s) with the
  highest order_occurrences.
- If multiple item_counts share the same highest
  frequency, return all of them.
- Sort results in ascending order.
*/

-- =====================================================
-- Table Schema
-- =====================================================

/*
items_per_order

+--------------------+---------+
| Column Name        | Type    |
+--------------------+---------+
| item_count         | integer |
| order_occurrences  | integer |
+--------------------+---------+
*/

-- =====================================================
-- Solution
-- =====================================================

SELECT
    item_count
FROM items_per_order
WHERE order_occurrences = (
    SELECT MAX(order_occurrences)
    FROM items_per_order
)
ORDER BY item_count;

-- =====================================================
-- Explanation
-- =====================================================

/*
1. Find the Maximum Frequency

   - MAX(order_occurrences) identifies the
     largest number of orders for any item_count.

   Example:

   item_count | order_occurrences
   -----------|------------------
        1     |       500
        2     |       800
        3     |       800
        4     |       300

   Maximum occurrence = 800


2. Filter Item Counts With That Frequency

   WHERE order_occurrences = 800

   Returns:

   item_count
   ----------
       2
       3


3. Handle Multiple Modes

   - If multiple item_counts have the same
     highest occurrence, all are returned.


4. Sort Results

   - ORDER BY item_count ensures ascending order.
*/

-- =====================================================
-- Time Complexity
-- =====================================================

/*
O(n)

- MAX() scans the table once.
- Filtering scans the table again.
- ORDER BY sorts the result values.
*/

-- =====================================================
-- Key Concepts
-- =====================================================

/*
- Aggregate Functions
- MAX()
- Subqueries
- Filtering with Aggregates
- ORDER BY
*/
