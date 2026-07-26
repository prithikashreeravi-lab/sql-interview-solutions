-- =====================================================
-- Problem: Investments in 2016
-- Platform: LeetCode
-- Difficulty: Medium
-- =====================================================

/*
Problem Statement

The Insurance table stores information
about insurance policyholders.

Calculate the sum of tiv_2016 for
policyholders who:

1. Have a tiv_2015 value shared by
   at least one other policyholder.

2. Have a unique city location,
   meaning their (lat, lon) pair
   does not appear more than once.

Round the final result to
2 decimal places.

Return:
- tiv_2016
*/

-- =====================================================
-- Table Schema
-- =====================================================

/*
Insurance

pid         INT
tiv_2015    FLOAT
tiv_2016    FLOAT
lat         FLOAT
lon         FLOAT
*/


-- =====================================================
-- Solution (PostgreSQL)
-- =====================================================

SELECT
    ROUND(SUM(tiv_2016)::numeric, 2) AS tiv_2016
FROM Insurance
WHERE tiv_2015 IN (
    SELECT tiv_2015
    FROM Insurance
    GROUP BY tiv_2015
    HAVING COUNT(*) > 1
)
AND (lat, lon) IN (
    SELECT lat, lon
    FROM Insurance
    GROUP BY lat, lon
    HAVING COUNT(*) = 1
);


-- =====================================================
-- Alternative Solution (Using CTEs)
-- =====================================================

/*
WITH repeated_tiv AS (
    SELECT tiv_2015
    FROM Insurance
    GROUP BY tiv_2015
    HAVING COUNT(*) > 1
),
unique_location AS (
    SELECT lat, lon
    FROM Insurance
    GROUP BY lat, lon
    HAVING COUNT(*) = 1
)

SELECT
    ROUND(SUM(tiv_2016)::numeric, 2) AS tiv_2016
FROM Insurance
WHERE tiv_2015 IN (
    SELECT tiv_2015
    FROM repeated_tiv
)
AND (lat, lon) IN (
    SELECT lat, lon
    FROM unique_location
);
*/


-- =====================================================
-- Key Concepts Practiced
-- =====================================================

/*
1. GROUP BY
   - Groups rows having the same
     tiv_2015 or (lat, lon).

2. HAVING
   - Filters groups after aggregation.
   - COUNT(*) > 1 finds duplicated
     tiv_2015 values.
   - COUNT(*) = 1 finds unique
     city locations.

3. Subqueries
   - Returns repeated tiv_2015 values.
   - Returns unique (lat, lon) pairs.

4. Row Value Comparison
   - (lat, lon) IN (...)
     compares both latitude and
     longitude together as a pair.

5. Filtering
   - Keeps only policyholders that
     satisfy both required conditions.

6. Aggregate Function
   - SUM(tiv_2016) calculates the
     total investment value in 2016.

7. Type Casting
   - ::numeric converts the result
     to a numeric type before rounding.

8. ROUND()
   - Rounds the final total to
     two decimal places.
*/


-- =====================================================
-- Interview Explanation
-- =====================================================

/*
1. Find all tiv_2015 values that
   appear more than once.

2. Find all unique (lat, lon)
   location pairs.

3. Filter the Insurance table to
   include only policyholders who
   satisfy both conditions.

4. Sum their tiv_2016 values.

5. Convert the result to numeric
   and round it to two decimal places.
*/
