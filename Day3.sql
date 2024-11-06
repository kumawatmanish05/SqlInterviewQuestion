-- we need to identify numbers that appear at least three times consecutively in a table. 
-- Indium (Medium-level) Interview Question

CREATE TABLE logs (
    id INT PRIMARY KEY,
    num INT
);
INSERT INTO logs (id, num) VALUES
(1, 1),
(2, 1),
(3, 1),
(4, 2),
(5, 1),
(6, 2),
(7, 2);

SELECT * FROM logs;

SELECT 
	DISTINCT 
	l1.num as consecutive_nums
	FROM logs as l1,logs as l2,logs as l3
	WHERE l1.id=l2.id-1
	AND l2.id=l3.id-1
	AND l1.num=l2.num
	AND l2.num=l3.num;