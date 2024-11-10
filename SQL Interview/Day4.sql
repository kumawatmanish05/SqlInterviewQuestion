-- Meesho SQL Question 
-- Medium Level
-- our task is to calculate the 3-month moving average of sales revenue for each month,
-- using the sales data in the Orders table.

CREATE TABLE Customers (
    Customer_id INT PRIMARY KEY,
    Name VARCHAR(100),
    Join_Date DATE
);

INSERT INTO Customers (Customer_id, Name, Join_Date) VALUES
(1, 'John', '2023-01-10'),
(2, 'Simmy', '2023-02-15'),
(3, 'Iris', '2023-03-20');
 
CREATE TABLE Orders (
    Order_id INT PRIMARY KEY,
    Customer_id INT,
    Order_Date DATE,
    Amount DECIMAL(10, 2)
);
INSERT INTO Orders (Order_id, Customer_id, Order_Date, Amount) VALUES
(1, 1, '2023-01-05', 100.00),
(2, 2, '2023-02-14', 150.00),
(3, 1, '2023-02-28', 200.00),
(4, 3, '2023-03-22', 300.00),
(5, 2, '2023-04-10', 250.00),
(6, 1, '2023-05-15', 400.00),
(7, 3, '2023-06-10', 350.00);

WITH Monthly_Sales AS (
    SELECT 
        DATE_FORMAT(Order_Date, '%Y-%m-01') AS month,
        SUM(Amount) AS monthly_sales
    FROM Orders
    GROUP BY DATE_FORMAT(Order_Date, '%Y-%m-01')
)

SELECT 
    month,
    monthly_sales,
    ROUND(AVG(monthly_sales) OVER (
        ORDER BY month 
        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
    ), 2) AS three_month_moving_avg
FROM Monthly_Sales
ORDER BY month;



