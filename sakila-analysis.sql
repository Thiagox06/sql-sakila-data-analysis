-- Total Revenue Per Month
SELECT 
    DATE_FORMAT(payment_date, '%Y-%m') AS month,
    ROUND(SUM(amount), 2) AS total_revenue
FROM 
    payment
GROUP BY 
    month
ORDER BY 
    month;
    

-- Top 10 Movies Rented
SELECT 
	f.title,
	count(rental_id) AS times_rented
FROM 
	rental r
JOIN 
	inventory i ON i.inventory_id = r.inventory_id
JOIN 
	film f ON i.film_id = f.film_id
GROUP BY 
	f.title
ORDER BY 
	times_rented DESC
LIMIT 10;


-- Top 10 Customers by Total Spending
SELECT 
    CONCAT(c.first_name, ' ', c.last_name) AS name,
    SUM(p.amount) AS total_paid
FROM 
    payment p
JOIN 
    customer c ON c.customer_id = p.customer_id
GROUP BY 
    c.customer_id, name
ORDER BY 
    total_paid DESC
LIMIT 10;


-- Revenue by Film Category
SELECT 
    c.category_id,
    c.name,
    SUM(p.amount) AS revenue
FROM 
    payment p
JOIN 
    rental r ON r.rental_id = p.rental_id
JOIN 
    inventory i ON i.inventory_id = r.inventory_id
JOIN 
    film f ON i.film_id = f.film_id
JOIN 
    film_category fc ON f.film_id = fc.film_id
JOIN 
    category c ON fc.category_id = c.category_id
GROUP BY 
    c.category_id, c.name
ORDER BY 
    revenue DESC;


-- Store Performance Comparison
SELECT 
    i.store_id,
    COUNT(r.rental_id) AS rentals,
    ROUND(SUM(p.amount), 2) AS total_revenue
FROM 
    payment p
JOIN 
    rental r ON p.rental_id = r.rental_id
JOIN 
    inventory i ON r.inventory_id = i.inventory_id
GROUP BY 
    i.store_id
ORDER BY 
    total_revenue DESC;
