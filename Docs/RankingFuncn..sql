/* 👉 Window Ranking Functions are SQL functions that assign a rank/
position to each row within a result set based on a specified order, 
without reducing the number of rows.

✔ They are a type of window function
✔ Always used with OVER() clause
✔ Often used with ORDER BY and sometimes PARTITION BY 

🔥 Types of Ranking Window Functions
-- ==================================

There are 6 main ranking functions in SQL:
1. ✅ RANK()
2. ✅ ROW_NUMBER()
3. ✅ DENSE_RANK()
4. ✅ NTILE(n)
5. ✅ CUME_DIST
6. ✅ PERCENT RANK 



-- =========================
-- 🔥 Rank Function 
-- =========================

👉 RANK() is a window ranking function that assigns a rank to each 
row based on a specified order.

✔ Rows with the same values get the same rank
❗ But it skips the next rank(s) (creates gaps) 
 ! Frame Clause is not allowed */

RANK() OVER (
    PARTITION BY column   -- optional
    ORDER BY column       -- required
)

Example :
-- ====== 

| order_id | customer_id | product_id | sales |
| -------- | ----------- | ---------- | ----- |
| 1        | 101         | 201        | 50    |
| 2        | 101         | 202        | 70    |
| 3        | 102         | 201        | 70    |
| 4        | 102         | 203        | 90    |
| 5        | 103         | 202        | 50    |

SELECT order_id, sales,
       RANK() OVER (ORDER BY sales DESC) AS rank
FROM orders;

Output:
-- ====

| sales | rank |       👉 Rank 3 is skipped ❗
| ----- | ---- |
| 90    | 1    |
| 70    | 2    |
| 70    | 2    |
| 50    | 4    |
| 50    | 4    |

🔹 Use-Cases
-- ==========
1. 🎯 Top N Highest Sales (With Ties)
SELECT *
FROM (
    SELECT *,
           RANK() OVER (ORDER BY sales DESC) rnk
    FROM orders
) t
WHERE rnk <= 3;

2. 🎯 Rank Within Each Customer
SELECT customer_id, order_id, sales,
       RANK() OVER (PARTITION BY customer_id ORDER BY sales DESC) rnk
FROM orders;

3. 🎯 Find 2nd Highest Sale
SELECT *
FROM (
    SELECT *,
           RANK() OVER (ORDER BY sales DESC) rnk
    FROM orders
) t
WHERE rnk = 2;


-- =========================
-- 🔥 Row_Number()
-- =========================

/*👉 ROW_NUMBER() is a window ranking function that assigns 
a unique sequential number to each row.

✔ Starts from 1
✔ No duplicates
✔ No gaps*/

🔹 Syntax
-- ========
ROW_NUMBER() OVER (
    PARTITION BY column   -- optional
    ORDER BY column       -- required
)

Example :
-- ====== 

| name | dept | salary |    
| ---- | ---- | ------ |
| A    | IT   | 100    |
| B    | IT   | 100    |
| C    | IT   | 80     |

SELECT name, salary,
       ROW_NUMBER() OVER (ORDER BY salary DESC) AS row_num
FROM employees;

Output:
-- ====
| name | salary | row_num |
| ---- | ------ | ------- |
| A    | 100    | 1       |
| B    | 100    | 2       |
| C    | 80     | 3       |


🔹 Use-Cases
-- ==========
1. 🎯 Top N per Group (Most Asked 🔥)
SELECT *
FROM (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY dept ORDER BY salary DESC)rn
    FROM employees
) t
WHERE rn <= 2;

2. 🎯 Remove Duplicates
SELECT *
FROM (
    SELECT *, ROW_NUMBER() OVER (PARTITION BY email ORDER BY id) rn
    FROM users
) t
WHERE rn = 1;

3.🎯 Latest Record per Group
SELECT *
FROM (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY product_id ORDER BY order_date DESC) rn
    FROM orders
) t
WHERE rn = 1;



-- =========================
-- 🔥 Dense_Rank()
-- =========================

/*👉 DENSE_RANK() is a window ranking function that assigns a rank to rows without skipping any rank values.

✔ Same values → same rank
✔ ❌ No gaps in ranking */

🔹 Syntax
-- ========
DENSE_RANK() OVER (
    PARTITION BY column   -- optional
    ORDER BY column DESC  -- required
)

🔹Example :
-- =======
| order_id | sales |
| -------- | ----- |
| 1        | 90    |
| 2        | 70    |
| 3        | 70    |
| 4        | 50    |

SELECT order_id, sales,
       DENSE_RANK() OVER (ORDER BY sales DESC) AS dense_rank
FROM orders;


🔹Output:
-- ======
| sales | dense_rank |              👉 Notice:
| ----- | ---------- |                 -> No rank is skipped
| 90    | 1          |                 -> Continuous ranking
| 70    | 2          |
| 70    | 2          |
| 50    | 3          |


🔹Difference :
-- ===========
| Function   | Output             |
| ---------- | ------------------ |
| RANK       | 1, 2, 2, 4 ❗ (gap) |
| DENSE_RANK | 1, 2, 2, 3 ✅       |


🔹 Use-Cases
-- ==========
1. 🎯 Top N Values Without Skipping
SELECT *
FROM (
    SELECT *,
           DENSE_RANK() OVER (ORDER BY sales DESC) rnk
    FROM orders
) t
WHERE rnk <= 3;

2. 🎯 Department-wise Ranking
SELECT department, name, salary,
       DENSE_RANK() OVER (PARTITION BY department ORDER BY salary DESC) rnk
FROM employees;

3. 🎯 Find 2nd Highest Value
SELECT *
FROM (
    SELECT *,
           DENSE_RANK() OVER (ORDER BY sales DESC) rnk
    FROM orders
) t
WHERE rnk = 2;

4. Bottom N Orders based on Sales 
SELECT *
FROM (
    SELECT *,
           DENSE_RANK() OVER (ORDER BY sales ASC) AS rnk
    FROM orders
) t
WHERE rnk <= 3;



-- =========================
-- 🔥 NTILE(n)
-- =========================

/* 👉 NTILE(n) divides rows into N equal groups (buckets) based on ordering.

✔ Each row gets a group number
✔ Groups are as equal as possible */

🔹 Syntax
-- ========
NTILE(n) OVER (
    PARTITION BY column   -- optional
    ORDER BY column
)

🔹Example:
-- ========
| order_id | sales |
| -------- | ----- |
| 1        | 10    |
| 2        | 20    |
| 3        | 30    |
| 4        | 40    |
| 5        | 50    |
| 6        | 60    |
| 7        | 70    |
| 8        | 80    |

SELECT order_id, sales,
       NTILE(4) OVER (ORDER BY sales) AS bucket
FROM orders;

🔹Output:
-- =======
| sales | bucket |
| ----- | ------ |
| 10    | 1      |
| 20    | 1      |
| 30    | 2      |
| 40    | 2      |
| 50    | 3      |
| 60    | 3      |
| 70    | 4      |
| 80    | 4      |


🔹 Use-Cases
-- ==========
1. 📊 Quartiles (Top 25%, 50%, etc.)
SELECT *,
       NTILE(4) OVER (ORDER BY sales DESC) AS quartile
FROM orders;

👉 Divide into:
 ->Q1 → Top 25%
 ->Q4 → Bottom 25%

 2. 🎯 Customer Segmentation

👉 Example:

 ->High spenders
 ->Medium
 ->Low

3. 📈 Performance Bucketing

👉 Employees into:

  ->Top performers
  ->Average
  ->Low performers



-- =========================
-- 📊 CUME_DIST()
-- =========================
/*👉 CUME_DIST() (Cumulative Distribution) returns the relative position of a row within a dataset.

✔ Value range → 0 to 1
✔ Shows percentage of rows ≤ current row */

🔹 Syntax
-- ========
CUME_DIST() OVER (
    PARTITION BY column   -- optional
    ORDER BY column
)
🔹Example:
-- ========
| order_id | sales |
| -------- | ----- |
| 1        | 10    |
| 2        | 20    |
| 3        | 30    |
| 4        | 40    |
| 5        | 50    |

SELECT order_id, sales,
       CUME_DIST() OVER (ORDER BY sales) AS cum_dist
FROM orders;

🔹Output:
-- =======
| sales | cum_dist |
| ----- | -------- |
| 10    | 0.2      |
| 20    | 0.4      |
| 30    | 0.6      |
| 40    | 0.8      |
| 50    | 1.0      |



🔥 With Duplicates (Important 🔥)
-- ==========-====================
| sales |
| ----- |
| 10    |
| 20    |
| 20    |
| 30    |

🔹Output:
-- =======
| sales | cume_dist |
| ----- | --------- |     ✔ Both 20s get same value
| 10    | 0.25      |     ✔ Counts all rows ≤ 20
| 20    | 0.75 ❗    |
| 20    | 0.75      |
| 30    | 1.0       |



-- =========================
-- 📊 PERCENT_RANK()
-- =========================
/*👉 PERCENT_RANK() returns the relative
rank of a row as a percentage within a result set.

✔ Value range → 0 to 1
✔ First row → always 0 */

🔹 Syntax
-- ========
PERCENT_RANK() OVER (
    PARTITION BY column   -- optional
    ORDER BY column
)

🔹Formula:
-- ========
PERCENT_RANK = RANK - 1 / Total Rows -2


🔹Example:
-- ========
| order_id | sales |
| -------- | ----- |
| 1        | 10    |
| 2        | 20    |
| 3        | 30    |
| 4        | 40    |
| 5        | 50    |

SELECT order_id, sales,
       PERCENT_RANK() OVER (ORDER BY sales) AS pr
FROM orders;
🔹Output:
-- =======
| sales | percent_rank |
| ----- | ------------ |
| 10    | 0.00         |
| 20    | 0.25         |
| 30    | 0.50         |
| 40    | 0.75         |
| 50    | 1.00         |

🔥 With Duplicates (Important 🔥)
-- ==========-====================
| sales |
| ----- |
| 10    |
| 20    |
| 20    |
| 30    |

🔹Output:
-- =======
| sales | percent_rank |
| ----- | ------------ |
| 10    | 0.00         |       ✔ Same rank → same percent
| 20    | 0.33         |       ✔ Based on RANK() logic
| 20    | 0.33         |
| 30    | 1.00         |



