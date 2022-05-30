# Домашнее задание к занятию "6.4. PostgreSQL"

## 1.

```
cat docker-compose.yml
version: '3.1'
services:
  postgres:
    image: ubuntu/postgres:13-21.10_beta
    volumes:
      - /postgres/data:/var/lib/postgresql
      - /postgres/backups:/data/backups
    ports:
      - "5432:5432"
    environment:
      POSTGRES_PASSWORD: pgpass
```
```
docker exec -it postgres2_postgres_1 bash
psql -U postgres
psql (13.7 (Ubuntu 13.7-0ubuntu0.21.10.1))
Type "help" for help.
```
```
postgres-# \l
                                 List of databases
   Name    |  Owner   | Encoding |  Collate   |   Ctype    |   Access privileges
-----------+----------+----------+------------+------------+-----------------------
 postgres  | postgres | UTF8     | en_US.utf8 | en_US.utf8 |
 template0 | postgres | UTF8     | en_US.utf8 | en_US.utf8 | =c/postgres          +
           |          |          |            |            | postgres=CTc/postgres
 template1 | postgres | UTF8     | en_US.utf8 | en_US.utf8 | =c/postgres          +
           |          |          |            |            | postgres=CTc/postgres
(3 rows)
```
```
postgres-# \c 
You are now connected to database "postgres" as user "postgres".
```
```
postgres=# create table test (test111 varchar(20) NOT NULL);
CREATE TABLE
```
```
postgres=# \dt
        List of relations
 Schema | Name | Type  |  Owner
--------+------+-------+----------
 public | test | table | postgres
(1 row)
```
```
postgres=# \dS test
                       Table "public.test"
 Column  |         Type          | Collation | Nullable | Default
---------+-----------------------+-----------+----------+---------
 test111 | character varying(20) |           | not null |
```
```
 \q
```


## 2.

```
postgres=# CREATE DATABASE test_database;
CREATE DATABASE

psql -U postgres -f /data/backups/dump_test_db.sql test_database


\c test_database
You are now connected to database "test_database" as user "postgres".

test_database=# ANALYZE VERBOSE public.orders;
INFO:  analyzing "public.orders"
INFO:  "orders": scanned 1 of 1 pages, containing 8 live rows and 0 dead rows; 8 rows in sample, 8 estimated total rows
ANALYZE
test_database=# SELECT avg_width FROM pg_stats WHERE TABLENAME='orders';
 avg_width
-----------
         4
        16
         4
(3 rows)
```

## 3.

```
test_database=# ALTER TABLE orders RENAME TO old_orders;
ALTER TABLE
```
```
test_database=# CREATE TABLE orders (id integer, title varchar(80), price integer) PARTITION BY range(price);
CREATE TABLE
```
```
test_database=# CREATE TABLE orders_1 PARTITION OF orders FOR values from (499) to (1000000);
CREATE TABLE
```
```
test_database=# CREATE TABLE orders_2 PARTITION OF orders FOR values from (0) to (499);
CREATE TABLE
```
```
INSERT INTO orders (id, title, price) select * from old_orders;
INSERT 0 8
```


Можно было бы изначально исключить "ручное" разбиение при проектировании таблицы orders если бы партиционирование сделали на этапе создания


## 4.

```
root@0367c3a137d6:/# pg_dump -U postgres -d test_database > /data/backups/new_dump_test_db.sql
```

для уникальности можно добавить индекс, например:

```
test_database=# CREATE INDEX title_from_orders ON orders(title);
CREATE INDEX
```
