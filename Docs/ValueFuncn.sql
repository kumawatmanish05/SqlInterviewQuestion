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
| order_id | sales | next_sales_2 |
| -------- | ----- | ------------- |
| 1        | 100   | 120           |
| 2        | 150   | 180           |
| 3        | 120   | NULL          |
| 4        | 180   | NULL          |

-- =========================