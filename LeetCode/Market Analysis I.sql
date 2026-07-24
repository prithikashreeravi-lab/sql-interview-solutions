-- =====================================================
-- Problem: Market Analysis I
-- Platform: LeetCode
-- Difficulty: Medium
-- =====================================================

/*
Problem Statement

For each user, return:
- buyer_id (user_id)
- join_date
- number of orders they made as a buyer in 2019

Include all users, even if they did not place any
orders in 2019.

Return the result in any order.
*/

-- =====================================================
-- Table Schema
-- =====================================================

/*
Users

user_id         INT
join_date       DATE
favorite_brand  VARCHAR


Orders

order_id     INT
order_date   DATE
item_id      INT
buyer_id     INT
seller_id    INT


Items

item_id      INT
item_brand   VARCHAR
*/

-- =====================================================
-- Approach
-- =====================================================

/*
1. Start with the Users table so every user appears
   in the result.

2. LEFT JOIN the Orders table using buyer_id.

3. Filter the joined orders to only those placed
   in 2019.

4. Count the matching order_id values for each user.

5. Group by user_id and join_date.
*/

-- =====================================================
-- Solution
-- =====================================================

SELECT
    u.user_id AS buyer_id,
    u.join_date,
    COUNT(o.order_id) AS orders_in_2019
FROM Users u
LEFT JOIN Orders o
    ON u.user_id = o.buyer_id
   AND EXTRACT(YEAR FROM o.order_date) = 2019
GROUP BY
    u.user_id,
    u.join_date;

-- =====================================================
-- Concepts Used
-- =====================================================

/*
- LEFT JOIN
- COUNT(column)
- GROUP BY
- EXTRACT()
- Aggregate Function
*/

-- =====================================================
-- Key Takeaways
-- =====================================================

/*
- LEFT JOIN ensures all users are included, even if
  they placed no orders.

- The year filter is placed in the JOIN condition,
  not the WHERE clause, to preserve users with zero
  orders in 2019.

- COUNT(order_id) counts only non-NULL order IDs,
  returning 0 for users with no matching orders.

- COUNT(*) should not be used here because it counts
  every row produced by the LEFT JOIN, including rows
  where order_id is NULL.

- GROUP BY is required because COUNT() is an
  aggregate function.
*/
