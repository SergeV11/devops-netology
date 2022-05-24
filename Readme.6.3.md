# Домашнее задание к занятию "6.3. MySQL"

## 1.

```
root@nM:/home/cht/netology/mysql# cat docker-compose.yaml
version: '2'
services:
  mysql:
    image: ubuntu/mysql
    environment:
      MYSQL_ROOT_PASSWORD: '123'
    volumes:
      - /mysql/data:/var/lib/mysql
    ports:
      - "3306:3306"
```

```
mysql -u root -p test_db < /var/lib/mysql/backup.sql
```

```
root@bc7f045616de:/# mysql -u root -p --execute="\s"|grep "Server version"
Enter password:
Server version:         8.0.28-0ubuntu4 (Ubuntu)
```

```
mysql> use test_db;
Reading table information for completion of table and column names
You can turn off this feature to get a quicker startup with -A

Database changed
mysql> show tables;
+-------------------+
| Tables_in_test_db |
+-------------------+
| orders            |
+-------------------+
1 row in set (0.01 sec)
```
```
mysql> SELECT COUNT(1) FROM orders WHERE price >300;
+----------+
| COUNT(1) |
+----------+
|        1 |
+----------+
1 row in set (0.00 sec)
```

## 2.

```
CREATE USER 'test'@'localhost' IDENTIFIED BY 'test-pass';
ALTER USER 'test'@'localhost' ATTRIBUTE '{"fname":"James", "lname":"Pretty"}';
ALTER USER 'test'@'localhost' WITH MAX_QUERIES_PER_HOUR 100 PASSWORD EXPIRE INTERVAL 180 DAY FAILED_LOGIN_ATTEMPTS 3;
GRANT SELECT ON test_db.orders TO 'test'@'localhost';
```
```
mysql> SELECT * FROM INFORMATION_SCHEMA.USER_ATTRIBUTES WHERE USER='test';
+------+-----------+---------------------------------------+
| USER | HOST      | ATTRIBUTE                             |
+------+-----------+---------------------------------------+
| test | localhost | {"fname": "James", "lname": "Pretty"} |
+------+-----------+---------------------------------------+
1 row in set (0.00 sec)
```

## 3.

```
mysql> SELECT TABLE_NAME,ENGINE FROM information_schema.TABLES WHERE TABLE_NAME = 'orders' AND  TABLE_SCHEMA = 'test_db';
+------------+--------+
| TABLE_NAME | ENGINE |
+------------+--------+
| orders     | InnoDB |
+------------+--------+
1 row in set (0.00 sec)
```
```
mysql> SET profiling = 1;
Query OK, 0 rows affected, 1 warning (0.00 sec)

mysql> ALTER TABLE orders ENGINE = MyISAM;
Query OK, 5 rows affected (0.03 sec)
Records: 5  Duplicates: 0  Warnings: 0

mysql> ALTER TABLE orders ENGINE = InnoDB;
Query OK, 5 rows affected (0.04 sec)
Records: 5  Duplicates: 0  Warnings: 0

mysql> SHOW PROFILES;
+----------+------------+------------------------------------+
| Query_ID | Duration   | Query                              |
+----------+------------+------------------------------------+
|       13 | 0.00023675 | SET profiling = 1                  |
|       14 | 0.03065050 | ALTER TABLE orders ENGINE = MyISAM |
|       15 | 0.04047500 | ALTER TABLE orders ENGINE = InnoDB |
+----------+------------+------------------------------------+
3 rows in set, 1 warning (0.00 sec)
```

переключение на MyISAM 0.03 секунды</br>
переключение на InnoDB 0.04 секунды


## 4.

```
root@bc7f045616de:/# cat /etc/mysql/my.cnf

[mysqld]
pid-file        = /var/run/mysqld/mysqld.pid
socket          = /var/run/mysqld/mysqld.sock
datadir         = /var/lib/mysql
secure-file-priv= NULL

innodb_flush_log_at_trx_commit = 0
innodb_file_format = Barracuda
innodb_log_buffer_size = 1M
key_buffer_size = 660M
max_binlog_size = 100M

!includedir /etc/mysql/conf.d/
```


