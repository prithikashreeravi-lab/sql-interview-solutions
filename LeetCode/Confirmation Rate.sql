-- =====================================================
-- Problem: Confirmation Rate
-- Platform: LeetCode
-- Difficulty: Medium
-- =====================================================

/*
Problem Statement

The signups table contains users who signed up.
The confirmations table contains confirmation actions
for users.

Calculate the confirmation rate for each user.

Confirmation rate =
(number of confirmed actions) /
(total confirmation actions)

If a user has no confirmation records,
return a confirmation rate of 0.

Round the confirmation rate to 2 decimal places.

Return:
- user_id
- confirmation_rate
*/

-- =====================================================
-- Table Schema
-- =====================================================

/*
Signups

user_id     INT
time_stamp  DATETIME


Confirmations

user_id     INT
time_stamp  DATETIME
action      VARCHAR
*/


-- =====================================================
-- Solution
-- =====================================================

SELECT
    s.user_id,
    COALESCE(
        ROUND(
            SUM(
                CASE 
                    WHEN c.action = 'confirmed' THEN 1
                    ELSE 0
                END
            ) * 1.0
            / NULLIF(COUNT(c.action), 0),
            2
        ),
        0
    ) AS confirmation_rate
FROM Signups s
LEFT JOIN Confirmations c
    ON s.user_id = c.user_id
GROUP BY s.user_id;


-- =====================================================
-- Key Concepts Practiced
-- =====================================================

/*
1. LEFT JOIN
   - Keeps users who have no confirmation records

2. CASE WHEN
   - Counts only confirmed actions

3. NULLIF()
   - Prevents division by zero

4. COALESCE()
   - Converts NULL results into 0

5. * 1.0
   - Forces decimal division

6. ROUND()
   - Formats result to 2 decimal places
*/
