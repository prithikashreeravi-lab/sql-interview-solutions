-- =====================================================
-- Problem: Friend With Most Friends
-- Platform: LeetCode
-- Difficulty: Medium
-- =====================================================

/*
Problem Statement

The RequestAccepted table stores accepted friend requests.

Each row represents a friendship between:
- requester_id
- accepter_id

A friendship counts for both users.

Find the person who has the highest number of friends.

Return:
- id
- num (number of friends)
*/

-- =====================================================
-- Table Schema
-- =====================================================

/*
RequestAccepted

requester_id    INT
accepter_id     INT
accept_date     DATE
*/

-- =====================================================
-- Approach
-- =====================================================

/*
1. Extract all requester IDs.
2. Extract all accepter IDs.
3. Combine them into one column using UNION ALL.
4. Count how many times each user appears.
5. Sort the counts in descending order.
6. Return the user with the highest friend count.
*/

-- =====================================================
-- Solution
-- =====================================================

SELECT
    id,
    COUNT(*) AS num
FROM (
    SELECT requester_id AS id
    FROM RequestAccepted

    UNION ALL

    SELECT accepter_id AS id
    FROM RequestAccepted
) AS friends
GROUP BY id
ORDER BY num DESC
LIMIT 1;

-- =====================================================
-- Concepts Used
-- =====================================================

/*
- UNION ALL
- Subquery (Derived Table)
- GROUP BY
- COUNT()
- ORDER BY
- LIMIT
*/

-- =====================================================
-- Key Takeaways
-- =====================================================

/*
- Every accepted friendship belongs to both users.
- UNION ALL combines requester_id and accepter_id into a
  single list of user IDs.
- UNION ALL is required because duplicate IDs represent
  multiple friendships and must not be removed.
- GROUP BY counts the total number of friends for each user.
- ORDER BY DESC ranks users from the most friends to the least.
- LIMIT 1 returns the user with the highest friend count.
- This solution runs in a single aggregation after creating
  the combined list of user IDs.
*/
