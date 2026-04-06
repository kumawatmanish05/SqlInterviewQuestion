-- =========================
-- 🔥 VIEWS IN SQL
-- =========================

👉 A VIEW is a virtual table based on a SQL query.

✔ It does NOT store data physically  
✔ It stores only the query  
✔ Data is fetched from base table(s) when view is used  


-- =========================
-- 🔹 Syntax
-- =========================

CREATE VIEW view_name AS
SELECT column1, column2
FROM table_name
WHERE condition;


-- =========================
-- 🔥 Example
-- =========================

-- Create a view for high salary employees

CREATE VIEW high_salary_emp AS
SELECT emp_id, name, dept_id, salary
FROM employees
WHERE salary > 50000;


-- Use the view

SELECT * FROM high_salary_emp;


-- =========================
-- 🔥 Update View
-- =========================

CREATE OR REPLACE VIEW high_salary_emp AS
SELECT emp_id, name, salary
FROM employees
WHERE salary > 60000;


-- =========================
-- 🔥 Drop View
-- =========================

DROP VIEW high_salary_emp;


-- =========================
-- 🔹 Types of Views
-- =========================

-- 1. Simple View
-- Based on single table

-- 2. Complex View
-- Based on multiple tables / joins / aggregations


-- =========================
-- 🔥 Use-Cases
-- =========================

-- 1. 🎯 Data Security
-- Hide sensitive columns

CREATE VIEW emp_public AS
SELECT emp_id, name, dept_id
FROM employees;

-- 2. 🎯 Simplify Complex Queries
-- Reuse joins / filters

-- 3. 🎯 Reusability
-- Write once, use many times

-- 4. 🎯 Data Abstraction
-- Hide table complexity


-- =========================
-- ⚠️ Limitations
-- =========================

-- ❗ Cannot always update (especially with GROUP BY, JOIN)
-- ❗ Depends on base table
-- ❗ Performance can be slower (complex queries)


-- =========================
-- 🎯 Interview One-Liner
-- =========================

👉 A VIEW is a virtual table that stores a query, not actual data.





-- =========================
-- 🔥CENTRAL QUERY LOGIC (VIEWS)
-- =========================

👉 Central Query Logic means:
✔ Write complex query once  
✔ Reuse it everywhere  
✔ Avoid duplication  
✔ Easy maintenance  


-- =========================
-- 🔹 Problem Without View
-- =========================

-- Same complex query used multiple times ❗

SELECT emp_id, name, dept_id, salary
FROM employees
WHERE salary > 50000;

-- Used again in another query

SELECT dept_id, COUNT(*)
FROM employees
WHERE salary > 50000
GROUP BY dept_id;

-- ❗ Problem:
-- If condition changes → update everywhere ❌


-- =========================
-- 🔥 Solution Using VIEW
-- =========================

CREATE VIEW high_salary_emp AS
SELECT emp_id, name, dept_id, salary
FROM employees
WHERE salary > 50000;


-- =========================
-- 🔹 Reuse View Anywhere
-- =========================

-- Query 1
SELECT * FROM high_salary_emp;

-- Query 2
SELECT dept_id, COUNT(*)
FROM high_salary_emp
GROUP BY dept_id;


-- =========================
-- 🔥 Change Logic in One Place
-- =========================

-- Update condition once

CREATE OR REPLACE VIEW high_salary_emp AS
SELECT emp_id, name, dept_id, salary
FROM employees
WHERE salary > 60000;


-- ✔ Automatically reflected everywhere


-- =========================
-- 🎯 Real-World Example
-- =========================

-- Central logic for "Active Customers"

CREATE VIEW active_customers AS
SELECT customer_id, name
FROM customers
WHERE status = 'active';

-- Used in reports, dashboards, APIs


-- =========================
-- 🎯 Advantages
-- =========================

✔ Single source of truth  
✔ Reduces code duplication  
✔ Easy maintenance  
✔ Cleaner queries  
✔ Improves consistency  


-- =========================
-- 🎯 Interview One-Liner
-- =========================

👉 Views help centralize business logic so you write it once and reuse it everywhere.