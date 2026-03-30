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



-- =========================
-- 🔥 Subquery in SELECT Clause
-- =========================

👉 Used to aggregate data side by side with the main querys data ,
 allowing for direct comparison. 

✔ Returns a single value for each row
✔ Executed along with the SELECT statement
✔ Can be used to show computed values
❗ Must return only ONE value (else error)


-- 🔹 Syntax
SELECT column,
       (SELECT aggregate_function(column)
        FROM table) AS alias_name
FROM table;


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


-- 🔥 Query: Show Each Order with Average Sales
SELECT order_id, sales,
       (SELECT AVG(sales) FROM orders) AS avg_sales
FROM orders;


-- =========================
-- Output
-- =========================

| order_id | sales | avg_sales |
|----------|-------|-----------|
| 1        | 50    | 58        |
| 2        | 70    | 58        |
| 3        | 30    | 58        |
| 4        | 90    | 58        |
| 5        | 50    | 58        |


-- =========================
-- 🔹 Use-Cases
-- =========================

-- 1. 🎯 Compare Each Row with Overall Value
SELECT order_id, sales,
       (SELECT MAX(sales) FROM orders) AS max_sales
FROM orders;


-- 2. 🎯 Show Difference from Average
SELECT order_id, sales,
       sales - (SELECT AVG(sales) FROM orders) AS diff_from_avg
FROM orders;


-- 3. 🎯 Correlated Subquery in SELECT 🔥
SELECT order_id, customer_id, sales,
       (SELECT AVG(sales)
        FROM orders o2
        WHERE o2.customer_id = o1.customer_id) AS avg_customer_sales
FROM orders o1;


-- =========================
-- 🎯 Interview One-Liner
-- =========================

👉 A subquery in the SELECT clause returns a single value per row and
 is used for inline calculations.



 -- =========================
-- 🔥 Subquery with JOIN Clause
-- =========================

👉 A subquery can be used with JOIN by first creating a derived table 
and then joining it with another table.

✔ Subquery runs first and creates a temporary table
✔ JOIN is applied on that result
✔ Helps combine aggregated + detailed data
❗ Alias is mandatory


-- 🔹 Syntax
SELECT columns
FROM table1 t1
JOIN (
    SELECT column, aggregate_function(column) AS alias
    FROM table
    GROUP BY column
) t2
ON t1.column = t2.column;


-- =========================
-- Example
-- =========================

-- Orders Table
| order_id | customer_id | product_id | sales |
| -------- | ----------- | ---------- | ----- |
| 1        | 101         | 201        | 50    |
| 2        | 101         | 202        | 70    |
| 3        | 102         | 201        | 30    |
| 4        | 102         | 203        | 90    |
| 5        | 103         | 202        | 50    |

-- Customers Table
| customer_id | customer_name |
|-------------|---------------|
| 101         | A             |
| 102         | B             |
| 103         | C             |


-- 🔥 Query: Join Total Sales with Customer Name
SELECT c.customer_name, t.total_sales
FROM customers c
JOIN (
    SELECT customer_id, SUM(sales) AS total_sales
    FROM orders
    GROUP BY customer_id
) t
ON c.customer_id = t.customer_id;


-- =========================
-- Output
-- =========================

| customer_name | total_sales |
|---------------|-------------|
| A             | 120         |
| B             | 120         |
| C             | 50          |


-- =========================
-- 🔹 Use-Cases
-- =========================

-- 1. 🎯 Combine Aggregated + Detailed Data
SELECT o.order_id, o.customer_id, t.total_sales
FROM orders o
JOIN (
    SELECT customer_id, SUM(sales) AS total_sales
    FROM orders
    GROUP BY customer_id
) t
ON o.customer_id = t.customer_id;


-- 2. 🎯 Filter Top Customers
SELECT c.customer_name, t.total_sales
FROM customers c
JOIN (
    SELECT customer_id, SUM(sales) AS total_sales
    FROM orders
    GROUP BY customer_id
) t
ON c.customer_id = t.customer_id
WHERE t.total_sales > 100;


-- 3. 🎯 Use with Window Function
SELECT *,
       RANK() OVER (ORDER BY total_sales DESC) AS rnk
FROM (
    SELECT customer_id, SUM(sales) AS total_sales
    FROM orders
    GROUP BY customer_id
) t;


-- =========================
-- 🎯 Interview One-Liner
-- =========================

👉 A subquery with JOIN creates a temporary aggregated result 
and joins it with another table for advanced analysis.





-- =========================
-- 🔥 Subquery in WHERE Clause
-- =========================

👉 A subquery in the WHERE clause is used to filter rows 
based on the result of another query.

✔ Inner query runs first
✔ Output is used in WHERE condition
✔ Can return single or multiple values
❗ Most commonly used type of subquery


-- 🔹 Syntax
SELECT columns
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


-- 🔥 Query 1: Find Orders with Max Sales
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
-- 🔹 Use-Cases
-- =========================

-- 1. 🎯 Compare with Average
SELECT *
FROM orders
WHERE sales > (
    SELECT AVG(sales)
    FROM orders
);


-- 2. 🎯 Multiple Row Subquery (IN)
SELECT *
FROM orders
WHERE product_id IN (
    SELECT product_id
    FROM orders
    WHERE sales > 50
);


-- 3. 🎯 Using EXISTS 🔥
SELECT *
FROM orders o
WHERE EXISTS (
    SELECT 1
    FROM orders o2
    WHERE o.customer_id = o2.customer_id
    AND o2.sales > 80
);


-- 4. 🎯 Correlated Subquery
SELECT *
FROM orders o
WHERE sales > (
    SELECT AVG(sales)
    FROM orders
    WHERE customer_id = o.customer_id
);

-- =========================
-- 🎯 Interview One-Liner
-- =========================

👉 A WHERE clause subquery filters rows based on the result 
of another query.





-- =========================
-- 🔥 IN Operator
-- =========================

👉 IN operator is used to match a value against a list or subquery result.

✔ Works like multiple OR conditions
✔ Used with subqueries or fixed values
✔ Improves readability
❗ Used for multiple values


-- 🔹 Syntax
SELECT columns
FROM table
WHERE column IN (value1, value2, value3);


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


-- 🔥 Query 1: Using Fixed Values
SELECT *
FROM orders
WHERE product_id IN (201, 202);


-- =========================
-- Output
-- =========================

| order_id | product_id |
|----------|------------|
| 1        | 201        |
| 2        | 202        |
| 3        | 201        |
| 5        | 202        |


-- =========================
-- 🔹 Use-Cases
-- =========================

-- 1. 🎯 With Subquery
SELECT *
FROM orders
WHERE customer_id IN (
    SELECT customer_id
    FROM orders
    WHERE sales > 60
);


-- 2. 🎯 Replace Multiple OR Conditions
SELECT *
FROM orders
WHERE product_id = 201
   OR product_id = 202;


-- same as 👇
SELECT *
FROM orders
WHERE product_id IN (201, 202);


-- 3. 🎯 Filter Specific Group
SELECT *
FROM orders
WHERE customer_id IN (101, 103);


-- =========================
-- ❗ Important Notes
-- =========================

👉 IN is best for SMALL datasets
👉 For large data → use EXISTS (better performance)
👉 Works with subqueries returning multiple rows


-- =========================
-- 🎯 Interview One-Liner
-- =========================

👉 IN operator checks if a value exists in a list or subquery result.




-- =========================
-- 🔥 ANY & ALL Operators
-- =========================

👉 ANY and ALL are used with subqueries to compare a value 
with a set of values returned by the subquery.

✔ Used in WHERE clause
✔ Works with comparison operators (=, >, <, >=, <=)
❗ Must be used with a subquery


-- 🔹 Syntax

-- ANY (at least one condition true)
SELECT columns
FROM table
WHERE column operator ANY (
    SELECT column
    FROM table
);

-- ALL (all conditions must be true)
SELECT columns
FROM table
WHERE column operator ALL (
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


-- =========================
-- 🔥 ANY Operator
-- =========================

👉 Condition is TRUE if it matches ANY one value

-- Query: Find orders with sales greater than ANY sales of customer 101
SELECT *
FROM orders
WHERE sales > ANY (
    SELECT sales
    FROM orders
    WHERE customer_id = 101
);

-- 👉 customer 101 sales = (50, 70)
-- 👉 ANY means > 50 OR > 70


-- =========================
-- 🔥 ALL Operator
-- =========================

👉 Condition is TRUE only if it matches ALL values

-- Query: Find orders with sales greater than ALL sales of customer 101
SELECT *
FROM orders
WHERE sales > ALL (
    SELECT sales
    FROM orders
    WHERE customer_id = 101
);

-- 👉 customer 101 sales = (50, 70)
-- 👉 ALL means > 50 AND > 70 → must be > 70


-- =========================
-- 🔹 Use-Cases
-- =========================

-- 1. 🎯 ANY → Compare with at least one value
SELECT *
FROM orders
WHERE sales < ANY (
    SELECT sales FROM orders WHERE customer_id = 102
);


-- 2. 🎯 ALL → Compare with entire group
SELECT *
FROM orders
WHERE sales > ALL (
    SELECT sales FROM orders WHERE customer_id = 102
);


-- 3. 🎯 Find Minimum using ALL
SELECT *
FROM orders
WHERE sales <= ALL (
    SELECT sales FROM orders
);


-- =========================
-- ❗ Key Difference
-- =========================

👉 ANY  → OR condition (at least one match)
👉 ALL  → AND condition (must satisfy all)


-- =========================
-- 🎯 Interview One-Liner
-- =========================

👉 ANY checks if condition is true for at least one value, while ALL 
checks if it is true for all values.




-- =========================
-- 🔥 EXISTS Operator
-- =========================

👉 EXISTS is used to check whether a subquery returns any rows.

✔ Returns TRUE if subquery returns at least one row
✔ Stops execution as soon as a match is found (fast 🚀)
✔ Mostly used with correlated subqueries
❗ Does NOT return actual data, only checks existence


-- 🔹 Syntax
SELECT columns
FROM table t1
WHERE EXISTS (
    SELECT 1
    FROM table t2
    WHERE t1.column = t2.column
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


-- =========================
-- 🔥 Query: Customers having high sales (>80)
SELECT *
FROM orders o
WHERE EXISTS (
    SELECT 1
    FROM orders o2
    WHERE o.customer_id = o2.customer_id
      AND o2.sales > 80
);


-- =========================
-- Output
-- =========================

| order_id | customer_id | sales |
|----------|-------------|-------|
| 4        | 102         | 90    |

👉 Only customer 102 has a sale > 80


-- =========================
-- 🔹 Use-Cases
-- =========================

-- 1. 🎯 Check Existence (Better than IN for large data)
SELECT *
FROM orders o
WHERE EXISTS (
    SELECT 1
    FROM orders o2
    WHERE o.customer_id = o2.customer_id
);


-- 2. 🎯 Filter Based on Related Table
SELECT *
FROM customers c
WHERE EXISTS (
    SELECT 1
    FROM orders o
    WHERE c.customer_id = o.customer_id
);


-- 3. 🎯 NOT EXISTS (Important 🔥)
SELECT *
FROM customers c
WHERE NOT EXISTS (
    SELECT 1
    FROM orders o
    WHERE c.customer_id = o.customer_id
);


-- =========================
-- ❗ Important Notes
-- =========================

👉 EXISTS is faster than IN for large datasets
👉 Stops execution once it finds a match
👉 Usually used with correlated subqueries


-- =========================
-- 🎯 Interview One-Liner
-- =========================

👉 EXISTS checks whether a subquery returns any rows and returns
 TRUE if it does.