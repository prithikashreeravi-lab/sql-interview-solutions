-- =====================================================
-- Problem: AWS Server Fleet Total Uptime
-- Platform: DataLemur
-- Difficulty: Hard
-- =====================================================

/*
Problem Statement

Amazon Web Services (AWS) wants to
optimize server usage by analyzing
the total time its fleet of servers
was running.

Each server can start and stop
multiple times.

Calculate the total uptime of the
entire server fleet in units of
full days.

The total fleet uptime is the sum
of each server's individual uptime.
*/

-- =====================================================
-- Table Schema
-- =====================================================

/*
server_utilization

+------------------+-----------+
| Column Name      | Type      |
+------------------+-----------+
| server_id        | integer   |
| status_time      | timestamp |
| session_status   | string    |
+------------------+-----------+
*/

-- =====================================================
-- Solution
-- =====================================================

WITH server_sessions AS (
    SELECT
        server_id,
        status_time,
        session_status,
        LEAD(status_time) OVER (
            PARTITION BY server_id
            ORDER BY status_time
        ) AS next_time
    FROM server_utilization
)

SELECT
    FLOOR(
        SUM(
            EXTRACT(
                EPOCH FROM (next_time - status_time)
            )
        ) / 86400
    ) AS total_uptime_days
FROM server_sessions
WHERE session_status = 'start';

-- =====================================================
-- Explanation
-- =====================================================

/*
1. Pair Start and Stop Times

   LEAD() retrieves the next
   timestamp for each server.

   Since server events alternate
   between start and stop, every
   start time is paired with its
   following stop time.

2. Calculate Server Uptime

   For each start event:

   uptime = stop_time - start_time

   PostgreSQL returns this as
   an interval.

3. Convert Interval to Days

   EXTRACT(EPOCH FROM interval)
   converts the duration into
   seconds.

   Divide by:

   86400 seconds = 1 full day

4. Sum Fleet Uptime

   SUM() combines the uptime of
   all servers.

5. Return Full Days Only

   FLOOR() removes partial days
   because the output requires
   complete days.
*/

-- =====================================================
-- Time Complexity
-- =====================================================

/*
O(n log n)

n = number of rows in
    server_utilization

- Window function sorts events
  by server_id and status_time.
- SUM() aggregates all uptime
  periods.
*/

-- =====================================================
-- Key Concepts
-- =====================================================

/*
- Common Table Expressions (CTEs)
- LEAD() Window Function
- PARTITION BY
- Timestamp Arithmetic
- EXTRACT(EPOCH)
- INTERVAL Handling
- SUM()
- FLOOR()
*/
