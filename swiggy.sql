select * from swiggy.restaurants;

-- 1. Which restaurant of Agra city is visied by least number of people?
select * from restaurants where city = 'Agra' and rating_count = (select min(rating_count) from restaurants where city = 'Agra');

-- 2. Which restaurant has generated maximum revenue all over india?
select * from restaurants where cost*rating_count = (select max(cost*rating_count) from restaurants);

-- 3. How many restaurants are having rating more than the average rating?
select * from restaurants where rating > (select avg(rating) from restaurants);

-- 4. Which restaurant of Delhi has generated most revenue?
select * from restaurants where city = 'Delhi' and 
cost*rating_count = (select max(cost*rating_count) from restaurants where city = 'Delhi');

-- 5. Which restaurant chain has maximum number of restaurants?
select name , count(name) as 'no_of_chains' from restaurants
group by name order by count(name) desc limit 10;

-- 6. Which restaurant chain has generated maximum revenue?
select name , sum(rating_count * cost) as 'revenue' from restaurants
group by name order by sum(rating_count*cost) desc limit 10;

-- 7. Which city has maximum number of restaurants?
select city , count(*) as 'no_of_restaurants' from restaurants
group by city order by count(*) desc limit 10;

-- 8. Which city has generated maximum revenue all over india?
select city , sum(rating_count * cost) as 'revenue' from restaurants
group by city order by sum(rating_count*cost) desc limit 10;

-- 9. List 10 least expensive cuisines?
select cuisine ,  avg(cost) as 'avg_cost' from restaurants
group by cuisine 
order by avg_cost asc limit 10;

-- 10. List 10 most expensive cuisines?
select cuisine ,  avg(cost) as 'avg_cost' from restaurants
group by cuisine 
order by avg_cost desc limit 10;

-- 11. What is the city is having Biryani as most popular cuisine
select city, avg(cost), count(*) as 'restaurants' from restaurants
where cuisine = 'Biryani'
group by city
order by restaurants desc;

-- 12. List top 10 unique restaurants with unique name only thorughout the dataset as per generate maximum revenue (Single restaurant with that name)
select name, sum(cost * rating_count) as 'revenue' from restaurants 
group by name having count(name) = 1
order by revenue desc limit 10;

-- 13. Create column containing average, min, max of cost,rating,rating_count of restaurants throught the dataset
select id, name, city, cuisine, rating,
	round(max(rating) over(), 2) as 'max_rating',
    round(avg(rating) over(), 2) as 'avg_rating',
    round(min(rating) over(), 2) as 'min_rating',
    
    round(max(cost) over(), 2) as 'max_cost',
    round(avg(cost) over(), 2) as 'avg_cost',
    round(min(cost) over(), 2) as 'min_cost'
    
from restaurants;

-- 14. Create column containing average cost of the cuisine which that specific restaurant is serving
select *, round(avg(cost) over( partition by cuisine) ) as 'avg_cost' from restaurants;

-- 15. Create both column together
select *, 
	round(avg(cost) over( partition by city) ) as 'avg_cost_city',
    round(avg(cost) over( partition by cuisine) ) as 'avg_cost_cuisine'
from restaurants;

-- 16. List the restaurants whose cost is more than the average cost of the restaurants?
select * from restaurants where cost > (select avg(cost) from restaurants);
select * from (select *, avg(cost) over() as 'avg_cost' from restaurants) t where t.cost > t.avg_cost; 


-- 17. List the restaurants whose cuisine cost is more than the average cost?
select * from (select *, avg(cost) over(partition by cuisine) as 'avg_cost' from restaurants) t where t.cost > t.avg_cost; 

-- 18. Rank every restaurant from most expensive to least expensive
select * ,rank() over(order by cost desc) as 'rank' from restaurants;

-- 19. Rank every restaurant from most visited to least visited
select * ,rank() over(order by rating_count desc) as 'rank' from restaurants;

-- 20. Rank every restaurant from most expensive to least expensive as per their city
select * ,rank() over(partition by city order by cost desc) as 'rank' from restaurants;

-- 21. Dense-rank every restaurant from most expensive to least expensive as per their city
select * ,
	rank() over(order by cost desc) as 'rank' ,
	dense_rank() over(order by cost desc) as 'dense_rank' 
from restaurants;

-- 22. Row-number every restaurant from most expensive to least expensive as per their city
select * ,
	rank() over(order by cost desc) as 'rank' ,
	dense_rank() over(order by cost desc) as 'dense_rank',
    row_number() over(order by cost desc) as 'row_number' 
from restaurants;

-- 23. Rank every restaurant from most expensive to least expensive as per their city along with its city [Adilabad - 1, Adilabad - 2]
select *, concat(city,' - ' ,row_number() over(partition by city order by cost desc)) as 'rank' from restaurants;

-- 24. Find top 5 restaurants of every city as per their revenue
select * from (select *, 
				cost*rating_count as 'revenue', 
				row_number() over(partition by city order by rating_count*cost desc) as 'rank' from restaurants) t
where t.rank < 6;

-- 25. Find top 5 restaurants of every cuisine as per their revenue
select * from (select *, 
				cost*rating_count as 'revenue', 
				row_number() over(partition by cuisine order by rating_count*cost desc) as 'rank' from restaurants) t
where t.rank < 6;

-- 26. List the top 5 cuisines as per the revenue generated by top 5 restaurants of every cuisine
select cuisine, sum(rating_count*cost) as 'revenue'from 	
( 	select *, cost*rating_count, 
	row_number() over(partition by cuisine order by cost*rating_count desc) as 'rank'
    from restaurants
) t 
where t.rank < 6
group by cuisine
order by revenue desc;

-- 27. What is the of the total revenue is generated by top 1% restaurants
select sum(cost*rating_count) as 'revenue' from
	(select *, cost*rating_count, row_number() over(order by cost*rating_count desc) as 'rank'
		from restaurants) t
	where t.rank <= 614;

-- 28. Check the same for top 20% restaurants
select sum(cost*rating_count) as 'revenue' from
	(select *, cost*rating_count, row_number() over(order by cost*rating_count desc) as 'rank'
		from restaurants) t
	where t.rank <= 12280;


-- 29. What % of revenue is generated by top 20% of restaurants with respect to total revenue?
with 
	q1 as (select sum(cost*rating_count) as 'top_revenue' from
			(select *, cost*rating_count, row_number() over(order by cost*rating_count desc) as 'rank'
				from restaurants) t
			where t.rank <= 12280),
	q2 as (select sum(cost*rating_count) as 'total_revenue' from restaurants)
    
select (top_revenue/total_revenue)*100 as 'revenue %' from q1,q2;
