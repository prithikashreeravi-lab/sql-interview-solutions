-- =====================================================
-- Problem: Spotify Streaming History
-- Platform: DataLemur
-- Difficulty: Medium
-- =====================================================

/*
Problem Statement

You're given two tables containing Spotify users' streaming
activity:

1. songs_history
   - Contains historical song play counts up to
     July 31, 2022.

2. songs_weekly
   - Contains individual song listens for the week
     of August 1–7, 2022.

Calculate the cumulative number of song plays for each
user and song up to August 4, 2022.

Return:
- user_id
- song_id
- song_plays

Order the result by song_plays in descending order.

Notes:
- songs_weekly stores one row per listen.
- New users or songs may appear only in songs_weekly.
*/

-- =====================================================
-- Table Schema
-- =====================================================

/*
songs_history

+------------+---------+
| Column     | Type    |
+------------+---------+
| history_id | integer |
| user_id    | integer |
| song_id    | integer |
| song_plays | integer |
+------------+---------+
*/

/*
songs_weekly

+-------------+----------+
| Column Name | Type     |
+-------------+----------+
| user_id     | integer  |
| song_id     | integer  |
| listen_time | datetime |
+-------------+----------+
*/

-- =====================================================
-- Solution
-- =====================================================

WITH new AS (
    SELECT
        user_id,
        song_id,
        COUNT(listen_time) AS song_plays
    FROM songs_weekly
    WHERE listen_time < '2022-08-05'
    GROUP BY user_id, song_id
)

SELECT
    user_id,
    song_id,
    SUM(song_plays) AS song_plays
FROM (
    SELECT
        user_id,
        song_id,
        song_plays
    FROM songs_history

    UNION ALL

    SELECT
        user_id,
        song_id,
        song_plays
    FROM new
) AS combined
GROUP BY
    user_id,
    song_id
ORDER BY
    song_plays DESC;

-- =====================================================
-- Explanation
-- =====================================================

/*
1. Create the CTE (new)
   - Count each listen in songs_weekly.
   - Since every row represents one play, COUNT()
     converts the weekly data into total song plays.
   - Only include listens before August 5, 2022
     (August 1–4).

2. UNION ALL
   - Combine historical totals with the newly
     calculated totals.
   - UNION ALL keeps every row because both tables
     contribute to the final cumulative count.

3. GROUP BY user_id, song_id
   - Merge duplicate user-song combinations from
     both datasets.

4. SUM(song_plays)
   - Adds historical plays and new weekly plays to
     produce the cumulative total.

5. ORDER BY song_plays DESC
   - Displays the most-played songs first.

--------------------------------------------------------
Example
--------------------------------------------------------

songs_history

User  Song  Plays
----  ----  -----
1     101     25
2     201     18

songs_weekly (Aug 1–4)

User  Song
----  ----
1     101
1     101
2     201
3     301

CTE (new)

User  Song  Plays
----  ----  -----
1     101      2
2     201      1
3     301      1

After UNION ALL

1 101 25
2 201 18
1 101  2
2 201  1
3 301  1

After GROUP BY + SUM

User  Song  Plays
----  ----  -----
1     101     27
2     201     19
3     301      1

--------------------------------------------------------
Time Complexity
--------------------------------------------------------

O(n)

- COUNT() scans songs_weekly.
- UNION ALL appends rows.
- GROUP BY aggregates the combined dataset.

--------------------------------------------------------
Key Concepts
--------------------------------------------------------

- Common Table Expressions (CTEs)
- COUNT()
- UNION ALL
- GROUP BY
- SUM()
- Data Aggregation
- Cumulative Totals
