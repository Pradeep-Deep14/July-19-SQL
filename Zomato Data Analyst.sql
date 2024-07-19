CREATE TABLE cities (
    city_id SERIAL PRIMARY KEY,
    city_name VARCHAR(50)
);

CREATE TABLE restaurants (
    restaurant_id SERIAL PRIMARY KEY,
    restaurant_name VARCHAR(100),
    city_id INT,
    FOREIGN KEY (city_id) REFERENCES cities(city_id)
);


CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    restaurant_id INT,
    order_value DECIMAL(10, 2),
    order_date DATE,
    rating INT CHECK (rating >= 1 AND rating <= 5),
    FOREIGN KEY (restaurant_id) REFERENCES restaurants(restaurant_id)
);

INSERT INTO cities (city_name) VALUES
('Mumbai'),
('Delhi'),
('Bengaluru');

INSERT INTO restaurants (restaurant_name, city_id) VALUES
('Bademiya', 1),
('Bombay Canteen', 1),
('Trishna', 1),
('Karims', 2),
('Indian Accent', 2),
('Bukhara', 2),
('Toit', 3),
('Koshys', 3),
('MTR', 3);

INSERT INTO orders (restaurant_id, order_value, order_date, rating) VALUES
(1, 500.00, '2024-01-01', 4),
(1, 450.00, '2024-01-02', 5),
(1, 550.00, '2024-01-03', 4),
(2, 300.00, '2024-01-01', 3),
(2, 350.00, '2024-01-02', 4),
(2, 250.00, '2024-01-03', 3),
(3, 700.00, '2024-01-01', 5),
(3, 750.00, '2024-01-02', 4),
(3, 800.00, '2024-01-03', 5),
(4, 400.00, '2024-01-01', 4),
(4, 500.00, '2024-01-02', 5),
(4, 450.00, '2024-01-03', 4),
(5, 600.00, '2024-01-01', 5),
(5, 550.00, '2024-01-02', 4),
(5, 650.00, '2024-01-03', 5),
(6, 900.00, '2024-01-01', 5),
(6, 850.00, '2024-01-02', 5),
(6, 950.00, '2024-01-03', 4),
(7, 400.00, '2024-01-01', 3),
(7, 450.00, '2024-01-02', 4),
(7, 500.00, '2024-01-03', 3),
(8, 1000.00, '2024-01-01', 5),
(8, 1050.00, '2024-01-02', 4),
(8, 1100.00, '2024-01-03', 5),
(9, 800.00, '2024-01-01', 5),
(9, 850.00, '2024-01-02', 4),
(9, 900.00, '2024-01-03', 5);


SELECT * FROM cities;
SELECT * FROM restaurants;
SELECT * FROM orders;


-- -- Interview Question

-- Write a SQL query to find the top 2 restaurants in each city with the highest average rating. 
-- return city_id, city_name, restaurant id, restaurant_name and avg_rating

WITH CTE AS
(
SELECT c.CITY_ID,
	   c.CITY_NAME,
       r.RESTAURANT_ID,
       r.RESTAURANT_NAME,
       AVG(o.rating),
       DENSE_RANK()OVER (PARTITION BY C.CITY_NAME ORDER BY AVG(o.rating) DESC) AS DRNK
FROM CITIES c
JOIN restaurants r on c.CITY_ID=r.CITY_ID
JOIN ORDERS o on o.RESTAURANT_ID=r.RESTAURANT_ID
GROUP BY 1,2,3,4
)
SELECT DISTINCT * FROM CTE WHERE DRNK<=2
