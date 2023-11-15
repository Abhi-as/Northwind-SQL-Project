-- ---------------------------------------------- --
-- --------------- Easy Questions --------------- --
-- ---------------------------------------------- --

-- Q1. Show the category_name and description from the categories table sorted by category_name.
SELECT 
    category_name, description
FROM
    categories
ORDER BY 1;

-- Q2. Show all the contact_name, address, city of all customers which are not from 'Germany', 'Mexico', 'Spain'.
SELECT 
    contact_name, address, city
FROM
    customers
WHERE
    Country NOT IN ('Germany' , 'Mexico', 'Spain');

-- Q3. Show order_date, shipped_date, customer_id, Freight of all orders placed on 2018 Feb 26.
SELECT 
    order_date, shipped_date, customer_id, freight
FROM
    orders
WHERE
    order_date = '2018-02-26'; 
    
/* Q4. Show the employee_id, order_id, customer_id, required_date, shipped_date 
from all orders shipped later than the required date.*/
SELECT 
    employee_id,
    order_id,
    customer_id,
    required_date,
    shipped_date
FROM
    orders
WHERE
    required_date < shipped_date;
    
-- Q5. Show all the even numbered Order_id from the orders table.
SELECT 
    order_id
FROM
    orders
WHERE
    order_id % 2 = 0;
    
/* Q6. Show the city, company_name, contact_name of all customers from cities which 
contains the letter 'L' in the city name, sorted by contact_name.*/
SELECT 
    city, company_name, contact_name
FROM
    customers
WHERE
    city LIKE '%L%'
ORDER BY 3;

-- Q7. Show the company_name, contact_name, fax number of all customers that has a fax number. (not null)
SELECT 
    company_name, contact_name, fax
FROM
    customers
WHERE
    fax IS NOT NULL;
    
-- Q8. Show the first_name, last_name. hire_date of the most recently hired employee.
SELECT 
    first_name, last_name, MAX(hire_date)
FROM
    employees;

/* Q9. Show the average unit price rounded to 2 decimal places, the total units in stock, 
total discontinued products from the products table.*/
SELECT 
    ROUND(AVG(Unit_Price), 2) AS average_price,
    SUM(units_in_stock) AS total_stock,
    SUM(discontinued) AS total_discontinued
FROM
    products;

-- ---------------------------------------------- --
-- -------------- Medium Questions -------------- --
-- ---------------------------------------------- --

-- Q1. Show the ProductName, CompanyName, CategoryName from the products, suppliers, and categories table.
SELECT 
    product_name, company_name, category_name
FROM
    categories c
        JOIN
    products p ON c.category_id = p.category_id
        JOIN
    suppliers s ON p.supplier_id = s.supplier_id;
    
-- Q2. Show the category_name and the average product unit price for each category rounded to 2 decimal places.
SELECT 
    category_name, ROUND(AVG(unit_price), 2)
FROM
    categories c
        JOIN
    products p ON c.category_id = p.category_id
GROUP BY 1;

/* Q3. Show the city, company_name, contact_name from the customers and suppliers table merged together.
Create a column which contains 'customers' or 'suppliers' depending on the table it came from.*/
SELECT 
    city,
    company_name,
    contact_name,
    'Customers' AS relationship
FROM
    customers 
UNION ALL SELECT 
    city, company_name, contact_name, 'Suppliers'
FROM
    suppliers;

-- ---------------------------------------------- --
-- --------------- Hard Questions --------------- --
-- ---------------------------------------------- --

/*Show the employee's first_name and last_name, a "num_orders" column with a count of the orders taken, 
and a column called "Shipped" that displays "On Time" if the order shipped_date is less or equal to the required_date, 
"Late" if the order shipped late.
Order by employee last_name, then by first_name, and then descending by number of orders.*/
SELECT 
    first_name,
    last_name,
    COUNT(*) AS num_orders,
    CASE
        WHEN shipped_date <= required_date THEN 'On Time'
        ELSE 'Late'
    END AS Shipped
FROM
    employees e
        JOIN
    orders o ON e.employee_id = o.employee_id
GROUP BY shipped , first_name , last_name
ORDER BY last_name , first_name , num_orders DESC;