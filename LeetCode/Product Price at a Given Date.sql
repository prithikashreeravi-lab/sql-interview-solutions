-- =====================================================
-- Problem: Product Price at a Given Date
-- Platform: LeetCode
-- Difficulty: Medium
-- =====================================================

/*
Problem Statement

Initially, every product has a price of 10.

The Products table records price changes for products.

Find the price of every product on the date
'2019-08-16'.

If a product has no price change on or before
'2019-08-16', its price remains 10.

Return:
- product_id
- price
*/

-- =====================================================
-- Table Schema
-- =====================================================

/*
Products

product_id     INT
new_price      INT
change_date    DATE
*/

-- =====================================================
-- Solution
-- =====================================================

SELECT
    p1.product_id,
    COALESCE(
        (
            SELECT
                p2.new_price
            FROM Products p2
            WHERE p2.product_id = p1.product_id
              AND p2.change_date <= '2019-08-16'
            ORDER BY p2.change_date DESC
            LIMIT 1
        ),
        10
    ) AS price
FROM Products p1
GROUP BY p1.product_id;

-- =====================================================
-- Key Concepts Practiced
-- =====================================================

/*
1. Correlated Subquery
   - Executes once for each product in the outer query.
   - Uses the current product_id from the outer query.

2. Table Aliases (p1 & p2)
   - p1 represents the current product in the outer query.
   - p2 represents the Products table searched by the subquery.

3. ORDER BY DESC + LIMIT 1
   - Retrieves the most recent price change
     on or before the target date.

4. COALESCE()
   - Returns the initial price (10)
     when no valid price change exists.

5. GROUP BY
   - Ensures one row is returned for each product.

6. Date Filtering
   - Ignores price changes after '2019-08-16'.
*/

-- =====================================================
-- Key Takeaways
-- =====================================================

/*
- Think of a correlated subquery as a function that
  runs once for every row in the outer query.

- The condition:
      p2.product_id = p1.product_id
  links the inner query to the current outer row.

- p2.change_date is used because the filtering is
  applied to rows inside the subquery. Using only
  change_date would be ambiguous since both p1 and
  p2 contain a change_date column.

- ORDER BY change_date DESC returns the newest
  valid price first.

- LIMIT 1 selects the latest price before or on
  the target date.

- If no price change exists before the target date,
  the subquery returns NULL, and COALESCE returns
  the initial price of 10.
*/
