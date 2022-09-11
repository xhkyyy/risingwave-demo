# risingwave-demo

> https://github.com/risingwavelabs/risingwave

## build the latest version of risingwave

```shell
git clone git@github.com:risingwavelabs/risingwave.git

# this will build a docker image called risingwave:latest
./docker/build.sh

```

## start the demo

```shell
export DEBEZIUM_VERSION=1.9
export MYSQL_PASSWORD=mysqlpw
export MYSQL_USER=mysqluser

# start docker containers
docker-compose -f docker-compose-mysql.yaml up

# start mysql connector
curl -i -X POST -H "Accept:application/json" -H  "Content-Type:application/json" http://localhost:8083/connectors/ -d @register-mysql.json

# consume messages from a Debezium topic
# the connector writes events for each table to a Kafka topic named 'serverName.databaseName.tableName'
docker-compose -f docker-compose-mysql.yaml exec kafka /kafka/bin/kafka-console-consumer.sh \
    --bootstrap-server kafka:9092 \
    --from-beginning \
    --property print.key=true \
    --topic dbserver1.inventory.customers

# shutdown the demo
docker-compose -f docker-compose-mysql.yaml down

```

## test the demo

1.you can connect to the mysql database using the following command

```shell
mysql -umysqluser -h127.0.0.1 -p

use inventory;
```

2.you can connect to risingwave using the following command

```shell
mysql -uroot -hlocalhost -P 4566

use dev;
```

3.execute sql

copy the sql from `risingwave-demo.sql` file and execute it in risingwave.

