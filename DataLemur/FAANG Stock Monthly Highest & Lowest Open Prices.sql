-- =====================================================
-- Problem: FAANG Stock Monthly Highest & Lowest Open Prices
-- Platform: Bloomberg / DataLemur
-- Difficulty: Medium
-- =====================================================

/*
Problem Statement

Bloomberg is analyzing the highest and lowest
opening stock prices for each FAANG stock
by month over the years.

For each stock:

- Find the month-year with the highest
  opening price.
- Find the month-year with the lowest
  opening price.

Return:

- ticker
- highest_mth
- highest_open
- lowest_mth
- lowest_open

Sort the results by ticker.
*/

-- =====================================================
-- Table Schema
-- =====================================================

/*
stock_prices

+-------------+-----------+
| Column Name | Type      |
+-------------+-----------+
| date        | datetime  |
| ticker      | varchar   |
| open        | decimal   |
| high        | decimal   |
| low         | decimal   |
| close       | decimal   |
+-------------+-----------+
*/

-- =====================================================
-- Solution
-- =====================================================

WITH monthly_prices AS (
    SELECT
        ticker,
        TO_CHAR(date, 'Mon-YYYY') AS month_year,
        MAX(open) AS highest_open,
        MIN(open) AS lowest_open
    FROM stock_prices
    GROUP BY
        ticker,
        TO_CHAR(date, 'Mon-YYYY')
),

ranked AS (
    SELECT
        *,
        RANK() OVER (
            PARTITION BY ticker
            ORDER BY highest_open DESC
        ) AS max_rank,
        RANK() OVER (
            PARTITION BY ticker
            ORDER BY lowest_open ASC
        ) AS min_rank
    FROM monthly_prices
)

SELECT
    ticker,
    MAX(CASE WHEN max_rank = 1 THEN month_year END) AS highest_mth,
    MAX(CASE WHEN max_rank = 1 THEN highest_open END) AS highest_open,
    MAX(CASE WHEN min_rank = 1 THEN month_year END) AS lowest_mth,
    MAX(CASE WHEN min_rank = 1 THEN lowest_open END) AS lowest_open
FROM ranked
GROUP BY ticker
ORDER BY ticker;

-- =====================================================
-- Explanation
-- =====================================================

/*
1. Aggregate Monthly Open Prices

   Group the data by:

   - ticker
   - month-year

   Calculate:

   - MAX(open) → highest opening price
     during that month.
   - MIN(open) → lowest opening price
     during that month.

   Example:

   ticker | month_year | highest_open | lowest_open
   -------+------------+--------------+------------
   AAPL   | Jan-2023   | 145.20       | 132.10
   AAPL   | Feb-2023   | 153.80       | 147.30


2. Rank Monthly Maximum Prices

   RANK() OVER (
       PARTITION BY ticker
       ORDER BY highest_open DESC
   )

   - Finds the month with the highest
     monthly opening price for each stock.


3. Rank Monthly Minimum Prices

   RANK() OVER (
       PARTITION BY ticker
       ORDER BY lowest_open ASC
   )

   - Finds the month with the lowest
     monthly opening price for each stock.


4. Extract the Required Months

   CASE expressions return values only
   for Rank = 1.

   MAX() converts multiple ranked rows
   into a single row per ticker.


5. Sort Results

   ORDER BY ticker

   Returns the stocks in alphabetical
   order.

*/

-- =====================================================
-- Time Complexity
-- =====================================================

/*
O(n log n)

n = number of rows in stock_prices

- GROUP BY computes monthly aggregates.
- Window functions rank monthly records.
- Final GROUP BY pivots results into
  one row per ticker.
*/

-- =====================================================
-- Key Concepts
-- =====================================================

/*
- Common Table Expression (CTE)
- GROUP BY
- Aggregate Functions
- Window Functions
- RANK()
- CASE Expression
- Conditional Aggregation
- ORDER BY
*/
