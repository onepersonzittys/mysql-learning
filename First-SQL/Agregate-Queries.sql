USE base2

TRUNCATE TABLE table2;

-- insert items into the table
INSERT INTO table2 (name, active, value1, value2) VALUES
('item 1', 'no', 56, 10),
('item 2', 'yes', 89, 8),
('item 3', 'no', 22, 5),
('item 4', 'yes', 68, 9),
('item 5', 'no', 12, 4),
('item 1', 'yes', 100, 10),
('item 2', 'yes', 69, 2),
('item 3', 'yes', 12, 1),
('item 4', 'no', 18, 10),
('item 5', 'no', 1, 0);

-- Ordes based on values and active boolean
SELECT
    COUNT(CASE WHEN active = 'yes' THEN 1 END) AS 'active Yes',
    COUNT(CASE WHEN active = 'no' THEN 1 END) AS 'active No',
    SUM(value1) AS 'Total value',
	AVG(value2) AS '0/10',
	MIN(value1) AS 'minimal value',
	MAX(value1) AS 'max value'
FROM table2;
	
	

