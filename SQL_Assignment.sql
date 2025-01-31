CREATE DATABASE Giva;
USE Giva;
-- Creating Tables
CREATE TABLE Sales_Data (
    order_id INT PRIMARY KEY,
    SKUs_bought VARCHAR(255),
    price DECIMAL(10, 2),
    discount DECIMAL(10, 2),
    order_date DATE,
    customer_id INT,
    order_city VARCHAR(50),
    channel_type VARCHAR(10) CHECK (channel_type IN ('online', 'offline'))
);

CREATE TABLE Product_Details (
    SKU VARCHAR(10) PRIMARY KEY,
    MRP DECIMAL(10, 2),
    product_name VARCHAR(100)
);

CREATE TABLE Customer_Details (
    customer_id INT PRIMARY KEY,
    name VARCHAR(100),
    phone_number VARCHAR(15),
    email VARCHAR(100)
);

-- Inserting Data into Product_Details
INSERT INTO Product_Details (SKU, MRP, product_name) VALUES
('ST123', 600, 'Steel Chair'),
('CR456', 500, 'Ceramic Mug'),
('ST456', 400, 'Steel Table'),
('CR789', 700, 'Ceramic Vase'),
('ST789', 800, 'Steel Shelf'),
('CR123', 300, 'Ceramic Plate');

-- Inserting Data into Customer_Details
INSERT INTO Customer_Details (customer_id, name, phone_number, email) VALUES
(101, 'John Doe', '9876543210', 'john@example.com'),
(102, 'Jane Smith', '8765432109', 'jane@example.com'),
(103, 'Alice Brown', '7654321098', 'alice@example.com'),
(104, 'Bob Johnson', '6543210987', 'bob@example.com'),
(105, 'Charlie Lee', '5432109876', 'charlie@example.com');

-- Inserting Data into Sales_Data
INSERT INTO Sales_Data (order_id, SKUs_bought, price, discount, order_date, customer_id, order_city, channel_type) VALUES
(1, 'ST123,CR456', 500, 50, '2023-10-01', 101, 'Mumbai', 'online'),
(2, 'CR789,ST123', 700, 100, '2023-10-02', 102, 'Delhi', 'offline'),
(3, 'ST456,CR789', 300, 20, '2023-10-03', 103, 'Mumbai', 'online'),
(4, 'CR456,ST789', 450, 30, '2023-10-04', 101, 'Mumbai', 'offline'),
(5, 'ST123,CR789', 600, 50, '2023-10-05', 104, 'Bangalore', 'online'),
(6, 'CR456,ST456', 550, 40, '2023-10-06', 102, 'Delhi', 'offline'),
(7, 'ST789,CR123', 800, 60, '2023-10-07', 105, 'Mumbai', 'online'),
(8, 'CR789,ST123', 700, 100, '2023-10-08', 101, 'Mumbai', 'online');

/*Q1:Name and list the details of all customers who have placed multiple 
orders and have purchased a ceramic item at least once.*/

SELECT cd.customer_id, cd.name, cd.phone_number, cd.email
FROM Customer_Details cd
JOIN (
    SELECT customer_id
    FROM Sales_Data
    WHERE SKUs_bought LIKE '%CR%'
    GROUP BY customer_id
    HAVING COUNT(order_id) > 1
) AS multi_order_customers
ON cd.customer_id = multi_order_customers.customer_id;

/*Q2:Find the most expensive bestselling product*/

SELECT pd.SKU, pd.product_name, pd.MRP, COUNT(sd.order_id) AS total_orders
FROM Product_Details pd
JOIN Sales_Data sd
ON FIND_IN_SET(pd.SKU, sd.SKUs_bought) > 0
GROUP BY pd.SKU, pd.product_name, pd.MRP
ORDER BY pd.MRP DESC, total_orders DESC
LIMIT 1;


/*Q3:For all customers whose first ever purchase was from online, 
calculate the average number of times they purchase from offline in a month*/

WITH first_purchase AS (
    SELECT customer_id, MIN(order_date) AS first_order_date
    FROM Sales_Data
    WHERE channel_type = 'online'
    GROUP BY customer_id
),
offline_purchases AS (
    SELECT sd.customer_id, COUNT(sd.order_id) AS offline_count
    FROM Sales_Data sd
    JOIN first_purchase fp
    ON sd.customer_id = fp.customer_id
    WHERE sd.channel_type = 'offline'
    AND sd.order_date >= fp.first_order_date
    GROUP BY sd.customer_id
)
SELECT AVG(offline_count) AS avg_offline_purchases_per_month
FROM offline_purchases;

/*Q4:List the top 7 spenders in Y city (here Y should be a user-input variable)*/

-- SET @city = 'Mumbai'; USE this to check the query if python script isn't working.
SELECT cd.customer_id, cd.name, SUM(sd.price - sd.discount) AS total_spent
FROM Customer_Details cd
JOIN Sales_Data sd ON cd.customer_id = sd.customer_id
WHERE sd.order_city = @city
GROUP BY cd.customer_id, cd.name
ORDER BY total_spent DESC
LIMIT 7;
