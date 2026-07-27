-- =====================================================
-- Problem: Uncategorised Calls Percentage
-- Platform: DataLemur
-- Difficulty: Medium
-- =====================================================

/*
Problem Statement

UnitedHealth Group (UHG) has a program
called Advocate4Me that allows policy
holders to call an advocate for
healthcare support.

Some calls cannot be categorised and
are recorded as:
- 'n/a'
- NULL (empty)

Calculate the percentage of calls that
cannot be categorised.

Round the answer to 1 decimal place.

Return:
- uncategorised_call_pct
*/

-- =====================================================
-- Table Schema
-- =====================================================

/*
callers

policy_holder_id      INTEGER
case_id               VARCHAR
call_category         VARCHAR
call_date             TIMESTAMP
call_duration_secs    INTEGER
*/

-- =====================================================
-- Solution (PostgreSQL)
-- =====================================================

SELECT
    ROUND(
        100.0 * SUM(
            CASE
                WHEN call_category IS NULL
                     OR call_category = 'n/a'
                THEN 1
                ELSE 0
            END
        ) / COUNT(*),
        1
    ) AS uncategorised_call_pct
FROM callers;


-- =====================================================
-- Alternative Solution
-- =====================================================

/*
SELECT
    ROUND(
        AVG(
            CASE
                WHEN call_category IS NULL
                     OR call_category = 'n/a'
                THEN 100.0
                ELSE 0
            END
        ),
        1
    ) AS uncategorised_call_pct
FROM callers;
*/


-- =====================================================
-- Key Concepts Practiced
-- =====================================================

/*
1. CASE Expression
   - Labels uncategorised calls as 1.
   - Labels categorised calls as 0.

2. SUM()
   - Counts the number of
     uncategorised calls.

3. COUNT(*)
   - Counts the total number
     of calls.

4. Percentage Calculation
   - (Uncategorised Calls /
      Total Calls) * 100

5. Floating-Point Arithmetic
   - Using 100.0 ensures decimal
     division instead of integer
     division.

6. ROUND()
   - Rounds the final percentage
     to one decimal place.
*/


-- =====================================================
-- Interview Explanation
-- =====================================================

/*
1. Identify uncategorised calls
   using CASE.

2. Count uncategorised calls
   with SUM().

3. Count all calls using COUNT(*).

4. Divide uncategorised calls
   by total calls.

5. Multiply by 100 to convert
   the ratio into a percentage.

6. Round the result to
   one decimal place.
*/
