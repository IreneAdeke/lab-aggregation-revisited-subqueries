use sakila; 
# 1. Select the first name, last name, and email address of all the customers who have rented a movie.
select * from customer; 
select * from rental; 

select first_name, last_name, email from customer c
join rental r
on c.customer_id = r.customer_id
group by c.customer_id
order by c.customer_id; 

# 2. What is the average payment made by each customer (display the customer id, customer name (concatenated),
 #and the average payment made).
 select * from payment; 
 select * from customer;
 
 select c.customer_id, concat(first_name, ' ', last_name) as Full_name, round(avg(amount), 2) as average_payment 
 from customer c
 join payment p
 on p.customer_id = c.customer_id
 group by c.customer_id
 order by Full_name asc; 
 
 # 3. Select the name and email address of all the customers who have rented the "Action" movies.

# using multiple joins
select * from customer; -- name and email
select * from rental; -- customer id
select * from category; 
select * from film_category;
select * from inventory; 
select * from film;
select * from inventory; 
select * from category; 

select concat(first_name, " ", last_name) as full_name, email 
from customer c
join rental r
on r.customer_id = c.customer_id 
join inventory using(inventory_id) 
join film using(film_id) 
join film_category using(film_id)
join category using(category_id)
where category.name = "Action";


# using sub queries with multiple WHERE clause and IN condition
 
select concat(first_name, " ", last_name) as full_name, email 
from customer where customer_id in 
(select customer_id from rental where inventory_id in 
 (select inventory_id from inventory where film_id in
  (select film_id from film_category 
  join category using(category_id) where category.name="Action"))); 
  
  #Output from using subqueries and multiple joins is the same!
  
  

# 4. Use the case statement to create a new column classifying existing columns as either low or high value 
#transactions based on the amount of payment. If the amount is between 0 and 2, 
#label should be low and if the amount is between 2 and 4, the label should be medium, and if it is more than 4, then it should be high.
select * from payment; 

select payment_id, customer_id, staff_id, rental_id, amount, payment_date, last_update,
case
when amount between 0 and 2 then "low"
when amount between 2 and 4 then "medium"
when amount > 4 then "high"
end as "Amount Classification"
from payment 
where amount is not null
order by payment_id;

