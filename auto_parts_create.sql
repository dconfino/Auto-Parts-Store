Drop Table If Exists Customer cascade;
Create Table Customer (
	customer_id serial primary key,
	account_number serial unique not null,
	first_name VARCHAR (50) not null,
	last_name VARCHAR (50) not null,
	address VARCHAR (50) not null,
	zip bigint not null,
	phone_number bigint unique,
	email VARCHAR (50) unique,
	populated_on TIMESTAMP not null
	);
	
Drop Table If Exists vehicle cascade;
Create Table vehicle (
	vehicle_id serial primary key,
	unique_vehicle_id serial unique not null,
	vehicle_type Varchar (50) not null,
	make Varchar (50) not null,
	model Varchar (50) not null,
	year bigint not null,
	trim Varchar (50) not null,
	color Varchar (50) not null,
	populated_on TIMESTAMP not null
);

Drop Table If Exists orders cascade;
Create Table orders (
	order_id serial primary key,
	account_number bigint not null references customer(account_number),
	populated_on TIMESTAMP not null
);

Drop Table If Exists customer_vehicle cascade;
Create Table customer_vehicle (
	customer_vehicle_id serial not null primary key,
	account_number bigint not null  references customer(account_number),
	unique_vehicle_id bigint not null references vehicle(unique_vehicle_id),
populated_on TIMESTAMP not null
);

Drop Table If Exists vehicle_part_reference_id cascade;
Create Table  vehicle_part_reference_id (
	vehicle_part_reference_id serial not null primary key,
	unique_vehicle_id bigint unique not null,
	part_number bigint unique not null,
	populated_on TIMESTAMP not null
);

Drop Table If Exists orders_item cascade;
Create Table  orders_item (
	orders_item_id serial not null primary key,
	order_id bigint not null references orders(order_id),
	part_number bigint not null references part(part_number),
	quantity bigint not null check (quantity >0), -- how do I put >0 constraint
	populated_on TIMESTAMP not null
);

Drop Table If Exists transactions cascade;
Create Table transactions (
	transation_id serial not null primary key,
	order_id bigint not null references orders(order_id),
	transaction_date TIMESTAMP not null,
	CC_processing_status varchar(50) not null, 
	transaction_price numeric not null check (transaction_price >0),
	populated_on TIMESTAMP not null
);

Drop Table If Exists inventory cascade;
Create Table inventory (
	inventory_id serial not null primary key,
	part_number bigint not null references part(part_number),
	quantity bigint not null check (quantity >0),
	populated_on TIMESTAMP not null
);

Drop Table If Exists part cascade;
Create Table part (
	part_id serial not null primary key,
	part_number bigint unique not null,
	part_name varchar (50) not null,
	weight bigint not null,
	size bigint not null, -- how do I do dimensions
	populated_on TIMESTAMP not null
);

Drop Table If Exists shipping cascade;
Create Table shipping (
	shipping_id serial not null primary key,
	order_id bigint not null references orders(order_id),
	shipping_cost numeric (5,2) not null,
	shipping_date TIMESTAMP not null,
	shipping_method varchar(50) not null ,
	populated_on TIMESTAMP not null	
);

drop table if exists pricing cascade;
create table pricing (
	pricing_id serial not null primary key,
	part_number bigint not null references part(part_number),
	price numeric (5,2) not null,
	tax numeric (3,2) not null,
	wholesale_costs numeric (5,2) not null,
	markup numeric (5,2) not null,
	margin numeric (5,2) not null,
	discount numeric (5,2) not null,
	populated_on TIMESTAMP not null
);

Drop Table If Exists shipping_address cascade;
Create Table shipping_address (
	shipping_address_id serial not null primary key,
	order_id bigint not null references orders(order_id),
	shipping_address varchar (255) not null,
	zip_code bigint not null,
	phone_number bigint not null,
	populated_on TIMESTAMP not null
);
	
drop table if exists shipping_rate cascade;
create table shipping_rate (
	shipping_rate_id serial not null primary key,
	ground numeric not null,
	"2day" numeric not null,
	next_day numeric not null,
	weight numeric not null,
	zip_code numeric not null,
	populated_on TIMESTAMP not null
);
