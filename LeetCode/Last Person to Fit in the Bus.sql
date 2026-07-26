-- =====================================================
-- Problem: Last Person to Fit in the Bus
-- Platform: LeetCode
-- Difficulty: Medium
-- =====================================================

/*
Problem Statement

There is a queue of people waiting to board a bus.

The bus has a maximum weight limit of 1000 kg.

People board the bus one at a time
according to their turn.

Find the name of the last person
who can board the bus without the
total weight exceeding 1000 kg.

Return:
- person_name
*/

-- =====================================================
-- Table Schema
-- =====================================================

/*
Queue

person_id      INT
person_name    VARCHAR
weight         INT
turn           INT
*/


-- =====================================================
-- Solution
-- =====================================================

WITH boarding AS (
    SELECT
        *,
        SUM(weight) OVER (ORDER BY turn) AS total_weight
    FROM Queue
)

SELECT
    person_name
FROM boarding
WHERE total_weight <= 1000
ORDER BY turn DESC
LIMIT 1;


-- =====================================================
-- Key Concepts Practiced
-- =====================================================

/*
1. Common Table Expression (CTE)
   - Stores the running total of
     passenger weights.

2. Window Function
   - SUM(weight) OVER (ORDER BY turn)
     calculates the cumulative weight
     after each person boards.

3. Running Total
   - Adds each person's weight to the
     total weight of everyone before them.

4. ORDER BY in Window Function
   - Ensures people are processed in
     boarding order (turn).

5. Filtering
   - WHERE total_weight <= 1000
     keeps only passengers who can
     successfully board.

6. Finding the Last Valid Person
   - ORDER BY turn DESC returns the
     passenger with the highest boarding
     turn among those who fit.

7. LIMIT 1
   - Returns only the last passenger
     who boarded successfully.
*/


-- =====================================================
-- Interview Explanation
-- =====================================================

/*
1. Calculate a running total of passenger
   weights using a window function.

2. Remove all passengers whose cumulative
   weight exceeds the bus limit.

3. Among the remaining passengers,
   select the one with the largest turn,
   since they are the last person who
   successfully boarded the bus.
*/
