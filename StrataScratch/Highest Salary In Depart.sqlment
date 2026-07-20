WITH cte AS(select 
department,
first_name,
salary,
RANK() OVER(PARTITION BY department
ORDER BY salary DESC) AS rnk
from employee)
SELECT 
department,
first_name,
salary
FROM cte 
WHERE rnk=1;
