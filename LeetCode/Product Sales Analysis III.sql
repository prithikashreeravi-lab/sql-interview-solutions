-- =====================================================
-- Problem: Product Sales Analysis III
-- Platform: LeetCode
-- Difficulty: Medium
-- =====================================================

/*
Problem Statement

For each product, return the first year it was sold,
along with its quantity and price for that year.

Return:
- product_id
- first_year
- quantity
- price
*/

-- =====================================================
-- Table Schema
-- =====================================================

/*
Sales

product_id    INT
year          INT
quantity      INT
price         INT
*/

-- =====================================================
-- Approach
-- =====================================================

/*
1. Iterate through each row in the Sales table.
2. For the current product, find its earliest sales year.
3. Compare the current row's year with the earliest year.
4. Return the row only if it represents the product's first sale.
*/

-- =====================================================
-- Solution
-- =====================================================

SELECT
    product_id,
    year AS first_year,
    quantity,
    price
FROM Sales s
WHERE year = (
    SELECT MIN(year)
    FROM Sales
    WHERE product_id = s.product_id
);

-- =====================================================
-- Concepts Used
-- =====================================================

/*
- Correlated Subquery
- WHERE
- MIN()
- Aggregate Function
*/

-- =====================================================
-- Key Takeaways
-- =====================================================

/*
- A correlated subquery references a column from the outer query.
- The subquery is evaluated for each row in the outer query.
- Compare each row's year with the minimum year for the same product.
- This approach returns the complete row corresponding to each product's first sale.
- The same problem can also be solved using a CTE + JOIN or a window function (ROW_NUMBER()).
*/
