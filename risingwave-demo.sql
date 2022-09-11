
CREATE SOURCE source_customers (
	id integer,
	first_name varchar,
	last_name varchar,
	email varchar,
	PRIMARY KEY (id)
)
WITH (
	connector = 'kafka',
	kafka.topic = 'dbserver1.inventory.customers',
	kafka.brokers = 'kafka:9092',
	kafka.scan.startup.mode = 'earliest',
	kafka.consumer.group = 'inventory.customers2022'
) 
ROW FORMAT debezium_json;



CREATE MATERIALIZED VIEW materialized_customers AS
SELECT
	id,
	first_name,
	last_name,
	email
FROM
source_customers;


SELECT * from materialized_customers order by id;


