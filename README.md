# Project 2 – MySQL Database & SQL Query Practice

## 📌 Project Overview

This project is a MySQL-based database project that demonstrates how to:

- Create a database and tables
- Insert customer, order, and employee data
- Use different types of SQL JOINs
- Use subqueries
- Work with date and time functions
- Perform string manipulation
- Calculate running totals using window functions
- Rank records using `RANK()`
- Apply conditional logic using `CASE`

The project is implemented in a single SQL file: **`pro_2.sql`**.

---

## 🗂️ Project Structure

```text
Project-2/
│
├── pro_2.sql
└── README.md
```

### Main SQL file

`pro_2.sql` contains:

1. Database creation
2. Table creation
3. Sample data insertion
4. 17 SQL query exercises

---

# 🏗️ Database Structure

The project uses the database:

```sql
CREATE DATABASE project2;
```

The database contains three main tables:

```text
                 ┌─────────────────────┐
                 │    project2 DB      │
                 └──────────┬──────────┘
                            │
          ┌─────────────────┼─────────────────┐
          │                 │                 │
          ▼                 ▼                 ▼
┌─────────────────┐ ┌─────────────────┐ ┌──────────────────┐
│ customer_table  │ │  order_table    │ │ employees_table  │
├─────────────────┤ ├─────────────────┤ ├──────────────────┤
│ customer_id     │ │ order_id        │ │ employee_id      │
│ first_name      │ │ customer_id     │ │ first_name       │
│ last_name       │ │ order_date      │ │ last_name        │
│ email           │ │ total_amount    │ │ department       │
│ registration_date│ └─────────────────┘ │ hire_date        │
└─────────────────┘                     │ salary           │
                                        └──────────────────┘
```

> **Important:** The SQL file defines `customer_id` as the primary key in `customer_table` and `order_id` as the primary key in `order_table`. The `order_table.customer_id` column is used to match orders with customers in the JOIN queries.

---

# 📋 Table Details

## 1. customer_table

This table stores customer information.

| Column | Data Type | Description |
|---|---|---|
| customer_id | INT | Unique customer ID |
| first_name | VARCHAR(50) | Customer first name |
| last_name | VARCHAR(50) | Customer last name |
| email | VARCHAR(50) | Customer email |
| registration_date | DATE | Customer registration date |

### Sample records

| customer_id | first_name | last_name | email | registration_date |
|---:|---|---|---|---|
| 1 | john | doe | john.doe@email.com | 2022-03-15 |
| 2 | jane | smith | jane.smith@email.com | 2021-11-02 |

---

## 2. order_table

This table stores order information.

| Column | Data Type | Description |
|---|---|---|
| order_id | INT | Unique order ID |
| customer_id | INT | ID used to associate an order with a customer |
| order_date | DATE | Date of the order |
| total_amount | DECIMAL(10,2) | Total order amount |

### Sample records

| order_id | customer_id | order_date | total_amount |
|---:|---:|---|---:|
| 101 | 1 | 2023-07-01 | 150.50 |
| 102 | 2 | 2023-07-03 | 200.75 |

---

## 3. employees_table

This table stores employee information.

| Column | Data Type | Description |
|---|---|---|
| employee_id | INT | Unique employee ID |
| first_name | VARCHAR(50) | Employee first name |
| last_name | VARCHAR(50) | Employee last name |
| department | VARCHAR(50) | Employee department |
| hire_date | DATE | Employee hiring date |
| salary | DECIMAL(10,2) | Employee salary |

### Sample records

| employee_id | first_name | last_name | department | hire_date | salary |
|---:|---|---|---|---|---:|
| 1 | mark | johnson | sales | 2020-01-15 | 50000.00 |
| 2 | susan | lee | HR | 2021-03-20 | 55000.00 |

---

# 🔄 Overall Project Flowchart

```text
                 START
                   │
                   ▼
          Create project2 Database
                   │
                   ▼
          Create Customer Table
                   │
                   ▼
          Insert Customer Data
                   │
                   ▼
            Create Order Table
                   │
                   ▼
            Insert Order Data
                   │
                   ▼
          Create Employee Table
                   │
                   ▼
          Insert Employee Data
                   │
                   ▼
       ┌───────────┴────────────┐
       │                        │
       ▼                        ▼
 Customer + Order          Employee Queries
       │                        │
       ▼                        ▼
   JOIN Queries             Subquery
       │                        │
       ├── INNER JOIN           ├── Average Salary
       ├── LEFT JOIN            │
       ├── RIGHT JOIN           ▼
       └── Combined JOIN   Date Functions
                                │
                                ├── YEAR()
                                ├── MONTH()
                                ├── DATEDIFF()
                                └── DATE_FORMAT()
                                │
                                ▼
                         String Functions
                                │
                                ├── CONCAT()
                                ├── REPLACE()
                                ├── UPPER()
                                ├── LOWER()
                                └── TRIM()
                                │
                                ▼
                         Window Functions
                                │
                                ├── SUM() OVER()
                                └── RANK() OVER()
                                │
                                ▼
                          CASE Statements
                                │
                                ▼
                               END
```

---

# 🔗 JOIN Query Flow

The customer and order tables are connected using `customer_id`.

```text
customer_table                         order_table
┌───────────────┐                     ┌───────────────┐
│ customer_id   │◄────────────────────│ customer_id   │
│ first_name    │                     │ order_id      │
│ last_name     │                     │ order_date    │
│ email         │                     │ total_amount  │
└───────────────┘                     └───────────────┘
         │                                     │
         └──────────── JOIN ───────────────────┘
```

The common column is:

```text
customer_table.customer_id
             =
order_table.customer_id
```

---

# 📝 Query-by-Query Explanation

## Q1 – INNER JOIN

```sql
SELECT *
FROM order_table AS o
INNER JOIN customer_table AS c
ON o.customer_id = c.customer_id
WHERE order_id IS NOT NULL;
```

### Purpose

Combines orders with their matching customers.

### Concept

**INNER JOIN returns matching records from both tables.**

```text
Customer ───── Matching Orders
```

---

## Q2 – LEFT JOIN

```sql
SELECT * 
FROM customer_table AS c
LEFT JOIN order_table AS o
ON c.customer_id = o.customer_id;
```

### Purpose

Starts with all customers and attaches their matching orders.

### Concept

**LEFT JOIN keeps all rows from the left table.**

```text
ALL CUSTOMERS
      +
MATCHING ORDERS
```

---

## Q3 – RIGHT JOIN

```sql
SELECT * 
FROM order_table AS o
RIGHT JOIN customer_table AS c
ON o.customer_id = c.customer_id;
```

### Purpose

Starts from the order table but keeps all records from the right-side customer table.

### Concept

**RIGHT JOIN keeps all rows from the right table.**

---

## Q4 – Combined JOIN Using UNION

The query combines a LEFT JOIN and a RIGHT JOIN using `UNION`.

```text
             LEFT JOIN
                 │
                 ▼
          ┌─────────────┐
          │             │
          │    UNION    │
          │             │
          └─────────────┘
                 ▲
                 │
             RIGHT JOIN
```

This is used to combine the results of both JOIN operations.

---

# 🔍 Subquery Flow

## Q5 – Customers with Orders Above Average

The query uses a nested subquery.

```text
                order_table
                     │
                     ▼
          Calculate AVG(total_amount)
                     │
                     ▼
       Find orders greater than average
                     │
                     ▼
              Get customer_id
                     │
                     ▼
          Match with customer_table
```

The important concept is:

```sql
AVG(total_amount)
```

The average order amount is calculated first, and the result is used by the outer query.

---

## Q6 – Employees Above Average Salary

```sql
SELECT employee_id
FROM employees_table
WHERE salary >
      (SELECT AVG(salary)
       FROM employees_table);
```

### Flow

```text
employees_table
       │
       ▼
Calculate AVG(salary)
       │
       ▼
Compare every employee salary
       │
       ▼
Return employees above average
```

---

# 📅 Date Functions

## Q7 – Extract Year and Month

```sql
YEAR(order_date)
MONTH(order_date)
```

### Purpose

Extracts the year and month from the order date.

Example:

```text
2023-07-01
   │  │
   │  └── Month = 7
   └───── Year = 2023
```

---

## Q8 – Calculate Difference Between Dates

```sql
DATEDIFF(CURDATE(), order_date)
```

### Purpose

Calculates the number of days between today's date and the order date.

```text
Current Date
     │
     ▼
   DATEDIFF
     ▲
     │
Order Date
```

---

## Q9 – Format Date

```sql
DATE_FORMAT(order_date,'%d-%m-%Y')
```

### Purpose

Changes the display format of the date.

Example:

```text
2023-07-01
     ↓
01-07-2023
```

---

# 🔤 String Functions

## Q10 – CONCAT()

```sql
CONCAT(first_name,' ',last_name)
```

### Purpose

Combines first name and last name.

```text
mark + johnson
      ↓
mark johnson
```

---

## Q11 – REPLACE()

```sql
REPLACE(first_name,'john','jonathan')
```

### Purpose

Replaces the specified text.

Example:

```text
john
 ↓
jonathan
```

---

## Q12 – UPPER() and LOWER()

```sql
UPPER(first_name)
LOWER(last_name)
```

### Purpose

- `UPPER()` converts text to uppercase.
- `LOWER()` converts text to lowercase.

Example:

```text
mark     → MARK
JOHNSON  → johnson
```

---

## Q13 – TRIM()

```sql
TRIM(email)
```

### Purpose

Removes unnecessary spaces from the beginning and end of a string.

```text
"  john@email.com  "
          ↓
"john@email.com"
```

---

# 📊 Window Functions

## Q14 – Running Total

```sql
SUM(total_amount) OVER(ORDER BY order_id ASC)
```

### Purpose

Calculates a cumulative/running total as the orders progress.

```text
Order 101 → Amount
             ↓
Order 102 → Amount
             ↓
       Running Total
```

Example concept:

```text
150.50
150.50 + 200.75
        ↓
351.25
```

---

## Q15 – RANK()

```sql
RANK() OVER(ORDER BY total_amount ASC)
```

### Purpose

Assigns a ranking based on order amount.

```text
Order Amount
     │
     ▼
Sort in ASC order
     │
     ▼
Assign Rank
```

---

# 🧠 CASE Statements

## Q16 – Order Discount Classification

```sql
CASE
    WHEN total_amount > 100 THEN '10% off'
    ELSE '5% off'
END
```

### Logic

```text
             total_amount
                   │
                   ▼
          Is amount > 100?
             /         \
           YES          NO
            │            │
            ▼            ▼
         10% off       5% off
```

---

## Q17 – Salary Classification

```sql
CASE
    WHEN salary > 55000 THEN 'high'
    WHEN salary > 20000 THEN 'medium'
    ELSE 'low'
END
```

### Logic

```text
                  Salary
                    │
                    ▼
             Salary > 55000?
               /          \
             YES           NO
              │             │
              ▼             ▼
            HIGH      Salary > 20000?
                           /      \
                         YES       NO
                          │         │
                          ▼         ▼
                       MEDIUM      LOW
```

---

# 🧩 Concepts Covered

| Topic | Query |
|---|---|
| Database creation | Project setup |
| Table creation | Customer, Order, Employee |
| INSERT | Sample data |
| INNER JOIN | Q1 |
| LEFT JOIN | Q2 |
| RIGHT JOIN | Q3 |
| UNION | Q4 |
| Subquery | Q5, Q6 |
| AVG() | Q5, Q6 |
| YEAR() | Q7 |
| MONTH() | Q7 |
| DATEDIFF() | Q8 |
| DATE_FORMAT() | Q9 |
| CONCAT() | Q10 |
| REPLACE() | Q11 |
| UPPER() | Q12 |
| LOWER() | Q12 |
| TRIM() | Q13 |
| SUM() OVER() | Q14 |
| RANK() OVER() | Q15 |
| CASE | Q16, Q17 |

---

# ▶️ How to Run the Project

## Step 1 – Open MySQL

Open MySQL Workbench or MySQL Command Line.

## Step 2 – Open `pro_2.sql`

Open the SQL file in your MySQL editor.

## Step 3 – Run the database and table creation section

Run the commands that create:

```text
project2
customer_table
order_table
employees_table
```

## Step 4 – Insert the sample data

Execute the INSERT statements.

## Step 5 – Run the queries

Execute Q1 through Q17 individually to understand each SQL concept.

---

# 📌 Recommended Execution Order

For easy understanding, follow this order:

```text
1. Create Database
        ↓
2. Create Tables
        ↓
3. Insert Data
        ↓
4. Understand Table Relationships
        ↓
5. Practice JOINs
        ↓
6. Practice Subqueries
        ↓
7. Practice Date Functions
        ↓
8. Practice String Functions
        ↓
9. Practice Window Functions
        ↓
10. Practice CASE Statements
```

---

# 🎯 Project Learning Outcomes

After completing this project, you should understand:

- How to create a MySQL database
- How to create tables with appropriate data types
- How to insert records
- How tables can be related through common columns
- How INNER, LEFT, and RIGHT JOINs work
- How `UNION` combines query results
- How subqueries work
- How aggregate functions such as `AVG()` and `SUM()` are used
- How to work with dates
- How to manipulate text
- How window functions work
- How to rank records
- How `CASE` can be used for conditional classification

---

# ⚠️ Important Notes

1. The SQL file contains `DROP TABLE IF EXISTS`, so existing tables with the same names can be removed when the setup is executed.
2. `customer_id` is the primary key of `customer_table`.
3. `order_id` is the primary key of `order_table`.
4. The queries use `customer_id` to match customers and orders.
5. Q8 uses `CURDATE()`, so its result changes depending on the date when the query is executed.
6. Q14 and Q15 use MySQL window-function syntax.
7. The project is designed primarily for MySQL.

---

# 📁 Files

```text
pro_2.sql
    ↓
Database creation + table creation
    ↓
Sample data
    ↓
17 SQL practice queries

README.md
    ↓
Project documentation
    ↓
Database structure
    ↓
Flowcharts
    ↓
Query explanations
    ↓
Learning outcomes
```

---

# 👨‍💻 Project Summary

This project is a practical SQL learning project covering database creation, data insertion, table relationships, JOINs, subqueries, date functions, string functions, window functions, ranking, and conditional logic.

The project starts with database and table creation and gradually moves toward more advanced SQL operations. The flowcharts in this README show how the tables and queries are connected, making the project easier to understand before running the SQL commands.

---

## ✅ End of Project Documentation
