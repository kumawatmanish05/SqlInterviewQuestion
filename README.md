# SQL Interview Question
# =========================
# 🔥 SQL Execution Order
# =========================

👉 SQL queries are NOT executed in the same order as written.

❗ Actual execution follows a specific logical order


# =========================
# 🔹 Execution Order
# =========================

1. FROM
   👉 Selects the table(s)

2. JOIN
   👉 Combines tables

3. ON
   👉 Applies join conditions

4. WHERE
   👉 Filters rows (before grouping)

5. GROUP BY
   👉 Groups rows

6. HAVING
   👉 Filters grouped data

7. SELECT
   👉 Selects columns / expressions

8. DISTINCT
   👉 Removes duplicates

9. WINDOW FUNCTIONS
   👉 Applies functions like RANK(), ROW_NUMBER()

10. ORDER BY
    👉 Sorts the result

11. LIMIT / OFFSET
    👉 Restricts number of rows


# =========================
# 🔥 Example Query
# =========================

SELECT customer_id, SUM(sales) AS total_sales
FROM orders
WHERE sales > 50
GROUP BY customer_id
HAVING SUM(sales) > 100
ORDER BY total_sales DESC
LIMIT 5;


# =========================
# 🔥 Execution Flow (Step-by-Step)
# =========================

👉 Step 1: FROM orders  
👉 Step 2: WHERE sales > 50  
👉 Step 3: GROUP BY customer_id  
👉 Step 4: HAVING SUM(sales) > 100  
👉 Step 5: SELECT customer_id, SUM(sales)  
👉 Step 6: ORDER BY total_sales DESC  
👉 Step 7: LIMIT 5  


# =========================
# 🎯 Interview Trick
# =========================

❗ WHERE cannot use aggregate functions  
✔ Because GROUP BY happens AFTER WHERE  

❗ HAVING is used for aggregates  
✔ Because it runs AFTER GROUP BY  


# =========================
# 🎯 One-Liner
# =========================

👉 SQL executes queries in a logical order starting from FROM → WHERE → GROUP BY → HAVING → SELECT → ORDER BY → LIMIT.In this Series I have Practiced Daily SQL Interview Questions 







# =========================
# 🔥 CTE vs Subquery vs Temp Table
# =========================

👉 All three are used to create intermediate result sets in SQL.

✔ Used to simplify complex queries
✔ Help in breaking down logic
❗ Difference is in scope, performance & usability


# =========================
# 🔹 1. CTE (Common Table Expression)
# =========================

👉 Defined using WITH clause

✔ Improves readability
✔ Can be reused in same query
✔ Supports recursion
❗ Exists only during query execution

WITH temp AS (
    SELECT customer_id, SUM(sales) total_sales
    FROM orders
    GROUP BY customer_id
)
SELECT * FROM temp;


# =========================
# 🔹 2. Subquery
# =========================

👉 Query inside another query

✔ Simple and easy to write
✔ Used in SELECT, WHERE, FROM
❗ Hard to read when nested deeply
❗ Cannot be reused easily

SELECT *
FROM (
    SELECT customer_id, SUM(sales) total_sales
    FROM orders
    GROUP BY customer_id
) t;


# =========================
# 🔹 3. Temp Table
# =========================

👉 Temporary table stored in database

✔ Can be reused multiple times
✔ Good for large data
✔ Improves performance in complex queries
❗ Requires CREATE TABLE permission

CREATE TEMP TABLE temp_sales AS
SELECT customer_id, SUM(sales) total_sales
FROM orders
GROUP BY customer_id;

SELECT * FROM temp_sales;


# =========================
# 🔥 Key Differences
# =========================

| Feature        | CTE             | Subquery        | Temp Table        |
|----------------|-----------------|-----------------|-------------------|
| Readability    | High ✅          | Medium ⚠️       | High ✅           |
| Reusability    | Limited         | No ❌           | Yes ✅            |
| Performance    | Medium          | Low (nested)    | High (large data) |
| Storage        | No              | No              | Yes (temporary)   |
| Recursion      | Yes ✅          | No ❌           | No ❌             |
| Scope          | Single Query    | Single Query    | Session-based     |


# =========================
# 🔹 When to Use What?
# =========================

👉 Use CTE:
✔ When query is complex
✔ When readability matters
✔ When recursion is needed

👉 Use Subquery:
✔ For simple filtering
✔ Small queries

👉 Use Temp Table:
✔ Large datasets
✔ Multiple reuse
✔ Performance optimization


# =========================
# 🎯 Interview One-Liner
# =========================

👉 CTE improves readability, subquery is for quick logic, and temp table is best for handling large reusable datasets.