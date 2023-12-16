use mavenmovies

 /* Basic Aggregate Functions: 
 Question 1: 
Retrieve the total number of rentals made in the Sakila database. 
Hint: Use the COUNT() function. */

select  count(rental_id) as total_rental_count from rental;

/* Question 2: 
Find the average rental duration (in days) of movies rented from the Sakila database.
Hint: Utilize the AVG() function. */

select avg(datediff(last_update,rental_date)) as average_sduration_days from rental;

/* String Functions: 
Question 3: 
Display the first name and last name of customers in uppercase. 
Hint: Use the UPPER () function. */

select upper(first_name), upper(last_name)from customer;

/* Question 4: 
Extract the month from the rental date and display it alongside the rental ID. 
Hint: Employ the MONTH() function. */

select rental_id, month(rental_date) as rental_month from rental;

/* GROUP BY
 Question 5: 
Retrieve the count of rentals for each customer (display customer ID and the count of rentals). 
Hint: Use COUNT () in conjunction with GROUP BY. */


select customer_id, count(rental_id) as total_rentals from rental
group by customer_id

/* Question 6: 
Find the total revenue generated by each store. 
Hint: Combine SUM() and GROUP BY.  */

select*from payment;-- amount,customer_id
select*from customer;  -- customer_id,store_id

select store_id,sum(amount)
from payment p
join customer c
on p.customer_id=c.customer_id
group by store_id


/* JOIN
 Question 7: Display the title of the movie, customer's first name, and last name who rented it. 
Hint: Use JOIN between the film, inventory, rental, and customer tables.  */


select  first_name,last_name,title
from film f
join inventory i
on  f.film_id=i.film_id
join rental r
on i.inventory_id=r.inventory_id
join customer c
on r.customer_id=c.customer_id

/*Question 8: 
Retrieve the names of all actors who have appeared in the film "Gone with the Wind." 
Hint: Use JOIN between the film actor, film, and actor tables*/

select first_name,last_name,title
from  actor a
join film_actor b
on  a.actor_id=b.actor_id
join film c
on b.film_id=c.film_id
where title ='Gone with the Wind'


/* group by
Question 1: 
Determine the total number of rentals for each category of movies. 
Hint: JOIN film_category, film, and rental tables, then use cOUNT () and GROUP BY. */

select category_id, count(rental_id)
from
film_category fa
join inventory i
on fa.film_id=i.film_id
join rental r
on i.inventory_id=r.inventory_id
group by category_id

/* Question 2: 
Find the average rental rate of movies in each language. 
Hint: JOIN film and language tables, then use AVG () and GROUP BY. */


select name ,avg(rental_rate)
from film f
join language l
on f.language_id=l.language_id
group by f.language_id


/* join
Question 3: 
Retrieve the customer names along with the total amount they've spent on rentals. 
Hint: JOIN customer, payment, and rental tables, then use SUM() and GROUP BY. */

select first_name,last_name, sum(amount) as rental_amount
from customer c
join payment p
on c.customer_id=p.customer_id
join rental r
on r.customer_id=p.customer_id
group by p.customer_id

/*Question 4: 
List the titles of movies rented by each customer in a particular city (e.g., 'London'). 
Hint: JOIN customer, address, city, rental, inventory, and film tables, then use GROUP BY. */

select title,c.customer_id,  ci.city
from film f 
join inventory i
on f.film_id=i.film_id 
join rental r
on i.inventory_id=r.inventory_id 
join customer c
on c.customer_id=r.customer_id 
join address a
on c.address_id=a.address_id 
join city ci
on a.city_id=ci.city_id

/*advance join and group by
Question 5: 
Display the top 5 rented movies along with the number of times they've been rented. 
Hint: JOIN film, inventory, and rental tables, then use cOUNT() and GROUP BY, and limit the results. */

select title,count(rental_id)  rental_count
from film f
join inventory i
on f.film_id=i.film_id
join rental r
on r.inventory_id=i.inventory_id
group by title
order by rental_count desc
limit 5



/*Question 6: 
Determine the customers who have rented movies from both stores (store ID 1 and store ID 2). 
Hint: Use JOINS with rental, inventory, and customer tables and consider COUNT() and GROUP BY. */


select distinct c.customer_id, first_name,last_name,i.store_id
from rental r
join inventory i
on r.inventory_id=i.inventory_id
join customer c
on i.store_id=c.store_id
where i.store_id in ('1','2')


