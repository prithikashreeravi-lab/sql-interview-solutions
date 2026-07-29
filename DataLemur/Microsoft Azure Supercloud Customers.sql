-- =====================================================
-- Problem: Microsoft Azure Supercloud Customers
-- Platform: DataLemur
-- Difficulty: Medium
-- =====================================================

/*
Problem Statement

A Microsoft Azure Supercloud customer is a customer
who has purchased at least one product from every
product category listed in the products table.

Find the customer IDs of all Supercloud customers.

Return:
- customer_id
*/

-- =====================================================
-- Table Schema
-- =====================================================

/*
customer_contracts

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| customer_id | integer |
| product_id  | integer |
| amount      | integer |
+-------------+---------+

products

+------------------+---------+
| Column Name      | Type    |
+------------------+---------+
| product_id       | integer |
| product_category | string  |
| product_name     | string  |
+------------------+---------+
*/

-- =====================================================
-- Solution
-- =====================================================

WITH cte AS (
    SELECT
        c.customer_id,
        p.product_category
    FROM customer_contracts AS c
    JOIN products AS p
        ON c.product_id = p.product_id
)

SELECT
    customer_id
FROM cte
GROUP BY
    customer_id
HAVING COUNT(DISTINCT product_category) = (
    SELECT COUNT(DISTINCT product_category)
    FROM products
);

-- =====================================================
-- Explanation
-- =====================================================

/*
1. Join the Tables

   - Join customer_contracts with products
     using product_id.
   - This associates each customer's purchase
     with its product category.


2. Create the CTE

   The CTE contains:

   customer_id | product_category

   Example:

   101 | Compute
   101 | Storage
   101 | AI
   102 | Compute
   102 | Storage


3. Count Categories Purchased

   COUNT(DISTINCT product_category)

   - Counts the number of unique product
     categories purchased by each customer.
   - DISTINCT prevents duplicate purchases
     within the same category from being
     counted multiple times.


4. Count Total Categories

   SELECT COUNT(DISTINCT product_category)
   FROM products

   - Finds the total number of unique product
     categories available.


5. Find Supercloud Customers

   HAVING customer_categories =
          total_categories

   - Customers whose category count matches
     the total number of categories have
     purchased at least one product from
     every category.

*/

-- =====================================================
-- Time Complexity
-- =====================================================

/*
O(n + m)

n = rows in customer_contracts
m = rows in products

- JOIN processes the purchases.
- GROUP BY aggregates by customer.
- COUNT(DISTINCT) determines unique categories.
- The subquery counts product categories once.
*/

-- =====================================================
-- Key Concepts
-- =====================================================

/*
- Common Table Expression (CTE)
- INNER JOIN
- GROUP BY
- HAVING
- COUNT(DISTINCT)
- Aggregate Comparison
*/
