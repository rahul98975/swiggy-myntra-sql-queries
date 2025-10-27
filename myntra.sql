use myntra;

-- 1. Show all data of the table 
select * from myntra;

-- 2. Number of total rows in the table
select count(*) as total_rows from myntra;

-- 3. Show only product_name, brand_name, and discounted_price 
select product_name, brand_name,discounted_price from myntra;

-- 4. Retrieve all products with a rating greater than 4
select * from myntra where rating > 4;

-- 5. Find products that have a discounted_price greater than 999
select * from myntra where discounted_price > 999;

-- 6. Show products from the brand Levis 
select * from myntra where brand_name = 'Levis';

-- 7. Find products whose product_tag is 'Shirt' or 'T-shirt'
select * from myntra where product_tag = 'Shirts' or product_tag = 'tshirts' ;

-- 8. Show products from the brand Roadster with jeans product tag
select * from myntra where brand_name = 'Roadster' and product_tag = 'jeans' ;

-- 9.Show products from the brand Roadster and Nike with jeans product tag | with rating greater than 4.5 and amount less than 1000
select * from myntra where (brand_name in ('Roadster' , 'Nike') and product_tag = 'jeans' )  and rating > 4.5 and discount_amount < 1000;

-- 10. List all unique brands available on Myntra
select distinct brand_name as unique_brands from myntra ;

-- 11. Total number of unique brands on Myntra
select count( distinct brand_name) as total_brands from myntra;

-- 12. Unique Products served by Adidas
select distinct(product_tag), brand_name from myntra where brand_tag = 'Adidas';

-- 13. Number of unique products served by Adidas
select count(distinct(product_tag)) from myntra where brand_tag = 'Adidas';

-- 14. Select every product discounted_price between 3000 and 5000 except Adidas and Puma
select product_name, product_tag, brand_tag, discounted_price from myntra
where brand_tag not in ('Adidas', 'Puma') and discounted_price between 3000 and 5000;

-- 15. Find the products where the product name starting with s
select *from myntra where product_name like 's%' ;

-- 16. Find the products where the brand name contains 'ad' 
select *from myntra where brand_name like '%ad%' ;

-- 17. Find the products where the brand name is exactly of 6 cahracters long
select *from myntra where brand_name like '______' ;

-- 18. Find the products where the second character of the brand name is s
select *from myntra where brand_name like '_s%' ;

-- 19. Display all products where sizes include 'XL'
select * from myntra where sizes = 'XL';

-- 20. Sort all products by discounted_price in ascending order.
select * from myntra order by discounted_price asc;

-- 21. Show top 10 products with the highest rating_count
select * from myntra order by rating_count desc limit 10;

-- 22.Create new column with mathematical functions | Making Discount Percentage
select product_name, brand_name , round(((marked_price - discounted_price)/marked_price)*100,2) as discounted_percentage from myntra;

-- 23. Find the average rating of all products
select  round(avg(rating) ,2) as avg_rating from myntra;

-- 24. Count how many products belong to each brand
select brand_tag, count(product_tag) from myntra group by brand_tag;

-- 25. Display the average discounted_price grouped by product_tag.
select product_tag , round(avg(discounted_price),2) as avg_price
from myntra
group by product_tag;

-- 26. Finding the top 5 brand who sold the most number of products
select brand_tag, sum(rating_count)  as 'products_sold' from myntra 
group by brand_tag
order by products_sold desc limit 5;

-- 27. Find brands having an average rating greater than 4.2.
select brand_name,round(avg(rating), 2) as avg_rating
from myntra
group by brand_name
HAVING avg(rating) > 4.2
order by  avg_rating desc;

-- 28. Get the total discount amount offered by each brand.
select brand_name , sum(discounted_price) as total_discount
from myntra
group by brand_name;


-- 29. Finding the top 5 brand who has the most number of products 
select brand_tag, count(product_tag)  as products 
from myntra 
group by brand_tag
order by products desc limit 5;

-- 30. Show the most expensive product (based on marked_price).
select  product_name,brand_name,marked_price,discounted_price,discount_percent from myntra
where marked_price = (select  max(marked_price) 
        from myntra);

-- 31. Brand Report Card
select brand_tag, 
	sum(rating_count) as 'people_rated',
    min(marked_price) as 'min_mar_price',
    avg(marked_price) as 'avg_mar_price',
    max(marked_price) as 'max_mar_price' 
from myntra group by brand_tag;

-- 32. Which product_category of any brand is sold the most?
select brand_tag, product_tag, sum(rating_count) as 'people_rated' from myntra 
group by brand_tag, product_tag
order by people_rated desc limit 10;

-- 33. Most popular product name listed in Myntra
select product_name ,count(product_name) as 'name_count' from myntra 
group by product_name 
order by name_count desc limit 10;

-- 34. Find the average rating for each product category (product tag) along with the number of products and total rating count
select product_tag, avg(rating) as 'avg_rating', count(*) as 'total_products', sum(rating_count) as 'total_rating_count'
from myntra
group by product_tag
order by avg_rating asc;

-- 35. Find the brand with the highest average rating among products with a discounted price greater than 5000
select brand_tag, avg(rating) as 'avg_rating', sum(rating_count)
from myntra
where discounted_price > 5000
group by brand_tag
order by avg_rating desc;

-- 36. Show products that have rating_count > 1000 and discount_percent > 40.
select product_name,brand_name,rating,rating_count,marked_price,discounted_price,discount_percent
from myntra
where rating_count > 1000 and discount_percent > 40
order by   discount_percent desc, rating_count desc;

-- 37. Retrieve products that do not have any discount (discount_amount = 0).
select product_name,brand_name,marked_price,discounted_price,discount_amount,discount_percent
from myntra_products
where discount_amount = 0
order by marked_price desc;

-- 38. Display all brands having more than 10 products rated above 4.5.
select brand_name,
COUNT(*) as high_rated_products
from myntra
where rating > 4.5
group by brand_name
HAVING COUNT(*) > 10
order by high_rated_products desc;






















