/*
=================================================
        Exercise 4 : Sub-Queries
=================================================
a subquery is when you calculate the query before
using its results to make another result, there is
the nested and correlated subqueries.
=================================================
*/

USE base5;

CREATE TABLE IF NOT EXISTS table_a (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name_a VARCHAR(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS table_b (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name_b VARCHAR(50) NOT NULL,
    value_b DECIMAL(10,2),
    fk_id INT
);

TRUNCATE TABLE table_a;
TRUNCATE TABLE table_b;

INSERT INTO table_a (name_a) VALUES ('category 1'), ('category 2'), ('category 3');

INSERT INTO table_b (name_b, value_b, fk_id) VALUES 
('item 1', 50.00, 1),
('item 2', 150.00, 2),
('item 3', 300.00, 2),
('item 4', 25.00, 1),
('item 5', 10.00, NULL);

SELECT name_b, value_b 
FROM table_b 
WHERE value_b > (SELECT AVG(value_b) FROM table_b /* subquery computes AVG(value_b) across all rows */ ); -- nested subquery, the result of the average of table 2 is used to calculate if the value is above the average
-- creates a result that shows items if their value is above the average

SELECT name_a
FROM table_a a
WHERE EXISTS (SELECT 1 FROM table_b b WHERE b.fk_id = a.id AND b.value_b >= 100); -- correlated subquery, find records in table_a that have related values ≥ 100 in table_b
-- displays category wich contains items wich same id in 2 tables and a value of equal or above 100.

/*
========================== * // * ==============================

A good example of a nested subquery is a company identifying
employees who sold above the average.

example data :
John (50), Enzo (150), Carla (300), Robert (25), Nick (10)

Step 1: calculate the average
*/

SELECT AVG(emp_sold) FROM employee_table;

/*
Average = 107

Step 2: filter employees above average
*/

SELECT emp_name, emp_sold, emp_id
FROM employee_table
WHERE emp_sold > (SELECT AVG(emp_sold)FROM employee_table);

/*
Result:
Enzo (150)
Carla (300)

* The subquery calculates the average (107)
* The main query returns only employees with sales above it

-- Note: in real scenarios, sales are usually stored in a separate table,
-- requiring SUM() and GROUP BY instead of direct comparison.

========================== * // * ==============================

One example of a correlated subquery could be a bank, and its checking
for any kind of fraud, maintaining every transaction safe.
example data :

--authenticator table with category and id (identified as a)
category 1, 12[...]
category 2 45[...]
category 3 78[...]

--person table with name, face scan, validation date and id (identified as p)

cailan; face scan = cailan and validation date = 21/29; 12, (category 1)
agotanni; face scan = agotanni and validation date = 11/21; 45 (category 2)
gabriel; face scan = romero and validation date = 06/44; 78 (category 3)

step 1 : filter the poeple in the category for those who have an
identicalid in both tables and an validation date below the shown
*/

SELECT 1 FROM person_table p WHERE p.fk_id = a.id AND p.person_validation >= 20/26
/*

agottani and gabriel is out

step 2 : select the category who has a identified person
*/
        
SELECT a.category_name
FROM authenticator a
WHERE EXISTS (SELECT 1 FROM person_table p WHERE p.category_id = a.id AND p.face_scan = p.name AND p.validation_date > CURRENT_DATE);
/*
result = category 1

========================== * // * ==============================
*/
