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






-- =========================
-- 🔥 Multiple CTEs (Chaining CTEs)
-- =========================

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