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

👉 A CTE is a temporary named result set defined using WITH clause to simplify complex queries.