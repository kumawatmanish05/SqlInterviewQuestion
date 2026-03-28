/*✅ Definition

👉 Value window functions return a value from 
another row within the window frame.

✔ Used to compare rows
✔ Used for previous/next values
✔ Works with OVER() */

🔥 Types of Value Window Functions
-- ==================================

There are 4 main value functions in SQL:
1. ✅ LAG()
2. ✅ LEAD()
3. ✅ FIRST_VALUE()
4. ✅ LAST_VALUE()


- ==================================================
-- Value (Analytics) Window Functions — Table Format
-- ==================================================
| Function                    | Expression     | PARTITION BY | ORDER BY | Frame Clause      |
| --------------------------- | -------------- | ------------ | -------- | ----------------- |
| LEAD(expr, offset, default) | All Data Types | Optional     | Required | ❌ Not Allowed    |
| LAG(expr, offset, default)  | All Data Types | Optional     | Required | ❌ Not Allowed    |
| FIRST_VALUE(expr)           | All Data Types | Optional     | Required | Optional           |
| LAST_VALUE(expr)            | All Data Types | Optional     | Required | ⚠️ Should Be Used |


- =========================
-- 🔥 LAG Function 
-- =========================
/*LAG() is a window function that returns the value from a previous row in the result set.

✔ Used for comparison
✔ Works without joins*/

🔹 Syntax
-- ========
LAG(column, offset, default) OVER (
    PARTITION BY column   -- optional
    ORDER BY column       -- required
)

🔸 Parameters
===============
-> column → value you want from previous row
-> offset → how many rows back (default = 1)
-> default → value if no previous row (default = NULL)

🔸Example :
-- ====== 

| order_id | sales |
| -------- | ----- |
| 1        | 100   |
| 2        | 150   |
| 3        | 120   |
| 4        | 180   |

SELECT order_id, sales,
       LAG(sales) OVER (ORDER BY order_id) AS prev_sales
FROM orders;

🔸Output:
-- ====
| order_id | sales | prev_sales |
| -------- | ----- | ---------- |
| 1        | 100   | NULL       |
| 2        | 150   | 100        |
| 3        | 120   | 150        |
| 4        | 180   | 120        |

🔸With offset:
-- ============

SELECT order_id, sales,
       LAG(sales, 2) OVER (ORDER BY order_id) AS prev_sales_2
FROM orders;

🔸Output
-- ====
| order_id | sales | prev_sales_2 |
| -------- | ----- | ------------- |
| 1        | 100   | NULL          |
| 2        | 150   | NULL          |
| 3        | 120   | 100           |
| 4        | 180   | 150           |

-- =========================




- =========================
-- 🔥 LEAD Function 
-- =========================
/*👉 LEAD() is a window function that returns the value from the next row in the result set.

✔ Used for forward comparison
✔ No self-join required*/

🔹 Syntax
-- ========
LEAD(column, offset, default) OVER (
    PARTITION BY column   -- optional
    ORDER BY column       -- required
)

🔸 Parameters
===============
-> column → value you want from next row
-> offset → how many rows forward (default = 1)
-> default → value if no next row (default = NULL)

🔸Example :
-- ====== 

| order_id | sales |
| -------- | ----- |
| 1        | 100   |
| 2        | 150   |
| 3        | 120   |
| 4        | 180   |

SELECT order_id, sales,
       LEAD(sales) OVER (ORDER BY order_id) AS next_sales
FROM orders;

🔸Output:
-- ====
| order_id | sales | next_sales |
| -------- | ----- | ---------- |
| 1        | 100   | 150     |
| 2        | 150   | 120        |
| 3        | 120   | 180        |
| 4        | 180   | NULL       |

🔸With offset:
-- ============

SELECT order_id, sales,
       LEAD(sales, 2) OVER (ORDER BY order_id) AS next_sales_2
FROM orders;

🔸Output
-- ====
| order_id | sales | next_sales_2  |
| -------- | ----- | ------------- |
| 1        | 100   | 120           |
| 2        | 150   | 180           |
| 3        | 120   | NULL          |
| 4        | 180   | NULL          |

-- =========================

- =========================
-- Examples::
- =========================

1.Analyze the month over month performance by finding change in sales from previous month:
current month sales with previous month sales.

SELECT order_month, sales,
       LAG(sales) OVER (ORDER BY order_month) AS prev_month_sales,
       sales - LAG(sales) OVER (ORDER BY order_month) AS sales_change
FROM monthly_sales;

2. Compare current row with next row to find if sales are increasing 
or decreasing:

SELECT order_month, sales,
       LEAD(sales) OVER (ORDER BY order_month) AS next_month_sales,
       CASE 
           WHEN sales < LEAD(sales) OVER (ORDER BY order_month) THEN 'Increasing'
           WHEN sales > LEAD(sales) OVER (ORDER BY order_month) THEN 'Decreasing'
           ELSE 'Stable'
       END AS trend
FROM monthly_sales;


3.In order to analyze customer loyalty , rank customers based on the 
average days between their orders:

SELECT customer_id, order_id, order_date,
       LAG(order_date) OVER (PARTITION BY customer_id ORDER BY order_date) 
       AS prev_order_date,
       DATEDIFF(day , order_date, LAG(order_date) OVER (PARTITION BY customer_id 
       ORDER BY order_date)) AS days_between_orders
FROM orders
ORDER BY customer_id, order_date;


- =========================
-- 🔥 First_value Function 
-- =========================
/*👉 FIRST_VALUE() is a window function that returns the value from the 
first row in the result set.

✔ Works with OVER()
✔ Used to compare with minimum / earliest value*/

🔹 Syntax
-- ========
FIRST_VALUE(column) OVER (
    PARTITION BY column   -- optional
    ORDER BY column       -- required
)

🔸 Parameters
===============
-> column → value you want from first row
-> offset → how many rows forward (default = 1)
-> default → value if no first row (default = NULL)

🔸Example :
-- ====== 

| order_id | sales |
| -------- | ----- |
| 1        | 100   |
| 2        | 150   |
| 3        | 120   |
| 4        | 180   |

SELECT order_id, sales,
       FIRST_VALUE(sales) OVER (ORDER BY sales) AS first_val
FROM orders;

🔸Output:
-- ====
| order_id | sales | first_val |
| -------- | ----- | --------- |
| 1        | 100   | 100       |
| 3        | 120   | 100       |
| 2        | 150   | 100       |
| 4        | 180   | 100       |


🔸With PARTITION:
-- ===============

SELECT product_id, order_id, sales,
       FIRST_VALUE(sales) OVER (
           PARTITION BY product_id 
           ORDER BY sales
       ) AS first_sales
FROM orders;

🔸Output
-- ====
| order_id | sales | first_sales  |
| -------- | ----- | ------------- |
| 1        | 100   | 100           |
| 2        | 150   | 100           |
| 3        | 120   | 100           |
| 4        | 180   | 100           |

-- =========================


- =========================
-- 🔥 Last_value Function 
-- =========================
/*👉 LAST_VALUE() is a window function that returns the value from the 
last row in the result set.

✔✔ Works with OVER()
✔ Depends heavily on frame clause ⚠️*/

🔹 Syntax
-- ========
LAST_VALUE(column) OVER (
    PARTITION BY column   -- optional
    ORDER BY column       -- required
    ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
)

🔸 Parameters
===============
-> column → value you want from first row
-> offset → how many rows forward (default = 1)
-> default → value if no first row (default = NULL)

🔸Example :
-- ====== 

| order_id | sales |
| -------- | ----- |
| 1        | 100   |
| 2        | 150   |
| 3        | 120   |
| 4        | 180   |

SELECT order_id, sales,
       LAST_VALUE(sales) OVER (ORDER BY order_id) AS last_val
FROM orders;

🔸Output:
-- ====
| order_id | sales | last_val |
| -------- | ----- | -------- |
| 1        | 100   | 100      |
| 2        | 150   | 150      |
| 3        | 120   | 120      |
| 4        | 180   | 180      |



🔸Correct Query (Fix):
-- ====================

SELECT order_id, sales,
       LAST_VALUE(sales) OVER (
           ORDER BY order_id
           ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
       ) AS last_val
FROM orders;

🔸Output
-- ====
| order_id | sales | last_val |
| -------- | ----- | -------- |
| 1        | 100   | 180      |
| 2        | 150   | 180      |
| 3        | 120   | 180      |
| 4        | 180   | 180      |



🔥 With PARTITION(Fix):
-- ====================

SELECT product_id, order_id, sales,
       LAST_VALUE(sales) OVER (
           PARTITION BY product_id
           ORDER BY order_id
           ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
       ) AS last_sales
FROM orders;

🔸Output
-- ====
| product_id | order_id | sales | last_sales |
| ---------- | -------- | ----- | ------------ |
| 1          | 1        | 100   | 180          |
| 1          | 2        | 150   | 180          |
| 1          | 3        | 120   | 180          |
| 1          | 4        | 180   | 180          |
| 2          | 1        | 150   | 180          |
| 2          | 2        | 120   | 180          |
| 2          | 3        | 180   | 180          |
| 2          | 4        | 180   | 180          |
-- =========================