-- =========================
-- 🔥 Subquery
-- =========================

👉 A Subquery is a query written inside another SQL query.

✔ Inner query executes first
✔ Output is used by outer query
✔ Can be used in SELECT, WHERE, FROM
❗ Can return single or multiple rows


-- 🔹 Syntax
SELECT column
FROM table
WHERE column operator (
    SELECT column
    FROM table
);


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


-- 🔥 Query: Find Highest Sales
SELECT *
FROM orders
WHERE sales = (
    SELECT MAX(sales)
    FROM orders
);


-- =========================
-- Output
-- =========================

| order_id | sales |
|----------|-------|
| 4        | 90    |


-- =========================
-- 🔹 Types of Subqueries
-- =========================

-- 1. Single Row Subquery
SELECT *
FROM orders
WHERE sales > (
    SELECT AVG(sales) FROM orders
);


-- 2. Multiple Row Subquery
SELECT *
FROM orders
WHERE product_id IN (
    SELECT product_id FROM orders
);


-- 3. Correlated Subquery
SELECT *
FROM orders o
WHERE sales > (
    SELECT AVG(sales)
    FROM orders
    WHERE customer_id = o.customer_id
);


-- 4. Subquery in FROM (Derived Table)
SELECT *
FROM (
    SELECT customer_id, SUM(sales) total
    FROM orders
    GROUP BY customer_id
) t;


-- =========================
-- 🔹 Use-Cases
-- =========================

-- 1. Find Highest / Lowest Value
SELECT *
FROM orders
WHERE sales = (SELECT MAX(sales) FROM orders);


-- 2. Compare with Average
SELECT *
FROM orders
WHERE sales > (SELECT AVG(sales) FROM orders);


-- 3. Find Customers with High Sales
SELECT *
FROM orders
WHERE customer_id IN (
    SELECT customer_id
    FROM orders
    GROUP BY customer_id
    HAVING SUM(sales) > 100
);


-- 4. Subquery in SELECT
SELECT order_id,
       (SELECT AVG(sales) FROM orders) AS avg_sales
FROM orders;



-- =========================
-- 🔥 Subquery in FROM Clause (Derived Table)
-- =========================

👉 A subquery in the FROM clause is called a Derived Table.

✔ It acts like a temporary table
✔ Outer query works on its result
✔ Must have an alias ❗


-- 🔹 Syntax
SELECT *
FROM (
    SELECT column, aggregate_function(column)
    FROM table
    GROUP BY column
) alias_name;


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


-- 🔥 Query: Total Sales per Customer (Using Derived Table)
SELECT *
FROM (
    SELECT customer_id, SUM(sales) AS total_sales
    FROM orders
    GROUP BY customer_id
) t;


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

-- 1. 🎯 Filter Aggregated Results
SELECT *
FROM (
    SELECT customer_id, SUM(sales) AS total_sales
    FROM orders
    GROUP BY customer_id
) t
WHERE total_sales > 100;


-- 2. 🎯 Use with JOIN
SELECT t.customer_id, t.total_sales, c.customer_name
FROM (
    SELECT customer_id, SUM(sales) AS total_sales
    FROM orders
    GROUP BY customer_id
) t
JOIN customers c
ON t.customer_id = c.customer_id;


-- 3. 🎯 Apply Ranking on Aggregated Data
SELECT *,
       RANK() OVER (ORDER BY total_sales DESC) AS rnk
FROM (
    SELECT customer_id, SUM(sales) AS total_sales
    FROM orders
    GROUP BY customer_id
) t;

--4 . FInd the products that have a price higher than the average 
price of all products

SELECT product_id
FROM products
WHERE price > (
    SELECT AVG(price) over() Avg_price
    FROM products
)t 

-- 5.Rank Customers based on their total amount of sales using subquries

SELECT * ,
FROM (
    SELECT customer_id, SUM(sales) AS total_sales,
           RANK() OVER (ORDER BY SUM(sales) DESC) AS rnk
    FROM orders
    GROUP BY customer_id
) t

OR

SELECT * , 
RANK() OVER (ORDER BY Toyal_Slaes DESC) CustomerRank
FROM (
    SELECT customer_id, SUM(sales) AS total_sales
    FROM orders
    GROUP BY customer_id
) t

-- =========================
-- 🎯 Interview One-Liner
-- =========================

👉 A subquery in the FROM clause creates a temporary result 
set (derived table) that can be queried like a normal table.


