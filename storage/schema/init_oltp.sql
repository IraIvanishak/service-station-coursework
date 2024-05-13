-- public.brand definition

-- Drop table
-- DROP SCHEMA meta;

CREATE SCHEMA meta AUTHORIZATION postgres;
-- DROP TABLE public.brand;

CREATE TABLE public.brand (
	brand_id serial4 NOT NULL,
	"name" varchar(255) NOT NULL,
	created_at timestamp DEFAULT CURRENT_TIMESTAMP NULL,
	updated_at timestamp DEFAULT CURRENT_TIMESTAMP NULL,
	CONSTRAINT brand_pkey PRIMARY KEY (brand_id)
);


-- public.characteristic definition

-- Drop table

-- DROP TABLE public.characteristic;

CREATE TABLE public.characteristic (
	characteristic_id serial4 NOT NULL,
	"name" varchar(255) NOT NULL,
	created_at timestamp DEFAULT CURRENT_TIMESTAMP NULL,
	updated_at timestamp DEFAULT CURRENT_TIMESTAMP NULL,
	CONSTRAINT characteristic_pkey PRIMARY KEY (characteristic_id)
);


-- public.client definition

-- Drop table

-- DROP TABLE public.client;

CREATE TABLE public.client (
	client_id serial4 NOT NULL,
	first_name varchar(255) NOT NULL,
	last_name varchar(255) NOT NULL,
	phone_number varchar(20) NULL,
	created_at timestamp DEFAULT CURRENT_TIMESTAMP NULL,
	updated_at timestamp DEFAULT CURRENT_TIMESTAMP NULL,
	CONSTRAINT client_pkey PRIMARY KEY (client_id)
);


-- public.country definition

-- Drop table

-- DROP TABLE public.country;

CREATE TABLE public.country (
	country_id serial4 NOT NULL,
	"name" varchar(255) NOT NULL,
	created_at timestamp DEFAULT CURRENT_TIMESTAMP NULL,
	updated_at timestamp DEFAULT CURRENT_TIMESTAMP NULL,
	CONSTRAINT country_pkey PRIMARY KEY (country_id)
);


-- public.detail_group definition

-- Drop table

-- DROP TABLE public.detail_group;

CREATE TABLE public.detail_group (
	detail_group_id serial4 NOT NULL,
	"name" varchar(255) NOT NULL,
	created_at timestamp DEFAULT CURRENT_TIMESTAMP NULL,
	updated_at timestamp DEFAULT CURRENT_TIMESTAMP NULL,
	CONSTRAINT detail_group_pkey PRIMARY KEY (detail_group_id)
);


-- public.employee_role definition

-- Drop table

-- DROP TABLE public.employee_role;

CREATE TABLE public.employee_role (
	role_id serial4 NOT NULL,
	"name" varchar(255) NOT NULL,
	created_at timestamp DEFAULT CURRENT_TIMESTAMP NULL,
	updated_at timestamp DEFAULT CURRENT_TIMESTAMP NULL,
	CONSTRAINT employee_role_pkey PRIMARY KEY (role_id)
);


-- public.payment_status definition

-- Drop table

-- DROP TABLE public.payment_status;

CREATE TABLE public.payment_status (
	status_id serial4 NOT NULL,
	title varchar(255) NOT NULL,
	created_at timestamp DEFAULT CURRENT_TIMESTAMP NULL,
	updated_at timestamp DEFAULT CURRENT_TIMESTAMP NULL,
	CONSTRAINT payment_status_pkey PRIMARY KEY (status_id)
);


-- public.repair_status definition

-- Drop table

-- DROP TABLE public.repair_status;

CREATE TABLE public.repair_status (
	status_id serial4 NOT NULL,
	title varchar(255) NOT NULL,
	created_at timestamp DEFAULT CURRENT_TIMESTAMP NULL,
	updated_at timestamp DEFAULT CURRENT_TIMESTAMP NULL,
	CONSTRAINT repair_status_pkey PRIMARY KEY (status_id)
);


-- public.service definition

-- Drop table

-- DROP TABLE public.service;

CREATE TABLE public.service (
	service_id serial4 NOT NULL,
	"name" varchar(255) NOT NULL,
	description text NULL,
	price numeric(10, 2) NULL,
	estimated_duration varchar(255) NULL,
	created_at timestamp DEFAULT CURRENT_TIMESTAMP NULL,
	updated_at timestamp DEFAULT CURRENT_TIMESTAMP NULL,
	CONSTRAINT service_pkey PRIMARY KEY (service_id)
);


-- public.supply_status definition

-- Drop table

-- DROP TABLE public.supply_status;

CREATE TABLE public.supply_status (
	status_id serial4 NOT NULL,
	title varchar(255) NOT NULL,
	created_at timestamp DEFAULT CURRENT_TIMESTAMP NULL,
	updated_at timestamp DEFAULT CURRENT_TIMESTAMP NULL,
	CONSTRAINT supply_status_pkey PRIMARY KEY (status_id)
);


-- public.car definition

-- Drop table

-- DROP TABLE public.car;

CREATE TABLE public.car (
	car_id serial4 NOT NULL,
	"year" int4 NULL,
	body_type varchar(50) NULL,
	model varchar(255) NULL,
	brand_id int4 NULL,
	created_at timestamp DEFAULT CURRENT_TIMESTAMP NULL,
	updated_at timestamp DEFAULT CURRENT_TIMESTAMP NULL,
	CONSTRAINT car_pkey PRIMARY KEY (car_id),
	CONSTRAINT car_brand_id_fkey FOREIGN KEY (brand_id) REFERENCES public.brand(brand_id)
);


-- public.car_client definition

-- Drop table

-- DROP TABLE public.car_client;

CREATE TABLE public.car_client (
	car_client_id serial4 NOT NULL,
	car_id int4 NOT NULL,
	client_id int4 NOT NULL,
	description text NULL,
	registration_number varchar(50) NULL,
	vin varchar(17) NULL,
	color varchar(50) NULL,
	created_at timestamp DEFAULT CURRENT_TIMESTAMP NULL,
	updated_at timestamp DEFAULT CURRENT_TIMESTAMP NULL,
	CONSTRAINT car_client_pkey PRIMARY KEY (car_client_id),
	CONSTRAINT car_client_car_id_fkey FOREIGN KEY (car_id) REFERENCES public.car(car_id),
	CONSTRAINT car_client_client_id_fkey FOREIGN KEY (client_id) REFERENCES public.client(client_id)
);


-- public.city definition

-- Drop table

-- DROP TABLE public.city;

CREATE TABLE public.city (
	city_id serial4 NOT NULL,
	"name" varchar(255) NOT NULL,
	country_id int4 NULL,
	created_at timestamp DEFAULT CURRENT_TIMESTAMP NULL,
	updated_at timestamp DEFAULT CURRENT_TIMESTAMP NULL,
	CONSTRAINT city_pkey PRIMARY KEY (city_id),
	CONSTRAINT city_country_id_fkey FOREIGN KEY (country_id) REFERENCES public.country(country_id)
);


-- public.detail_type definition

-- Drop table

-- DROP TABLE public.detail_type;

CREATE TABLE public.detail_type (
	detail_type_id serial4 NOT NULL,
	"name" varchar(255) NOT NULL,
	detail_group_id int4 NULL,
	created_at timestamp DEFAULT CURRENT_TIMESTAMP NULL,
	updated_at timestamp DEFAULT CURRENT_TIMESTAMP NULL,
	CONSTRAINT detail_type_pkey PRIMARY KEY (detail_type_id),
	CONSTRAINT detail_type_detail_group_id_fkey FOREIGN KEY (detail_group_id) REFERENCES public.detail_group(detail_group_id)
);


-- public.manufacturer definition

-- Drop table

-- DROP TABLE public.manufacturer;

CREATE TABLE public.manufacturer (
	manufacturer_id serial4 NOT NULL,
	country_id int4 NULL,
	"name" varchar(255) NOT NULL,
	created_at timestamp DEFAULT CURRENT_TIMESTAMP NULL,
	updated_at timestamp DEFAULT CURRENT_TIMESTAMP NULL,
	CONSTRAINT manufacturer_pkey PRIMARY KEY (manufacturer_id),
	CONSTRAINT manufacturer_country_id_fkey FOREIGN KEY (country_id) REFERENCES public.country(country_id)
);


-- public.service_station definition

-- Drop table

-- DROP TABLE public.service_station;

CREATE TABLE public.service_station (
	station_id serial4 NOT NULL,
	address text NOT NULL,
	city_id int4 NULL,
	created_at timestamp DEFAULT CURRENT_TIMESTAMP NULL,
	updated_at timestamp DEFAULT CURRENT_TIMESTAMP NULL,
	CONSTRAINT service_station_pkey PRIMARY KEY (station_id),
	CONSTRAINT service_station_city_id_fkey FOREIGN KEY (city_id) REFERENCES public.city(city_id)
);


-- public.supplier definition

-- Drop table

-- DROP TABLE public.supplier;

CREATE TABLE public.supplier (
	supplier_id serial4 NOT NULL,
	"name" varchar(255) NOT NULL,
	city_id int4 NULL,
	phone_number varchar(20) NULL,
	address text NOT NULL,
	created_at timestamp DEFAULT CURRENT_TIMESTAMP NULL,
	updated_at timestamp DEFAULT CURRENT_TIMESTAMP NULL,
	CONSTRAINT supplier_pkey PRIMARY KEY (supplier_id),
	CONSTRAINT supplier_city_id_fkey FOREIGN KEY (city_id) REFERENCES public.city(city_id)
);


-- public.detail definition

-- Drop table

-- DROP TABLE public.detail;

CREATE TABLE public.detail (
	detail_id serial4 NOT NULL,
	description text NOT NULL,
	manufacturer_id int4 NULL,
	detail_type_id int4 NULL,
	article int4 NULL,
	price numeric(10, 2) NULL,
	dimensions varchar(255) NULL,
	weight numeric(10, 2) NULL,
	created_at timestamp DEFAULT CURRENT_TIMESTAMP NULL,
	updated_at timestamp DEFAULT CURRENT_TIMESTAMP NULL,
	CONSTRAINT detail_pkey PRIMARY KEY (detail_id),
	CONSTRAINT detail_detail_type_id_fkey FOREIGN KEY (detail_type_id) REFERENCES public.detail_type(detail_type_id),
	CONSTRAINT detail_manufacturer_id_fkey FOREIGN KEY (manufacturer_id) REFERENCES public.manufacturer(manufacturer_id)
);


-- public.detail_characteristic definition

-- Drop table

-- DROP TABLE public.detail_characteristic;

CREATE TABLE public.detail_characteristic (
	characteristic_id int4 NOT NULL,
	detail_id int4 NOT NULL,
	value text NULL,
	created_at timestamp DEFAULT CURRENT_TIMESTAMP NULL,
	updated_at timestamp DEFAULT CURRENT_TIMESTAMP NULL,
	CONSTRAINT detail_characteristic_pkey PRIMARY KEY (characteristic_id, detail_id),
	CONSTRAINT detail_characteristic_characteristic_id_fkey FOREIGN KEY (characteristic_id) REFERENCES public.characteristic(characteristic_id),
	CONSTRAINT detail_characteristic_detail_id_fkey FOREIGN KEY (detail_id) REFERENCES public.detail(detail_id)
);


-- public.employee definition

-- Drop table

-- DROP TABLE public.employee;

CREATE TABLE public.employee (
	employee_id serial4 NOT NULL,
	first_name varchar(255) NOT NULL,
	last_name varchar(255) NOT NULL,
	phone_number varchar(20) NULL,
	role_id int4 NULL,
	service_station_id int4 NULL,
	created_at timestamp DEFAULT CURRENT_TIMESTAMP NULL,
	updated_at timestamp DEFAULT CURRENT_TIMESTAMP NULL,
	CONSTRAINT employee_pkey PRIMARY KEY (employee_id),
	CONSTRAINT employee_role_id_fkey FOREIGN KEY (role_id) REFERENCES public.employee_role(role_id),
	CONSTRAINT employee_service_station_id_fkey FOREIGN KEY (service_station_id) REFERENCES public.service_station(station_id)
);


-- public.inventory definition

-- Drop table

-- DROP TABLE public.inventory;

CREATE TABLE public.inventory (
	inventory_id serial4 NOT NULL,
	detail_id int4 NULL,
	quantity int4 NULL,
	service_station_id int4 NULL,
	created_at timestamp DEFAULT CURRENT_TIMESTAMP NULL,
	updated_at timestamp DEFAULT CURRENT_TIMESTAMP NULL,
	CONSTRAINT inventory_pkey PRIMARY KEY (inventory_id),
	CONSTRAINT inventory_detail_id_fkey FOREIGN KEY (detail_id) REFERENCES public.detail(detail_id),
	CONSTRAINT inventory_service_station_id_fkey FOREIGN KEY (service_station_id) REFERENCES public.service_station(station_id)
);


-- public.repair_order definition

-- Drop table

-- DROP TABLE public.repair_order;

CREATE TABLE public.repair_order (
	repair_id serial4 NOT NULL,
	employee_id int4 NULL,
	start_date timestamp NULL,
	repair_status_id int4 NULL,
	notes text NULL,
	repair_number varchar(255) NULL,
	payment_status_id int4 NULL,
	car_client_id int4 NULL,
	total_sum numeric(10, 2) NULL,
	created_at timestamp DEFAULT CURRENT_TIMESTAMP NULL,
	updated_at timestamp DEFAULT CURRENT_TIMESTAMP NULL,
	CONSTRAINT repair_pkey PRIMARY KEY (repair_id),
	CONSTRAINT repair_employee_id_fkey FOREIGN KEY (employee_id) REFERENCES public.employee(employee_id),
	CONSTRAINT repair_order_car_client_id_fkey FOREIGN KEY (car_client_id) REFERENCES public.car_client(car_client_id),
	CONSTRAINT repair_order_payment_status_id_fkey FOREIGN KEY (payment_status_id) REFERENCES public.payment_status(status_id),
	CONSTRAINT repair_status_id_fkey FOREIGN KEY (repair_status_id) REFERENCES public.repair_status(status_id)
);


-- public.service_repairs definition

-- Drop table

-- DROP TABLE public.service_repairs;

CREATE TABLE public.service_repairs (
	service_repairs_id serial4 NOT NULL,
	service_id int4 NULL,
	repair_id int4 NULL,
	quantity int4 NULL,
	completion_date date NULL,
	service_total_price numeric(10, 2) NULL,
	created_at timestamp DEFAULT CURRENT_TIMESTAMP NULL,
	updated_at timestamp DEFAULT CURRENT_TIMESTAMP NULL,
	CONSTRAINT service_repairs_pkey PRIMARY KEY (service_repairs_id),
	CONSTRAINT service_repairs_repair_id_fkey FOREIGN KEY (repair_id) REFERENCES public.repair_order(repair_id),
	CONSTRAINT service_repairs_service_id_fkey FOREIGN KEY (service_id) REFERENCES public.service(service_id)
);


-- public.supply definition

-- Drop table

-- DROP TABLE public.supply;

CREATE TABLE public.supply (
	supply_id serial4 NOT NULL,
	supply_number varchar(255) NOT NULL,
	total_sum numeric(10, 2) NULL,
	supply_date date NOT NULL,
	status_id int4 NULL,
	supplier_id int4 NULL,
	employee_id int4 NULL,
	created_at timestamp DEFAULT CURRENT_TIMESTAMP NULL,
	updated_at timestamp DEFAULT CURRENT_TIMESTAMP NULL,
	CONSTRAINT supply_pkey PRIMARY KEY (supply_id),
	CONSTRAINT supply_employee_id_fkey FOREIGN KEY (employee_id) REFERENCES public.employee(employee_id),
	CONSTRAINT supply_status_id_fkey FOREIGN KEY (status_id) REFERENCES public.supply_status(status_id),
	CONSTRAINT supply_supplier_id_fkey FOREIGN KEY (supplier_id) REFERENCES public.supplier(supplier_id)
);


-- public.supply_details definition

-- Drop table

-- DROP TABLE public.supply_details;

CREATE TABLE public.supply_details (
	supply_details_id serial4 NOT NULL,
	detail_id int4 NULL,
	quantity int4 NULL,
	price_per_unit numeric(10, 2) NULL,
	supply_id int4 NULL,
	created_at timestamp DEFAULT CURRENT_TIMESTAMP NULL,
	updated_at timestamp DEFAULT CURRENT_TIMESTAMP NULL,
	CONSTRAINT supply_details_pkey PRIMARY KEY (supply_details_id),
	CONSTRAINT supply_details_detail_id_fkey FOREIGN KEY (detail_id) REFERENCES public.detail(detail_id),
	CONSTRAINT supply_details_supply_id_fkey FOREIGN KEY (supply_id) REFERENCES public.supply(supply_id)
);


-- public.supply_invoice definition

-- Drop table

-- DROP TABLE public.supply_invoice;

CREATE TABLE public.supply_invoice (
	supply_invoice_id serial4 NOT NULL,
	supply_details_id int4 NULL,
	invoice_number varchar(255) NULL,
	inventory_id int4 NOT NULL,
	created_at timestamp DEFAULT CURRENT_TIMESTAMP NULL,
	updated_at timestamp DEFAULT CURRENT_TIMESTAMP NULL,
	CONSTRAINT supply_invoice_pkey PRIMARY KEY (supply_invoice_id),
	CONSTRAINT fk_inventory FOREIGN KEY (inventory_id) REFERENCES public.inventory(inventory_id),
	CONSTRAINT supply_invoice_supply_details_id_fkey FOREIGN KEY (supply_details_id) REFERENCES public.supply_details(supply_details_id)
);


-- public.service_inventory definition

-- Drop table

-- DROP TABLE public.service_inventory;

CREATE TABLE public.service_inventory (
	service_inventory_id serial4 NOT NULL,
	service_repair_id int4 NULL,
	inventory_id int4 NULL,
	amount numeric(10, 2) NULL,
	created_at timestamp DEFAULT CURRENT_TIMESTAMP NULL,
	updated_at timestamp DEFAULT CURRENT_TIMESTAMP NULL,
	CONSTRAINT service_inventory_pkey PRIMARY KEY (service_inventory_id),
	CONSTRAINT fk_iinventory FOREIGN KEY (inventory_id) REFERENCES public.inventory(inventory_id),
	CONSTRAINT fk_inventory FOREIGN KEY (inventory_id) REFERENCES public.inventory(inventory_id),
	CONSTRAINT service_inventory_inventory_id_fkey FOREIGN KEY (inventory_id) REFERENCES public.inventory(inventory_id),
	CONSTRAINT service_inventory_service_repair_id_fkey FOREIGN KEY (service_repair_id) REFERENCES public.service_repairs(service_repairs_id)
);


-- meta.dataloadhistory definition

-- Drop table

-- DROP TABLE meta.dataloadhistory;

CREATE TABLE meta.dataloadhistory (
	data_load_history_id serial4 NOT NULL,
	load_datetime timestamp NULL,
	load_time time NULL,
	load_rows int4 NULL,
	affected_table_count int4 NULL,
	source_table_count int4 NULL,
	CONSTRAINT dataloadhistory_pkey PRIMARY KEY (data_load_history_id)
);


-- meta.dwattributecolumn definition

-- Drop table

-- DROP TABLE meta.dwattributecolumn;

CREATE TABLE meta.dwattributecolumn (
	dw_attribute_column_id serial4 NOT NULL,
	dw_attribute_column_name varchar NULL,
	dw_attribute_column_datatype varchar NULL,
	CONSTRAINT dwattributecolumn_pkey PRIMARY KEY (dw_attribute_column_id)
);


-- meta.sourcedb definition

-- Drop table

-- DROP TABLE meta.sourcedb;

CREATE TABLE meta.sourcedb (
	source_db_id serial4 NOT NULL,
	source_db_name varchar NULL,
	CONSTRAINT sourcedb_pkey PRIMARY KEY (source_db_id)
);


-- meta.dwtable definition

-- Drop table

-- DROP TABLE meta.dwtable;

CREATE TABLE meta.dwtable (
	dw_table_id serial4 NOT NULL,
	data_load_history_id int4 NULL,
	dw_table_name varchar NULL,
	CONSTRAINT dwtable_pkey PRIMARY KEY (dw_table_id),
	CONSTRAINT dwtable_data_load_history_id_fkey FOREIGN KEY (data_load_history_id) REFERENCES meta.dataloadhistory(data_load_history_id)
);


-- meta.fact definition

-- Drop table

-- DROP TABLE meta.fact;

CREATE TABLE meta.fact (
	fact_id serial4 NOT NULL,
	key_name varchar NULL,
	dw_table_id int4 NULL,
	fact_type varchar NULL,
	CONSTRAINT fact_pkey PRIMARY KEY (fact_id),
	CONSTRAINT fact_dw_table_id_fkey FOREIGN KEY (dw_table_id) REFERENCES meta.dwtable(dw_table_id)
);


-- meta.factmetric definition

-- Drop table

-- DROP TABLE meta.factmetric;

CREATE TABLE meta.factmetric (
	fact_metric_id serial4 NOT NULL,
	fact_id int4 NULL,
	dw_attribute_column_id int4 NULL,
	fact_metric_description varchar NULL,
	CONSTRAINT factmetric_pkey PRIMARY KEY (fact_metric_id),
	CONSTRAINT factmetric_dw_attribute_column_id_fkey FOREIGN KEY (dw_attribute_column_id) REFERENCES meta.dwattributecolumn(dw_attribute_column_id),
	CONSTRAINT factmetric_fact_id_fkey FOREIGN KEY (fact_id) REFERENCES meta.fact(fact_id)
);


-- meta.sourcetable definition

-- Drop table

-- DROP TABLE meta.sourcetable;

CREATE TABLE meta.sourcetable (
	source_table_id serial4 NOT NULL,
	source_db_id int4 NULL,
	key_name varchar NULL,
	source_table_name varchar NULL,
	CONSTRAINT sourcetable_pkey PRIMARY KEY (source_table_id),
	CONSTRAINT sourcetable_source_db_id_fkey FOREIGN KEY (source_db_id) REFERENCES meta.sourcedb(source_db_id)
);


-- meta.dimension definition

-- Drop table

-- DROP TABLE meta.dimension;

CREATE TABLE meta.dimension (
	dimension_id serial4 NOT NULL,
	dw_table_id int4 NULL,
	key_name varchar NULL,
	dimension_type varchar NULL,
	dimension_name varchar NULL,
	CONSTRAINT dimension_pkey PRIMARY KEY (dimension_id),
	CONSTRAINT dimension_dw_table_id_fkey FOREIGN KEY (dw_table_id) REFERENCES meta.dwtable(dw_table_id)
);


-- meta.dimensionattributes definition

-- Drop table

-- DROP TABLE meta.dimensionattributes;

CREATE TABLE meta.dimensionattributes (
	dimension_id int4 NULL,
	dw_attribute_column_id int4 NULL,
	CONSTRAINT dimensionattributes_dimension_id_fkey FOREIGN KEY (dimension_id) REFERENCES meta.dimension(dimension_id),
	CONSTRAINT dimensionattributes_dw_attribute_column_id_fkey FOREIGN KEY (dw_attribute_column_id) REFERENCES meta.dwattributecolumn(dw_attribute_column_id)
);


-- meta.sourcecolumn definition

-- Drop table

-- DROP TABLE meta.sourcecolumn;

CREATE TABLE meta.sourcecolumn (
	source_column_id serial4 NOT NULL,
	source_table_id int4 NULL,
	source_column_name varchar NULL,
	data_type varchar NULL,
	CONSTRAINT sourcecolumn_pkey PRIMARY KEY (source_column_id),
	CONSTRAINT sourcecolumn_source_table_id_fkey FOREIGN KEY (source_table_id) REFERENCES meta.sourcetable(source_table_id)
);


-- meta.transformation definition

-- Drop table

-- DROP TABLE meta.transformation;

CREATE TABLE meta.transformation (
	transformation_id serial4 NOT NULL,
	dw_attribute_column_id int4 NULL,
	transformation_rule varchar NULL,
	source_column_id int4 NULL,
	CONSTRAINT transformation_pkey PRIMARY KEY (transformation_id),
	CONSTRAINT transformation_dw_attribute_column_id_fkey FOREIGN KEY (dw_attribute_column_id) REFERENCES meta.dwattributecolumn(dw_attribute_column_id),
	CONSTRAINT transformation_source_column_id_fkey FOREIGN KEY (source_column_id) REFERENCES meta.sourcecolumn(source_column_id)
);