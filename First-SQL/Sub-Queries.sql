/*
=================================================
        Exercise 4 : Sub-Queries
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
FROM table_a 
WHERE id IN (SELECT fk_id FROM table_b WHERE value_b >= 100 /* returns the id of every items whose value's above 100 */); -- shows the category if they have an item that has a value of 100 or above
-- displays a category if an item within value is equal or above 100.
