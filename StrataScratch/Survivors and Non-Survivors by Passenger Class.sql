-- =====================================================
-- Problem: Survivors and Non-Survivors by Passenger Class
-- Platform: StrataScratch
-- Difficulty: Easy
-- =====================================================

/*
Problem Statement

Create a report showing the number of survivors and non-survivors
for each passenger class.

Passenger classes:
- First class  : pclass = 1
- Second class : pclass = 2
- Third class  : pclass = 3

Expected Output:
- survived
- first_class
- second_class
- third_class
*/

-- =====================================================
-- Table Schema
-- =====================================================

/*
titanic

age          DOUBLE PRECISION
cabin        TEXT
embarked     TEXT
fare         DOUBLE PRECISION
name         TEXT
parch        BIGINT
passengerid  BIGINT
pclass       BIGINT
sex          TEXT
sibsp        BIGINT
survived     BIGINT
ticket       TEXT
*/

-- =====================================================
-- Approach
-- =====================================================

/*
1. Group the data by survival status (survived).
2. For each group, count passengers belonging to each class.
3. Use conditional aggregation with CASE statements.
4. SUM() adds 1 whenever a passenger belongs to the specified class.
5. Return one row for survivors and one row for non-survivors.
*/

-- =====================================================
-- Solution
-- =====================================================

SELECT
    survived,
    SUM(CASE WHEN pclass = 1 THEN 1 ELSE 0 END) AS first_class,
    SUM(CASE WHEN pclass = 2 THEN 1 ELSE 0 END) AS second_class,
    SUM(CASE WHEN pclass = 3 THEN 1 ELSE 0 END) AS third_class
FROM titanic
GROUP BY survived
ORDER BY survived;

-- =====================================================
-- Concepts Used
-- =====================================================

/*
- GROUP BY
- Conditional Aggregation
- CASE WHEN
- SUM()
*/

-- =====================================================
-- Key Takeaways
-- =====================================================

/*
- GROUP BY determines what each row in the output represents.
- Conditional aggregation counts rows that satisfy a condition.
- SUM(CASE WHEN condition THEN 1 ELSE 0 END) is a common SQL pattern for pivoting data.
- CASE returns 1 for matching rows and 0 otherwise; SUM() then counts the matches.
- This technique creates pivot-style reports without using the PIVOT operator.
*/
