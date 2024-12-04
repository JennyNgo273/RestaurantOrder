USE restaurant_db;

SELECT *
FROM menu_items;

-- OBJECTIVE 1
/*1. View the menu_items table and write a query to find the number of items on the menu*/
SELECT 
	COUNT(DISTINCT menu_item_id) number_of_items
FROM menu_items;

SELECT COUNT(*)
FROM menu_items; 


/*2. What are the least and most expensive items on the menu?*/
SELECT 
	MIN(price),
	MAX(price)
FROM menu_items;

SELECT
	menu_item_id, 
    item_name,
    price
FROM menu_items
ORDER BY price DESC;


/*3. How many Italian dishes are on the menu? What are the least and most expensive Italian dishes on the menu?*/
SELECT 
	COUNT(category) AS no_Italian_dishes, 
    MIN(price),
    MAX(price)
FROM menu_items
WHERE category = 'Italian';

/*4. How many dishes are in each category? What is the average dish price within each category?*/
SELECT 
	 category,
    COUNT(menu_item_id) AS no_dishes, 
    AVG(price)
FROM menu_items
GROUP BY category;

-- OBJECTIVE 2
/* 1. View the order_details table. What is the date range of the table? */
SELECT * 
FROM order_details;

SELECT MIN(order_date), MAX(order_date)
FROM order_details;

/* 2. How many orders were made within this date range? How many items were ordered within this date range? */
SELECT 
	COUNT(DISTINCT order_id)
FROM order_details;

SELECT 
	COUNT(order_details_id)
FROM order_details;

/* 3. Which orders had the most number of items? */
SELECT 
	order_id, 
    COUNT(order_id) 
FROM order_details
GROUP BY order_id
Order By COUNT(order_id)  DESC;


/* 4. How many orders had more than 12 items?*/
SELECT COUNT(*)
FROM
	(SELECT 
		order_id, 
		COUNT(item_id) 
	FROM order_details
	GROUP BY order_id
		HAVING COUNT(item_id) > 12) AS num_orders;

-- OBJECTIVE 3
/* 1. Combine the menu_items and order_details tables into a single table */
SELECT * 
FROM order_details 
	LEFT JOIN menu_items
		ON order_details.item_id = menu_items.menu_item_id;

/* 2. What were the least and most ordered items? What categories were they in? */
SELECT 
	DISTINCT(item_id), 
    COUNT(item_id),
    item_name,
    menu_items.category
FROM order_details
	LEFT JOIn menu_items
		ON order_details.item_id = menu_items.menu_item_id
GROUP BY item_id
ORDER BY  COUNT(item_id) DESC;

/* 3. What were the top 5 orders that spent the most money? */
SELECT 
	order_id, 
    SUM(price) AS total_spend
FROM order_details
	LEFT JOIn menu_items
		ON order_details.item_id = menu_items.menu_item_id
GROUP BY order_id
ORDER BY total_spend DESC
LIMIT 5;

/* 4. View the details of the highest spend order. Which specific items were purchased? */
SELECT 
	order_id, 
    SUM(price),
    item_name
FROM order_details
	LEFT JOIn menu_items
		ON order_details.item_id = menu_items.menu_item_id
GROUP BY order_id, item_name
	HAVING order_id = 440;
    
/* 5. View top 5  highest spend order Which specific items were purchased? */

SELECT 
	order_id,
	category,
    COUNT(item_id) AS num_items
FROM order_details
	LEFT JOIn menu_items
		ON order_details.item_id = menu_items.menu_item_id
WHERE order_id IN (440, 2075, 1957, 330, 2675)
GROUP BY order_id, category;


