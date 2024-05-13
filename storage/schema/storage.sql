-- public.date_dim definition

-- Drop table

-- DROP TABLE date_dim;

CREATE SCHEMA storage AUTHORIZATION postgres;

CREATE TABLE storage.date_dim (
	date_id serial4 NOT NULL,
	"year" int4 NULL,
	"month" int4 NULL,
	"day" int4 NULL,
	CONSTRAINT date_time_dim_pkey PRIMARY KEY (date_id)
);


-- public.inventory_dim definition

-- Drop table

-- DROP TABLE inventory_dim;

CREATE TABLE storage.inventory_dim (
	inventory_dim_id serial4 NOT NULL,
	bk_detail_id int4 NOT NULL,
	description text NULL,
	article varchar(255) NULL,
	price numeric(10, 2) NULL,
	dimensions varchar(255) NULL,
	weight numeric(10, 2) NULL,
	CONSTRAINT inventory_dim_bk_detail_id_key UNIQUE (bk_detail_id),
	CONSTRAINT inventory_dim_pkey PRIMARY KEY (inventory_dim_id)
);


-- public.service_dim definition

-- Drop table

-- DROP TABLE service_dim;

CREATE TABLE storage.service_dim (
	service_dim_id serial4 NOT NULL,
	bk_service_id int4 NOT NULL,
	"name" varchar(255) NULL,
	description text NULL,
	price numeric(10, 2) NULL,
	estimated_duration varchar(255) NULL,
	CONSTRAINT service_dim_bk_service_id_key UNIQUE (bk_service_id),
	CONSTRAINT service_dim_pkey PRIMARY KEY (service_dim_id)
);


-- public.supplier_dim definition

-- Drop table

-- DROP TABLE supplier_dim;

CREATE TABLE storage.supplier_dim (
	supplier_dim_id serial4 NOT NULL,
	bk_supplier_id int4 NOT NULL,
	"name" varchar(255) NULL,
	phone_number varchar(255) NULL,
	address text NULL,
	CONSTRAINT supplier_dim_bk_supplier_id_key UNIQUE (bk_supplier_id),
	CONSTRAINT supplier_dim_pkey PRIMARY KEY (supplier_dim_id)
);


-- public.repair_dim definition

-- Drop table

-- DROP TABLE repair_dim;

CREATE TABLE storage.repair_dim (
	repair_dim_id serial4 NOT NULL,
	bk_repair_id int4 NOT NULL,
	notes text NULL,
	repair_number varchar(255) NULL,
	start_repair_date_dim_id int4 NULL,
	CONSTRAINT repair_dim_bk_repair_id_key UNIQUE (bk_repair_id),
	CONSTRAINT repair_dim_pkey PRIMARY KEY (repair_dim_id),
	CONSTRAINT fk_repair_dim_date_time_dim FOREIGN KEY (start_repair_date_dim_id) REFERENCES storage.date_dim(date_id)
);


-- public.service_repair_dim definition

-- Drop table

-- DROP TABLE service_repair_dim;

CREATE TABLE storage.service_repair_dim (
	service_repair_dim_id serial4 NOT NULL,
	service_id int4 NOT NULL,
	repair_id int4 NOT NULL,
	quantity int4 NULL,
	service_total_price numeric(10, 2) NULL,
	complete_date_dim_id int4 NULL,
	bk_service_repair int4 NOT NULL,
	CONSTRAINT service_repair_dim_pkey PRIMARY KEY (service_repair_dim_id),
	CONSTRAINT service_repair_dim_date_time_dim_id_fkey FOREIGN KEY (complete_date_dim_id) REFERENCES storage.date_dim(date_id),
	CONSTRAINT service_repair_dim_repair_id_fkey FOREIGN KEY (repair_id) REFERENCES storage.repair_dim(repair_dim_id),
	CONSTRAINT service_repair_dim_service_id_fkey FOREIGN KEY (service_id) REFERENCES storage.service_dim(service_dim_id)
);


-- public.supply_details_fact definition

-- Drop table

-- DROP TABLE supply_details_fact;

CREATE TABLE storage.supply_details_fact (
	supply_details_fact_id serial4 NOT NULL,
	detail_dim_id int4 NOT NULL,
	detail_quantity int4 NULL,
	detail_total_cost numeric(10, 2) NULL,
	supplier_id int4 NULL,
	start_date_dim_id int4 NULL,
	end_date_dim_id int4 NULL,
	CONSTRAINT supply_details_fact_pkey PRIMARY KEY (supply_details_fact_id),
	CONSTRAINT fk_supply_details_fact_end_date FOREIGN KEY (end_date_dim_id) REFERENCES storage.date_dim(date_id),
	CONSTRAINT fk_supply_details_fact_start_date FOREIGN KEY (start_date_dim_id) REFERENCES storage.date_dim(date_id),
	CONSTRAINT supply_details_fact_detail_dim_id_fkey FOREIGN KEY (detail_dim_id) REFERENCES storage.inventory_dim(inventory_dim_id),
	CONSTRAINT supply_details_fact_supplier_id_fkey FOREIGN KEY (supplier_id) REFERENCES storage.supplier_dim(supplier_dim_id)
);


-- public.service_inventory_fact definition

-- Drop table

-- DROP TABLE service_inventory_fact;

CREATE TABLE storage.service_inventory_fact (
	service_inventory_fact_id serial4 NOT NULL,
	service_repair_dim_id int4 NOT NULL,
	inventory_dim_id int4 NOT NULL,
	parts_cost numeric(10, 2) NULL,
	total_cost numeric(10, 2) NULL,
	parts_cost_percentage numeric(10, 2) NULL,
	actual_service_duration varchar(255) NULL,
	estimated_service_duration varchar(255) NULL,
	service_duration_deviation varchar(255) NULL,
	bk_service_inventory_id int4 NOT NULL,
	amount numeric(10, 2) NULL,
	CONSTRAINT service_inventory_fact_bk_service_inventory_id_key UNIQUE (bk_service_inventory_id),
	CONSTRAINT service_inventory_fact_pkey PRIMARY KEY (service_inventory_fact_id),
	CONSTRAINT service_inventory_fact_inventory_dim_id_fkey FOREIGN KEY (inventory_dim_id) REFERENCES storage.inventory_dim(inventory_dim_id),
	CONSTRAINT service_inventory_fact_service_repair_dim_id_fkey FOREIGN KEY (service_repair_dim_id) REFERENCES storage.service_repair_dim(service_repair_dim_id)
);



CREATE SCHEMA stage AUTHORIZATION postgres;


-- stage.detail definition

-- Drop table

-- DROP TABLE stage.detail;

CREATE TABLE stage.detail (
	detail_id serial4 NOT NULL,
	description text NULL,
	manufacturer_id int4 NULL,
	detail_type_id int4 NULL,
	article varchar(255) NULL,
	price numeric NULL,
	dimensions varchar(255) NULL,
	weight numeric NULL,
	CONSTRAINT detail_pkey PRIMARY KEY (detail_id)
);


-- stage.inventory definition

-- Drop table

-- DROP TABLE stage.inventory;

CREATE TABLE stage.inventory (
	inventory_id serial4 NOT NULL,
	detail_id int4 NULL,
	quantity int4 NULL,
	service_station_id int4 NULL,
	CONSTRAINT inventory_pkey PRIMARY KEY (inventory_id)
);


-- stage.repair definition

-- Drop table

-- DROP TABLE stage.repair;

CREATE TABLE stage.repair (
	repair_id serial4 NOT NULL,
	employee_id int4 NULL,
	start_date date NULL,
	repair_status_id int4 NULL,
	notes text NULL,
	repair_number varchar(255) NULL,
	payment_status_id int4 NULL,
	car_client_id int4 NULL,
	total_sum numeric NULL,
	CONSTRAINT repair_pkey PRIMARY KEY (repair_id)
);


-- stage.service definition

-- Drop table

-- DROP TABLE stage.service;

CREATE TABLE stage.service (
	service_id serial4 NOT NULL,
	"name" varchar(255) NULL,
	description text NULL,
	price numeric NULL,
	estimated_duration interval NULL,
	CONSTRAINT service_pkey PRIMARY KEY (service_id)
);


-- stage.service_inventory definition

-- Drop table

-- DROP TABLE stage.service_inventory;

CREATE TABLE stage.service_inventory (
	service_inventory_id serial4 NOT NULL,
	service_repair_id int4 NULL,
	inventory_id int4 NULL,
	amount int4 NULL,
	CONSTRAINT service_inventory_pkey PRIMARY KEY (service_inventory_id)
);


-- stage.service_repair definition

-- Drop table

-- DROP TABLE stage.service_repair;

CREATE TABLE stage.service_repair (
	service_repairs_id serial4 NOT NULL,
	service_id int4 NULL,
	repair_id int4 NULL,
	quantity int4 NULL,
	completion_date date NULL,
	service_total_price numeric NULL,
	CONSTRAINT service_repair_pkey PRIMARY KEY (service_repairs_id)
);


-- stage.supplier definition

-- Drop table

-- DROP TABLE stage.supplier;

CREATE TABLE stage.supplier (
	supplier_id serial4 NOT NULL,
	"name" varchar(255) NULL,
	city_id int4 NULL,
	phone_number varchar(255) NULL,
	address varchar(255) NULL,
	CONSTRAINT supplier_pkey PRIMARY KEY (supplier_id)
);


-- stage.supply definition

-- Drop table

-- DROP TABLE stage.supply;

CREATE TABLE stage.supply (
	supply_id serial4 NOT NULL,
	supply_number varchar(255) NULL,
	supply_date date NULL,
	total_sum numeric NULL,
	status_id int4 NULL,
	supplier_id int4 NULL,
	employee_id int4 NULL,
	CONSTRAINT supply_pkey PRIMARY KEY (supply_id)
);


-- stage.supply_details definition

-- Drop table

-- DROP TABLE stage.supply_details;

CREATE TABLE stage.supply_details (
	supply_details_id serial4 NOT NULL,
	detail_id int4 NULL,
	quantity int4 NULL,
	price_per_unit numeric NULL,
	supply_id int4 NULL,
	CONSTRAINT supply_details_pkey PRIMARY KEY (supply_details_id)
);


