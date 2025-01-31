# Sales Data Analysis Repository

## Overview
This repository contains SQL-based solutions and a dataset for sales analysis. The dataset includes three tables: `Sales_Data`, `Product_Details`, and `Customer_Details`. Each table has been populated with sample data for various analysis tasks related to customer behavior, product performance, and sales metrics.

### Tables
1. **Sales_Data**
   - `order_id`: Unique identifier for each order.
   - `SKUs_bought`: Comma-separated list of product SKUs (Alpha-numeric codes).
   - `price`: Price of the product(s).
   - `discount`: Discount applied on the order.
   - `order_date`: Date of the order.
   - `customer_id`: Unique identifier for the customer.
   - `order_city`: City where the order was placed.
   - `channel_type`: Whether the order was placed online or offline.

   **Note**: SKUs consist of two categories:
   - **Steel products**: SKU starting with `ST`
   - **Ceramic products**: SKU starting with `CR`

2. **Product_Details**
   - `SKU`: Unique identifier for each product.
   - `MRP`: Maximum retail price of the product.
   - `product_name`: Name of the product.

3. **Customer_Details**
   - `customer_id`: Unique identifier for each customer.
   - `name`: Name of the customer.
   - `phone_number`: Customer's phone number.
   - `email`: Customer's email address.

## Instructions for Use
1. **Download Sample Data**: The data for these tables can be populated using freely available datasets or by generating random data using online tools.
2. **Database Setup**: Create the three tables (`Sales_Data`, `Product_Details`, and `Customer_Details`) in your preferred SQL database and populate them with the sample data.
3. **Run Queries**: The repository contains SQL queries to answer several business questions based on the given dataset. Use them to solve the following problems:

### Queries to Solve
1. **Customers with Multiple Orders and Ceramic Purchases**  
   List the details of all customers who have placed multiple orders and have purchased a ceramic item at least once.

2. **Most Expensive Bestselling Product**  
   Find the most expensive bestselling product based on the number of orders.

3. **Average Offline Purchases for Online First-Time Customers**  
   For all customers whose first-ever purchase was from online, calculate the average number of times they purchase from offline in a month.

4. **Top 7 Spenders in a Given City**  
   List the top 7 spenders in a user-defined city (Y). Use the `channel_type` and `order_city` to filter the data.

### Conclusion
This repository provides a solid foundation for sales data analysis and can be extended or modified as per business needs. Feel free to contribute by improving the data, adding more queries, or exploring new insights from the dataset.
