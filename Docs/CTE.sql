# =========================
# 🔥 CTE (Common Table Expression)
# =========================

👉 A CTE is a temporary result set defined using WITH clause.

✔ Improves readability
✔ Reusable within a query
✔ Works like a temporary table
❗ Exists only during query execution


# =========================
# 🔹 Syntax
# =========================

WITH cte_name AS (
    SELECT column
    FROM table
)
SELECT *
FROM cte_name;


# =========================
# Example
# =========================

| order_id | customer_id | product_id | sales |
| -------- | ----------- | ---------- | ----- |
| 1        | 101         | 201        | 50    |
| 2        | 101         | 202        | 70    |
| 3        | 102         | 201        | 30    |
| 4        | 102         | 203        | 90    |
| 5        | 103         | 202        | 50    |


# 🔥 Query: Total Sales per Customer using CTE

WITH sales_cte AS (
    SELECT customer_id, SUM(sales) AS total_sales
    FROM orders
    GROUP BY customer_id
)
SELECT *
FROM sales_cte;


# =========================
# Output
# =========================

| customer_id | total_sales |
|-------------|-------------|
| 101         | 120         |
| 102         | 120         |
| 103         | 50          |


# =========================
# 🔹 Use-Cases
# =========================

# 1. 🎯 Improve Readability
WITH temp AS (
    SELECT customer_id, SUM(sales) total_sales
    FROM orders
    GROUP BY customer_id
)
SELECT *
FROM temp
WHERE total_sales > 100;


# 2. 🎯 Use Multiple Times (Reusable)
WITH temp AS (
    SELECT customer_id, SUM(sales) total_sales
    FROM orders
    GROUP BY customer_id
)
SELECT *
FROM temp
WHERE total_sales > 50;


# 3. 🎯 Use with Window Function
WITH temp AS (
    SELECT customer_id, SUM(sales) total_sales
    FROM orders
    GROUP BY customer_id
)
SELECT *,
       RANK() OVER (ORDER BY total_sales DESC) AS rnk
FROM temp;



-- =========================
-- 🔥 Advantages of CTE (Common Table Expression)
-- =========================

👉 CTEs are used to simplify complex SQL queries.

✔ Makes SQL more readable
✔ Helps break queries into steps
✔ Reusable within the same query
✔ Supports recursion
✔ Better debugging


-- =========================
-- 🔹 Advantages
-- =========================

-- 1. 🎯 Improves Readability
-- Break complex queries into smaller logical parts

WITH temp AS (
    SELECT customer_id, SUM(sales) total_sales
    FROM orders
    GROUP BY customer_id
)
SELECT *
FROM temp;


-- 2. 🎯 Step-by-Step Query Writing
-- Makes query easier to understand

WITH step1 AS (
    SELECT * FROM orders WHERE sales > 50
),
step2 AS (
    SELECT customer_id, SUM(sales) total_sales
    FROM step1
    GROUP BY customer_id
)
SELECT * FROM step2;


-- 3. 🎯 Reusability (within query)
-- Same CTE can be used multiple times

WITH temp AS (
    SELECT customer_id, SUM(sales) total_sales
    FROM orders
    GROUP BY customer_id
)
SELECT *
FROM temp
WHERE total_sales > 100;


-- 4. 🎯 Supports Recursion 🔥
-- Useful for hierarchical data

WITH RECURSIVE numbers AS (
    SELECT 1 AS n
    UNION ALL
    SELECT n + 1
    FROM numbers
    WHERE n < 5
)
SELECT * FROM numbers;


-- 5. 🎯 Better Alternative to Subqueries
-- Cleaner than nested subqueries

WITH temp AS (
    SELECT customer_id, SUM(sales) total_sales
    FROM orders
    GROUP BY customer_id
)
SELECT *
FROM temp;


-- 6. 🎯 Easier Debugging
-- You can test each step separately

WITH temp AS (
    SELECT * FROM orders
)
SELECT * FROM temp;


-- =========================
-- ❗ Important Notes
-- =========================

👉 Exists only during query execution  
👉 Not stored permanently  
👉 Improves maintainability  


-- =========================
-- 🎯 Interview One-Liner
-- =========================

👉 CTE improves readability, supports recursion, 
and helps break complex queries into simpler steps.





# =========================
# 🔥 Recursive CTE (Important)
# =========================

👉 Used for hierarchical data

WITH RECURSIVE numbers AS (
    SELECT 1 AS n
    UNION ALL
    SELECT n + 1
    FROM numbers
    WHERE n < 5
)
SELECT * FROM numbers;


# =========================
# Output (Recursive)
# =========================

| n |
|---|
| 1 |
| 2 |
| 3 |
| 4 |
| 5 |


# =========================
# ❗ Important Notes
# =========================

👉 CTE is not stored permanently  
👉 Must be defined before main query  
👉 Can replace subqueries for better readability  


# =========================
# 🎯 Interview One-Liner
# =========================

👉 A CTE is a temporary named result set defined using WITH
 clause to simplify complex queries.





 -- =========================
-- 🔥 Standalone CTE
-- =========================

👉 A Standalone CTE is a simple CTE used once in a query.

✔ Defined and Used independently
✔ Runs independently as it self-contained
✔ Does not rely on other CTEs or main query
✔ Defined using WITH clause  
✔ Used immediately in SELECT  
✔ Improves readability  
❗ Cannot exist without main query  


-- =========================
-- 🔹 Syntax
-- =========================

WITH cte_name AS (
    SELECT column
    FROM table
)
SELECT *
FROM cte_name;


-- =========================
-- Example
-- =========================

| order_id | customer_id | product_id | sales |
| -------- | ----------- | ---------- | ----- |
| 1        | 101         | 201        | 50    |
| 2        | 101         | 202        | 70    |
| 3        | 102         | 201        | 30    |
| 4        | 102         | 203        | 90    |
| 5        | 103         | 202        | 50    |


-- 🔥 Query: Total Sales per Customer
WITH sales_cte AS (
    SELECT customer_id, SUM(sales) AS total_sales
    FROM orders
    GROUP BY customer_id
)
SELECT *
FROM sales_cte;


-- =========================
-- Output
-- =========================

| customer_id | total_sales |
|-------------|-------------|
| 101         | 120         |
| 102         | 120         |
| 103         | 50          |


-- =========================
-- 🔹 Use-Cases
-- =========================

-- 1. 🎯 Filter Aggregated Data
WITH temp AS (
    SELECT customer_id, SUM(sales) total_sales
    FROM orders
    GROUP BY customer_id
)
SELECT *
FROM temp
WHERE total_sales > 100;


-- 2. 🎯 Simplify Query
WITH temp AS (
    SELECT *
    FROM orders
    WHERE sales > 50
)
SELECT *
FROM temp;


-- 3. 🎯 Use with Window Function
WITH temp AS (
    SELECT customer_id, SUM(sales) total_sales
    FROM orders
    GROUP BY customer_id
)
SELECT *,
       RANK() OVER (ORDER BY total_sales DESC) AS rnk
FROM temp;


-- =========================
-- ❗ Important Notes
-- =========================

👉 Used only once in the query  
👉 Exists only during execution  
👉 Cannot be reused outside  
👉 Better than subquery for readability  


-- =========================
-- 🎯 Interview One-Liner
-- =========================

👉 A standalone CTE is a temporary named result set 
 used once within a query to make SQL more readable.






-- ================================
-- 🔥 Multiple CTEs (Chaining CTEs)
-- ================================

👉 Multiple CTEs are defined together using WITH and separated by commas.

✔ Each CTE can use previous CTE
✔ Improves readability of complex logic
✔ Executes in sequence (top → bottom)
❗ Must be followed by a main query


-- =========================
-- 🔹 Syntax
-- =========================

WITH cte1 AS (
    SELECT ...
),
cte2 AS (
    SELECT ...
    FROM cte1
),
cte3 AS (
    SELECT ...
    FROM cte2
)
SELECT *
FROM cte3;


-- =========================
-- Example
-- =========================

| order_id | customer_id | product_id | sales |
| -------- | ----------- | ---------- | ----- |
| 1        | 101         | 201        | 50    |
| 2        | 101         | 202        | 70    |
| 3        | 102         | 201        | 30    |
| 4        | 102         | 203        | 90    |
| 5        | 103         | 202        | 50    |


-- 🔥 Step-by-Step Query using Multiple CTEs

WITH total_sales AS (
    -- Step 1: Calculate total sales per customer
    SELECT customer_id, SUM(sales) AS total_sales
    FROM orders
    GROUP BY customer_id
),

ranked_sales AS (
    -- Step 2: Rank customers based on total sales
    SELECT *,
           RANK() OVER (ORDER BY total_sales DESC) AS rnk
    FROM total_sales
),

filtered AS (
    -- Step 3: Filter top customers
    SELECT *
    FROM ranked_sales
    WHERE rnk <= 2
)

-- Final Output
SELECT *
FROM filtered;


-- =========================
-- Output
-- =========================

| customer_id | total_sales | rnk |
|-------------|-------------|-----|
| 101         | 120         | 1   |
| 102         | 120         | 1   |


-- =========================
-- 🔹 Use-Cases
-- =========================

-- 1. 🎯 Break Complex Logic
WITH step1 AS (
    SELECT * FROM orders WHERE sales > 30
),
step2 AS (
    SELECT customer_id, SUM(sales) total_sales
    FROM step1
    GROUP BY customer_id
)
SELECT * FROM step2;


-- 2. 🎯 Sequential Data Processing
WITH a AS (
    SELECT * FROM orders
),
b AS (
    SELECT * FROM a WHERE sales > 50
),
c AS (
    SELECT customer_id, COUNT(*) cnt FROM b GROUP BY customer_id
)
SELECT * FROM c;


-- 3. 🎯 Use with Window Functions
WITH base AS (
    SELECT customer_id, SUM(sales) total_sales
    FROM orders
    GROUP BY customer_id
),
ranked AS (
    SELECT *,
           ROW_NUMBER() OVER (ORDER BY total_sales DESC) rn
    FROM base
)
SELECT * FROM ranked;


-- =========================
-- ❗ Important Notes
-- =========================

👉 Defined in a single WITH clause  
👉 Separated by commas  
👉 Can reference previous CTEs only (not forward)  
👉 Improves debugging and readability  


-- =========================
-- 🎯 Interview One-Liner
-- =========================

👉 Multiple CTEs allow breaking complex queries into 
step-by-step logical blocks for better readability and maintainability.






-- =========================
-- 🔥 Nested CTEs
-- =========================

👉 Nested CTE means defining a CTE inside another CTE.

✔ Used to build multi-level logic
✔ Helps in complex transformations
✔ Inner CTE runs first, then outer
❗ Not all SQL databases support true nesting (PostgreSQL ❌)
❗ Prefer Multiple CTEs (chaining) instead


-- =========================
-- 🔹 Syntax
-- =========================

WITH CTE-Name1 AS
(
    SELECT ....
    FROM ....
    WHERE ...
)
, CTE-Name2 AS
(
    SELECT ...
    FROM CTE-Name1
    WHERE ...
)
SELECT ...
FROM CTE-Name2
WHERE ...;


-- =========================
-- Example
-- =========================

| order_id | customer_id | product_id | sales |
| -------- | ----------- | ---------- | ----- |
| 1        | 101         | 201        | 50    |
| 2        | 101         | 202        | 70    |
| 3        | 102         | 201        | 30    |
| 4        | 102         | 203        | 90    |
| 5        | 103         | 202        | 50    |


-- 🔥 Query using Nested CTE

WITH total_sales AS (
    SELECT customer_id, SUM(sales) AS total_sales
    FROM orders
    GROUP BY customer_id
),
ranked_sales AS (
    SELECT *,
           RANK() OVER (ORDER BY total_sales DESC) AS rnk
    FROM total_sales
)
SELECT *
FROM ranked_sales
WHERE rnk <= 2;


-- =========================
-- Output
-- =========================

| customer_id | total_sales | rnk |
|-------------|-------------|-----|
| 101         | 120         | 1   |
| 102         | 120         | 1   |


-- =========================
-- 🔹 Better Alternative (Recommended ✅)
-- =========================

👉 Use Multiple CTEs instead of nesting

WITH inner_cte AS (
    SELECT customer_id, SUM(sales) AS total_sales
    FROM orders
    GROUP BY customer_id
),
outer_cte AS (
    SELECT *,
           RANK() OVER (ORDER BY total_sales DESC) AS rnk
    FROM inner_cte
)
SELECT *
FROM outer_cte
WHERE rnk <= 2;


-- =========================
-- 🔹 Use-Cases
-- =========================

-- 1. 🎯 Multi-step transformations
-- 2. 🎯 Layered aggregations
-- 3. 🎯 Complex reporting queries


-- =========================
-- ❗ Important Notes
-- =========================

👉 Not supported in PostgreSQL ❗  
👉 Harder to read and debug  
👉 Prefer chained CTEs (cleaner approach)  


-- =========================
-- 🎯 Interview One-Liner
-- =========================

👉 Nested CTEs define a CTE inside another CTE, but are 
rarely used due to limited support and readability issues.






-- =========================
-- 🔥 Recursive CTE
-- =========================

👉 A Recursive CTE is a CTE that references itself.

✔ Used for hierarchical & iterative problems
✔ Executes repeatedly until condition is met
✔ Has two parts:
   1. Anchor Query (base case)
   2. Recursive Query (repeating part)
❗ Must use UNION ALL


-- =========================
-- 🔹 Syntax
-- =========================

WITH RECURSIVE cte_name AS (

    -- Anchor Query
    SELECT column
    FROM table
    WHERE condition

    UNION ALL

    -- Recursive Query
    SELECT column
    FROM table t
    JOIN cte_name c
    ON condition
)
SELECT *
FROM cte_name;


-- =========================
-- 🔥 Example 1: Generate Numbers (1 to 5)
-- =========================

WITH RECURSIVE numbers AS (

    -- Anchor
    SELECT 1 AS n

    UNION ALL

    -- Recursive
    SELECT n + 1
    FROM numbers
    WHERE n < 5
)
SELECT * FROM numbers;


-- =========================
-- Output
-- =========================

| n |
|---|
| 1 |
| 2 |
| 3 |
| 4 |
| 5 |


-- =========================
-- 🔥 Example 2: Factorial (Advanced 🔥)
-- =========================

WITH RECURSIVE fact AS (

    -- Anchor
    SELECT 1 AS n, 1 AS factorial

    UNION ALL

    -- Recursive
    SELECT n + 1,
           factorial * (n + 1)
    FROM fact
    WHERE n < 5
)
SELECT * FROM fact;


-- =========================
-- Output
-- =========================

| n | factorial |
|---|-----------|
| 1 | 1         |
| 2 | 2         |
| 3 | 6         |
| 4 | 24        |
| 5 | 120       |


-- =========================
-- 🔥 Example 3: Employee Hierarchy
-- =========================

| emp_id | manager_id | name  |
|--------|------------|-------|
| 1      | NULL       | CEO   |
| 2      | 1          | A     |
| 3      | 1          | B     |
| 4      | 2          | C     |
| 5      | 2          | D     |


WITH RECURSIVE emp_tree AS (

    -- Anchor (Top Level)
    SELECT emp_id, manager_id, name, 1 AS level
    FROM employees
    WHERE manager_id IS NULL

    UNION ALL

    -- Recursive (Find children)
    SELECT e.emp_id, e.manager_id, e.name, et.level + 1
    FROM employees e
    JOIN emp_tree et
    ON e.manager_id = et.emp_id
)
SELECT * FROM emp_tree;


-- =========================
-- Output
-- =========================

| emp_id | manager_id | name | level |
|--------|------------|------|-------|
| 1      | NULL       | CEO  | 1     |
| 2      | 1          | A    | 2     |
| 3      | 1          | B    | 2     |
| 4      | 2          | C    | 3     |
| 5      | 2          | D    | 3     |


-- =========================
-- 🔹 Use-Cases
-- =========================

-- 1. 🎯 Organizational hierarchy
-- 2. 🎯 Tree / Graph traversal
-- 3. 🎯 Generate sequences (numbers, dates)
-- 4. 🎯 Mathematical problems (factorial, Fibonacci)


-- =========================
-- ❗ Important Notes
-- =========================

👉 Always use UNION ALL  
👉 Must include stopping condition (else infinite loop 💀)  
👉 Anchor runs once, recursive runs multiple times  


-- =========================
-- 🎯 Interview One-Liner
-- =========================

👉 A recursive CTE repeatedly references itself to 
solve hierarchical or iterative problems in SQL.