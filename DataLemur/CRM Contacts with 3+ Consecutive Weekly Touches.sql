-- =====================================================
-- Problem: CRM Contacts with 3+ Consecutive Weekly Touches
-- Platform: DataLemur
-- Difficulty: Hard
-- =====================================================

/*
Problem Statement

Identify contacts who satisfy
both conditions:

1. Had marketing touches for
   three or more consecutive weeks.

2. Had at least one marketing
   touch of type 'trial_request'.

Return the email addresses
of these contacts.
*/

-- =====================================================
-- Table Schema
-- =====================================================

/*
marketing_touches

+--------------+------------------------------------------------+
| Column Name  | Type                                           |
+--------------+------------------------------------------------+
| event_id     | integer                                        |
| contact_id   | integer                                        |
| event_type   | string ('webinar', 'conference_registration',  |
|              |         'trial_request')                       |
| event_date   | date                                           |
+--------------+------------------------------------------------+


crm_contacts

+--------------+----------+
| Column Name  | Type     |
+--------------+----------+
| contact_id   | integer  |
| email        | string   |
+--------------+----------+
*/

-- =====================================================
-- Solution
-- =====================================================

WITH weekly_touches AS (

    -- Step 1:
    -- Get unique weeks where each contact
    -- had at least one marketing touch

    SELECT DISTINCT
        contact_id,
        DATE_TRUNC('week', event_date)::date AS week_start
    FROM marketing_touches

),

numbered AS (

    -- Step 2:
    -- Assign a sequence number to each
    -- week's activity for every contact

    SELECT
        contact_id,
        week_start,
        ROW_NUMBER() OVER (
            PARTITION BY contact_id
            ORDER BY week_start
        ) AS rn
    FROM weekly_touches

),

streaks AS (

    -- Step 3:
    -- Create a grouping value for
    -- consecutive weeks

    SELECT
        contact_id,
        week_start,
        week_start - (rn * INTERVAL '1 week') AS grp
    FROM numbered

),

qualified_contacts AS (

    -- Step 4:
    -- Keep contacts with streaks
    -- lasting 3 or more weeks

    SELECT
        contact_id
    FROM streaks
    GROUP BY contact_id, grp
    HAVING COUNT(*) >= 3

),

trial_contacts AS (

    -- Step 5:
    -- Find contacts who had at least
    -- one trial_request event

    SELECT DISTINCT
        contact_id
    FROM marketing_touches
    WHERE event_type = 'trial_request'

)

-- Step 6:
-- Return emails of contacts who satisfy
-- both conditions

SELECT DISTINCT
    c.email
FROM qualified_contacts qc
JOIN trial_contacts tc
    ON qc.contact_id = tc.contact_id
JOIN crm_contacts c
    ON qc.contact_id = c.contact_id;


-- =====================================================
-- Explanation
-- =====================================================

/*

1. Find Weekly Touches

   DATE_TRUNC('week') converts each
   event date into its week.

   DISTINCT removes duplicate events
   in the same week.

2. Number Weekly Activity

   ROW_NUMBER() gives each week's
   activity a sequence number per
   contact.

3. Identify Consecutive Weeks

   Subtracting rn weeks from each
   date creates the same grouping
   value for consecutive weeks.

   This allows us to identify
   continuous weekly streaks.

4. Find 3+ Week Streaks

   GROUP BY contact_id and grp
   combines consecutive weeks.

   HAVING COUNT(*) >= 3 keeps only
   contacts with three or more
   consecutive active weeks.

5. Find Trial Request Contacts

   Select contacts who performed
   at least one 'trial_request'
   event.

6. Combine Both Conditions

   JOIN ensures the contact has:

   - A 3+ week marketing streak
   - At least one trial_request

   Finally, join with crm_contacts
   to return email addresses.

*/


-- =====================================================
-- Time Complexity
-- =====================================================

/*
O(n log n)

n = number of rows in marketing_touches

- DISTINCT removes duplicate weeks.
- ROW_NUMBER() sorts events per contact.
- GROUP BY identifies streaks.
- JOIN combines qualifying contacts.
*/


-- =====================================================
-- Key Concepts
-- =====================================================

/*
- Common Table Expressions (CTEs)
- DATE_TRUNC()
- ROW_NUMBER()
- Window Functions
- Gaps and Islands Pattern
- INTERVAL Arithmetic
- GROUP BY
- HAVING
- JOIN
- DISTINCT
*/
