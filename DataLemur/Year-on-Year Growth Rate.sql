-- =====================================================
-- Problem: Year-on-Year Growth Rate
-- Platform: DataLemur
-- Difficulty: Hard
-- =====================================================

/*
Problem Statement

Assume you're given a table
containing information about
Wayfair user transactions for
different products.

Write a query to calculate the
year-on-year growth rate for
the total spend of each product,
grouping the results by
product ID.

The output should include:

- year
- product_id
- current year's spend
- previous year's spend
- year-on-year growth percentage
  (rounded to 2 decimal places)

Sort the results by product_id
and year in ascending order.
*/

-- =====================================================
-- Table Schema
-- =====================================================

/*
user_transactions

+------------------+----------+
| Column Name      | Type     |
+------------------+----------+
| transaction_id   | integer  |
| product_id       | integer  |
| spend            | decimal  |
| transaction_date | datetime |
+------------------+----------+
*/

-- =====================================================
-- Solution
-- =====================================================

WITH yearly_spend AS (

    SELECT
        EXTRACT(YEAR FROM transaction_date) AS year,
        product_id,
        SUM(spend) AS curr_year_spend
    FROM user_transactions
    GROUP BY
        EXTRACT(YEAR FROM transaction_date),
        product_id
)

SELECT
    y1.year,
    y1.product_id,
    y1.curr_year_spend,
    y2.curr_year_spend AS prev_year_spend,
    ROUND(
        100.0 * (y1.curr_year_spend - y2.curr_year_spend)
        / y2.curr_year_spend,
        2
    ) AS yoy_rate
FROM yearly_spend y1
LEFT JOIN yearly_spend y2
    ON y1.product_id = y2.product_id
   AND y1.year = y2.year + 1
ORDER BY
    y1.product_id,
    y1.year;

-- =====================================================
-- Explanation
-- =====================================================

/*
1. Calculate Yearly Spend

   Group transactions by
   product_id and year.

   SUM(spend) computes the
   total annual spend for
   each product.

2. Self Join

   Join the yearly totals
   table to itself.

   Match:

   - same product_id
   - previous year
     (current year =
      previous year + 1)

3. Calculate YoY Growth

   Formula:

   ((Current Spend -
     Previous Spend)
    / Previous Spend)
    * 100

   ROUND(..., 2) formats
   the percentage to
   two decimal places.

4. Products Without
   Previous Year

   LEFT JOIN ensures the
   earliest year for each
   product is still returned.

   Since there is no previous
   year's spend, both
   prev_year_spend and
   yoy_rate will be NULL.

5. Sort Results

   Order by:

   - product_id
   - year

   to display each product's
   yearly trend chronologically.
*/

-- =====================================================
-- Time Complexity
-- =====================================================

/*
O(n)

n = number of rows in
    user_transactions

- Aggregate yearly spend
  using GROUP BY.
- Self join yearly totals.
- Final sort by
  product_id and year.
*/

-- =====================================================
-- Key Concepts
-- =====================================================

/*
- Common Table Expressions (CTEs)
- GROUP BY
- SUM()
- Self Join
- EXTRACT()
- ROUND()
- Year-on-Year (YoY) Growth
*/
