# Get all products with unit price > 50, sorted by price descending
select product_code, product_name, list_price
from products
where list_price > 50
order by list_price desc;

#List all customers from 'USA' and sort by company name
SELECT company, city, country_region
FROM customers
WHERE country_region = 'USA'
ORDER BY company;

#Total number of orders per customer
select customer_id, count(id) as total_orders
from orders
group by customer_id 
order by total_orders desc;

#Average List price per supplier
select supplier_ids, avg(list_price) as avg_price
from products
group by supplier_ids;

#List of orders with customer names (INNER JOIN)
SELECT o.id, c.company, o.order_date
FROM orders o
INNER JOIN customers c ON o.customer_id = c.id
ORDER BY o.order_date DESC;

#LEFT JOIN: Employees and their orders (even if no orders)
SELECT e.first_name, e.last_name, o.id
FROM employees e
LEFT JOIN orders o ON e.id = o.employee_id;

#Customers who have placed more than 5 orders
select company
from customers
where id in(
select customer_id
from orders
group by customer_id
having count(id)> 5
);

#Products with price greater than the average price
select product_name, list_price
from products
where list_price > (
select avg(list_price) from products
);

#View for customer order summary
CREATE VIEW customer_order_summary AS
SELECT c.company, COUNT(o.id) AS total_orders
FROM customers c
JOIN orders o ON c.id = o.customer_id
GROUP BY c.company;

# run upper qurey
SELECT * FROM customer_order_summary;

#View of high-value products (price > 30)
CREATE VIEW high_value_products AS
SELECT product_code, product_name, list_price
FROM products
WHERE list_price > 30;

# run upper qurey
SELECT * FROM high_value_products;

#Index on product name (if you often search/filter by name)
CREATE INDEX idx_product_name ON products(product_name);

#Index on order_date (for faster filtering)
CREATE INDEX idx_order_date ON orders(order_date);
