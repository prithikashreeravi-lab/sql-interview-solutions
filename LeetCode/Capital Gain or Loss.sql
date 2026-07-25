-- =====================================================
-- Problem: Capital Gain/Loss
-- Platform: LeetCode
-- Difficulty: Medium
-- =====================================================

/*
Problem Statement

The Stocks table records buy and sell transactions
for different stocks.

Each stock can be bought and sold one or more times.

Calculate the total capital gain or loss
for each stock.

Capital Gain/Loss =
Total Sell Prices - Total Buy Prices

Return:
- stock_name
- capital_gain_loss
*/

-- =====================================================
-- Table Schema
-- =====================================================

/*
Stocks

stock_name      VARCHAR
operation       ENUM('Buy', 'Sell')
operation_day   INT
price           INT
*/


-- =====================================================
-- Solution
-- =====================================================

SELECT
    stock_name,
    SUM(
        CASE
            WHEN operation = 'Sell' THEN price
            ELSE -price
        END
    ) AS capital_gain_loss
FROM Stocks
GROUP BY stock_name;


-- =====================================================
-- Key Concepts Practiced
-- =====================================================

/*
1. CASE WHEN
   - Converts Sell transactions into positive values
   - Converts Buy transactions into negative values

2. SUM()
   - Adds all transaction values to calculate
     the final capital gain/loss

3. GROUP BY
   - Calculates the result separately
     for each stock

4. Conditional Aggregation
   - Aggregates values differently based
     on the operation type

5. Financial Calculation
   - Capital Gain/Loss =
     Total Sell Prices - Total Buy Prices

6. Data Transformation
   - Treats each transaction as a cash flow:
     Sell = +price
     Buy = -price
*/
