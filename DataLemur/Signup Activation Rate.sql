-- =====================================================
-- Problem: Signup Activation Rate
-- Platform: DataLemur
-- Difficulty: Medium
-- =====================================================

/*
Problem Statement

New TikTok users sign up using their email addresses.
To activate their accounts, they must confirm their
signup by replying to a text message.

A user may receive multiple text messages before
successfully confirming their account.

Calculate the activation rate for users listed in
the emails table.

Return:

- activation_rate (rounded to 2 decimal places)

Notes:

- Consider only users in the emails table.
- Each email account should be counted only once.
- Multiple confirmation texts for the same email
  should not affect the result.
*/

-- =====================================================
-- Table Schema
-- =====================================================

/*
emails

+-------------+-----------+
| Column Name | Type      |
+-------------+-----------+
| email_id    | integer   |
| user_id     | integer   |
| signup_date | datetime  |
+-------------+-----------+

texts

+---------------+-----------+
| Column Name   | Type      |
+---------------+-----------+
| text_id       | integer   |
| email_id      | integer   |
| signup_action | string    |
+---------------+-----------+
*/

-- =====================================================
-- Solution
-- =====================================================

WITH email_status AS (
    SELECT
        e.email_id,
        MAX(
            CASE
                WHEN t.signup_action = 'Confirmed'
                THEN 1
                ELSE 0
            END
        ) AS confirmed
    FROM emails e
    LEFT JOIN texts t
        ON e.email_id = t.email_id
    GROUP BY e.email_id
)

SELECT
    ROUND(
        AVG(
            CASE
                WHEN confirmed = 1 THEN 1.0
                ELSE 0
            END
        ),
        2
    ) AS activation_rate
FROM email_status;

-- =====================================================
-- Explanation
-- =====================================================

/*
1. Join Emails and Texts

   Use a LEFT JOIN so that every email
   signup is included, even if no text
   messages exist.

2. Determine Confirmation Status

   MAX(CASE WHEN signup_action = 'Confirmed'
            THEN 1 ELSE 0 END)

   - Returns 1 if the email has at least
     one confirmation.
   - Returns 0 otherwise.

   This ensures each email is counted
   only once regardless of how many text
   messages were sent.

3. Calculate Activation Rate

   AVG(confirmed)

   Since confirmed contains only 0s and 1s:

   - 1 = Activated
   - 0 = Not Activated

   The average equals the proportion of
   activated accounts.

4. Round the Result

   ROUND(..., 2)

   Returns the activation rate rounded
   to two decimal places.

*/

-- =====================================================
-- Time Complexity
-- =====================================================

/*
O(n)

n = number of rows in the texts table

- LEFT JOIN processes each matching row.
- GROUP BY aggregates each email once.
- AVG scans the grouped results once.
*/

-- =====================================================
-- Key Concepts
-- =====================================================

/*
- Common Table Expression (CTE)
- LEFT JOIN
- CASE WHEN
- MAX()
- GROUP BY
- Aggregate Functions
- AVG()
- ROUND()
*/
