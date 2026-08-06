-- =====================================================
-- Problem: Advertiser Status Update
-- Platform: DataLemur
-- Difficulty: Hard
-- =====================================================

/*
Problem Statement

Given two tables:

1. advertiser
   - Contains each advertiser's
     previous payment status.

2. daily_pay
   - Contains advertisers who
     made a payment today.

Update every advertiser's payment
status based on today's payment.

Status Rules:

- New advertiser who paid today
  -> NEW

- Existing advertiser who paid
  today
  -> EXISTING

- Churned advertiser who paid
  today
  -> RESURRECT

- Any advertiser who did not
  pay today
  -> CHURN

Return:

- user_id
- new_status

Sort the output by user_id.
*/

-- =====================================================
-- Table Schema
-- =====================================================

/*
advertiser

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| user_id     | string  |
| status      | string  |
+-------------+---------+

daily_pay

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| user_id     | string  |
| paid        | decimal |
+-------------+---------+
*/

-- =====================================================
-- Solution
-- =====================================================

SELECT
    COALESCE(a.user_id, d.user_id) AS user_id,
    CASE
        WHEN a.user_id IS NULL THEN 'NEW'
        WHEN d.user_id IS NULL THEN 'CHURN'
        WHEN a.status = 'CHURN' THEN 'RESURRECT'
        ELSE 'EXISTING'
    END AS new_status
FROM advertiser a
FULL OUTER JOIN daily_pay d
    ON a.user_id = d.user_id
ORDER BY user_id;

-- =====================================================
-- Explanation
-- =====================================================

/*
1. Combine Both Tables

   FULL OUTER JOIN keeps every
   advertiser, including:

   - Advertisers who paid today.
   - Advertisers who didn't pay.
   - Brand-new advertisers who
     appear only in daily_pay.

2. Determine user_id

   COALESCE() returns the
   non-NULL user_id from either
   table.

3. Update Status

   CASE applies the rules:

   - Missing from advertiser
     -> NEW

   - Missing from daily_pay
     -> CHURN

   - Previous status = CHURN
     and paid today
     -> RESURRECT

   - Otherwise paid today
     -> EXISTING

4. Sort Results

   Return all advertisers
   ordered by user_id.
*/

-- =====================================================
-- Time Complexity
-- =====================================================

/*
O(n + m)

n = rows in advertiser
m = rows in daily_pay

- FULL OUTER JOIN scans both
  tables.
- CASE evaluates each joined row
  once.
- ORDER BY may require
  O((n+m) log(n+m)).
*/

-- =====================================================
-- Key Concepts
-- =====================================================

/*
- FULL OUTER JOIN
- CASE
- COALESCE()
- NULL Handling
- Business Logic Mapping
*/
