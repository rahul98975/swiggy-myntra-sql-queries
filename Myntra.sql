use gfg;

select * from data;
select count(*) as total_rows from data;
-- ----------------------------------------------------------
select product_name, brand_name,discounted_price from data;
-- ----------------------------------------------------------
select product_name, brand_name , marked_price - discounted_price as discounted_amount from data;
-- ----------------------------------------------------------
select product_name, brand_name , rating_count * rating from data;
-- ----------------------------------------------------------------
select product_name, brand_name , round(((marked_price - discounted_price)/marked_price)*100,2) as discounted_percentage from data;
-- ---------------------------------------------------------------------------------------
select distinct (brand_name) as unique_brand from data;
select count(distinct (brand_name)) total_brands from data;
 -- --------------------------------------------------------------------------------------
select product_name , brand_name, discounted_price, product_tag from data where brand_name = 'roadster' and product_tag = 'jeans';
-- ------------------------------------------------------------------------------------------
select count(distinct(product_tag)) from data where brand_tag = 'Adidas';
select distinct(product_tag) from data where brand_tag = 'roadster';
select * from data where brand_name like '_s%';

-- Aggregate functions 
select count(*) as total_prod from data;

select avg(discounted_price) as avg_price from data;
select avg(marked_price) as avg_price from data;

select min(discounted_price) d_price from data;
select min(marked_price) as m_price from data;

select max(discounted_price) d_price from data;
select max(marked_price) as m_price from data;

select product_name,brand_tag,marked_price,discounted_price from data where marked_price = 50;

SELECT sum(rating_count) as total_rating FROM data ;
select distinct brand_name from data;

select count(distinct brand_name) as total_brands from data;

-- Grouping and filtering data
select distinct brand_name from data;

select count(distinct brand_name) as Total_brands from data;

select brand_tag, count(product_tag) from data group by brand_tag;

select 
