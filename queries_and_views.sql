				/*How many parts did JRR buy?*/
/*
select
	first_name,
	last_name,
	orders_item.quantity
from customer
Inner Join orders on customer.account_number = orders.account_number
inner join orders_item on orders_item.order_id = orders.order_id
where customer.first_name = 'JRR';
*/


				/*How many people own luxury cars?*/
/*
select count(customer_vehicle.account_number)
from customer_vehicle
inner join vehicle on vehicle.unique_vehicle_id = customer_vehicle.unique_vehicle_id
where vehicle_type = 'Luxury';
*/



				/*How many unique BMW parts does the store carry?*/
/*
select make, sum(inventory.quantity) as Quantity
from vehicle
inner join vehicle_part_reference_id on vehicle_part_reference_id.unique_vehicle_id = vehicle.unique_vehicle_id
inner join part on vehicle_part_reference_id.part_number = part.part_number
inner join inventory on inventory.part_number = part.part_number
where make = 'BMW'
group by make;
*/


					/* View*/

				/*What is the total value of the inventory*/

Drop view if exists inventory_overhead;
Create View inventory_overhead as 
select 
	sum(inventory.quantity * pricing.price) as "Total Value"
From inventory
inner join part on part.part_number = inventory.part_number
inner join pricing on pricing.part_number = part.part_number;

select *
from inventory_overhead;
*/

					/*Cube*/
						
		/* Breakdown the quantity of inventory by the make and vehicle type.*/
/*
select 
	vehicle.vehicle_type,
	vehicle.make,
	sum(inventory.quantity)
from vehicle
	inner join vehicle_part_reference_id on vehicle_part_reference_id.unique_vehicle_id = vehicle.unique_vehicle_id
	inner join part on part.part_number = vehicle_part_reference_id.part_number
	inner join inventory on inventory.part_number = part.part_number
group by 
	cube (vehicle.vehicle_type, vehicle.make) 
order by 
	vehicle.vehicle_type, vehicle.make;
	
*/