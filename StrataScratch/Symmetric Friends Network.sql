-- =====================================================
-- Problem: Symmetric Friends Network
-- Platform: StrataScratch
-- Difficulty: Easy
-- =====================================================

/*
Problem Statement

Make the friends network symmetric.

If user A is friends with user B, the output should also
contain user B as friends with user A.

Example:
Original:
0 → 1

Output:
0 → 1
1 → 0

Return the complete symmetric friends network.
*/

-- =====================================================
-- Table Schema
-- =====================================================

/*
google_friends_network

user_id     BIGINT
friend_id   BIGINT
*/

-- =====================================================
-- Approach
-- =====================================================

/*
1. Select all existing friendships.
2. Create the reverse of each friendship by swapping
   user_id and friend_id.
3. Combine the original and reversed friendships using UNION.
4. UNION removes duplicate friendships automatically.
*/

-- =====================================================
-- Solution
-- =====================================================

SELECT
    user_id,
    friend_id
FROM google_friends_network

UNION

SELECT
    friend_id AS user_id,
    user_id AS friend_id
FROM google_friends_network;

-- =====================================================
-- Concepts Used
-- =====================================================

/*
- UNION
- Column Aliasing (AS)
*/

-- =====================================================
-- Key Takeaways
-- =====================================================

/*
- UNION combines the results of two SELECT statements vertically.
- Both SELECT statements must return the same number of columns with compatible data types.
- Swapping user_id and friend_id creates the reverse friendship.
- UNION automatically removes duplicate rows.
- Use UNION when you need to append additional rows to an existing result set.
*/
