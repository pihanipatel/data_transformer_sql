-- CREATE DATABASE project2;
DROP TABLE IF EXISTS customer_table;
CREATE TABLE customer_table(
customer_id INT PRIMARY KEY,
first_name VARCHAR(50),
last_name VARCHAR(50),
email VARCHAR(50),
registration_date DATE);
INSERT INTO customer_table(customer_id,first_name,last_name,email,registration_date)
VALUES
    (1,'john','doe','john.doe@email.com','2022-03-15'),
    (2,'jane','smith','jane.smith@email.com','2021-11-02');

DROP TABLE IF EXISTS order_table;
CREATE TABLE order_table(
order_id INT PRIMARY KEY,
customer_id INT,
order_date DATE,
total_amount DECIMAL(10,2)
);
INSERT INTO order_table(order_id,customer_id,order_date,total_amount)
VALUES
    (101,1,'2023-07-01',150.50),
    (102,2,'2023-07-03',200.75);

DROP TABLE IF EXISTS employees_table;
CREATE TABLE employees_table(
employee_id INT PRIMARY KEY,
first_name VARCHAR(50),
last_name VARCHAR(50),
department VARCHAR(50),
hire_date DATE,
salary DECIMAL(10,2));
INSERT INTO employees_table(employee_id,first_name,last_name,department,hire_date,salary)
VALUES
    (1,'mark','johnson','sales','2020-01-15',50000.00),
    (2,'susan','lee','HR','2021-03-20',55000.00);


## Q-1
SELECT order_id,customer_id
FROM order_table AS o
INNER JOIN customer_table AS c
ON o.customer_id = c.customer_id
WHERE order_id IS NOT NULL;

## Q - 2
SELECT customer_id,order_id
FROM customer_table AS c
LEFT JOIN order_table AS o
ON c.customer_id = o.customer_id;

## Q - 3
SELECT customer_id,order_id
FROM order_table AS o
RIGHT JOIN customer_table AS c
ON o.customer_id = c.customer_id;

## Q - 4
SELECT * 
FROM order_table AS o
LEFT JOIN customer_table AS c
ON o.customer_id = c.customer_id
UNION
SELECT * 
FROM order_table AS o
RIGHT JOIN customer_table AS c
ON o.customer_id = c.customer_id;

## Q - 5
SELECT customer_id FROM customer_table 
WHERE customer_id IN (SELECT customer_id FROM order_table
WHERE total_amount > (SELECT AVG(total_amount) FROM order_table));

## Q - 6
SELECT employee_id
FROM employees_table
WHERE salary >(SELECT AVG(salary) FROM employees_table);

## Q - 7
SELECT 
YEAR(order_date) AS year,
MONTH(order_date) AS month
FROM order_table;

## Q - 8
SELECT DATEDIFF(CURDATE(),order_date) AS diff_day
FROM order_table;

## Q - 9
SELECT DATE_FORMAT(order_date,'%d-%m-%Y')
FROM order_table;

## Q - 10
SELECT employee_id,
CONCAT(first_name,' ',last_name) AS full_name FROM employees_table;

## Q - 11
SELECT REPLACE(first_name,'john','jonathan') AS fist_name
FROM customer_table;
## Q - 12
SELECT UPPER(first_name),LOWER(last_name)
FROM employees_table;

## Q - 13
SELECT TRIM(email) FROM customer_table;

## Q - 14
SELECT SUM(total_amount) OVER(ORDER BY order_id ASC) AS running_total FROM order_table;

## Q - 15
SELECT *,RANK() OVER(ORDER BY total_amount ASC) AS ranking FROM order_table;

## Q - 16
SELECT total_amount,
CASE
    WHEN total_amount > 100 THEN '10% off'
    ELSE '5% off' 
    END AS discount
FROM order_table;

## Q - 17

SELECT salary,
CASE
    WHEN salary > 55000 THEN 'high'
    WHEN salary > 20000 THEN 'medium'
    ELSE 'low' 
    END AS discount
FROM employees_table;