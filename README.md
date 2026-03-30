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



#Day:-1 HBSC SQL Question(04/11/24)


#Day:-2 EY Data Analyst SQL question.(05/11/24)


#Day:-3 Indium (Medium) SQL Quesiton (06/11/24) 


#Day:-4 Meesho SQL Question Medium Level(08/11/24)


#Day:-5 SQl Ranking Function (27/03/26)






