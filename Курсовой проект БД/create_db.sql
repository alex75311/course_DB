drop database if exists OCS;
create database OCS;
use OCS;

drop table if exists customer;
create table customer (
	id serial primary key,
	title varchar(50) not null,
	date_start date,
	date_stop date
);


drop table if exists priority;
CREATE table priority (
	id serial primary key,
	title varchar(50) not null
);


drop table if exists group_responsible;
create table group_responsible (
	id serial primary key,
	title varchar(50)
);


drop table if exists responsible;
create table responsible (
	id serial primary key,
	first_name varchar(50) not null,
	last_name varchar(50) not null,
	group_responsible_id bigint unsigned not null,
	email varchar(50) not null,
	phone varchar(12),
	
	foreign key (group_responsible_id) references group_responsible(id)
);


drop table if exists state;
create table state (
	id serial primary key,
	title varchar(20) not null
);


drop table if exists files;
create table files (
	id serial primary key,
	name varchar(30) not null,
	patch varchar(255) not null
);


drop table if exists category;
create table category (
	id serial primary key,
	title varchar (50) not null
);



drop table if exists type_msg;
create table type_msg(
	id serial primary key,
	title varchar(30) not null
);


drop table if exists work_details;
create table work_details (
	id serial primary key,
	responsible_id bigint unsigned not null,
	created_time datetime default now(),
	type_msg_id bigint unsigned not null,
	message text,
	file_id bigint unsigned not null,
	
	foreign key (responsible_id) references responsible(id),
	foreign key (type_msg_id) references type_msg(id),
	foreign key (file_id) references files(id)
);


drop table if exists incident;
create table incident (
	id SERIAL Primary key,
	customer_id bigint unsigned not null,
	topic varchar(50) not null,
	description varchar(255) not null,
	created_date datetime default now() not null,
	priority_id bigint unsigned not null,
	group_responsible_id bigint unsigned,
	responsible_id bigint unsigned,
	state_id bigint unsigned not null default 1,
	decision varchar(255),
	category_id bigint unsigned,
	work_details_id bigint unsigned,
	
	foreign key (customer_id) references customer(id),
	foreign key (priority_id) references priority(id),
	foreign key (group_responsible_id) references group_responsible(id),
	foreign key (responsible_id) references responsible(id),
	foreign key (state_id) references state(id),
	foreign key (category_id) references category(id),
	foreign key (work_details_id) references work_details(id)
);
