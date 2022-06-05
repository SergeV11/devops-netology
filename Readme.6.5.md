# Домашнее задание к занятию "6.5. Elasticsearch"

## 1.

elastic.co судя по всему заблокирован в нашей стране, поэтому я проверял на зарубежном хостинге.
Также если в докерфайле раскомментировать строчки, то он скачает образ эластика через тор, но займёт это более двух часов.

```
 cat  Dockerfile
FROM centos
USER root

RUN cd /etc/yum.repos.d
RUN sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-*
RUN sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-*

RUN \
  yum update -y --quiet && \
  yum install -y --quiet wget && \
  yum install -y --quiet tar && \
  yum install -y --quiet which && \
  yum install -y --quiet java-1.8.0-openjdk && \
  yum install -y --quiet perl-Digest-SHA -y && \
  yum install -y --quiet  net-tools && \
  yum install -y --quiet java-1.8.0-openjdk-devel

#RUN \
#      yum install -y --quiet epel-release && \
#      yum install -y --quiet torsocks

RUN useradd elasticsearch -c 'Elasticsearch User' -d /home/elasticsearch

RUN \
  mkdir -p /local/elasticsearch && \
  chown elasticsearch:elasticsearch /local/elasticsearch && \
  mkdir -p /local/data && \
  chown elasticsearch:elasticsearch /local/data

ENV ES_HOME /local/elasticsearch
ENV ES_CONFIG /local/elasticsearch/config/elasticsearch.yml

ENV JAVA_HOME=/local/elasticsearch/jdk/bin/java

RUN \
  cd /tmp && \
  wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-8.2.2-linux-x86_64.tar.gz && \
  wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-8.2.2-linux-x86_64.tar.gz.sha512 && \
  shasum -a 512 -c elasticsearch-8.2.2-linux-x86_64.tar.gz.sha512 && \
  tar -xzf elasticsearch-8.2.2-linux-x86_64.tar.gz && \
   mv /tmp/elasticsearch-8.2.2/* /local/elasticsearch && \
   chmod -R 777 /local/elasticsearch && \
  mkdir -p /var/lib/data && mkdir -p /var/lib/logs && \
  chmod -R 777 /var/lib/data && chmod -R 777 /var/lib/logs


#RUN \
#torsocks wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-8.2.2-linux-x86_64.tar.gz && \
#torsocks wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-8.2.2-linux-x86_64.tar.gz.sha512 && \
#shasum -a 512 -c elasticsearch-8.2.2-linux-x86_64.tar.gz.sha512 && \
#tar -xzf elasticsearch-8.2.2-linux-x86_64.tar.gz && \
#cd elasticsearch-8.2.2/

ADD elasticsearch.yml /local/elasticsearch/config
EXPOSE 9200
EXPOSE 9300
USER elasticsearch
ENTRYPOINT ["/local/elasticsearch/bin/elasticsearch"]
```
```
[elasticsearch@ea49796e1c21 /]$ yes|/local/elasticsearch/bin/elasticsearch-setup-passwords auto
warning: ignoring JAVA_HOME=/local/elasticsearch/jdk/bin/java; using bundled JDK
******************************************************************************
Note: The 'elasticsearch-setup-passwords' tool has been deprecated. This       command will be removed in a future release.
******************************************************************************

Initiating the setup of passwords for reserved users elastic,apm_system,kibana,kibana_system,logstash_system,beats_system,remote_monitoring_user.
The passwords will be randomly generated and printed to the console.


Changed password for user apm_system
PASSWORD apm_system = JXQ8GsCqu6bNIureCtZA

Changed password for user kibana_system
PASSWORD kibana_system = h99vY66pZSlfqFlUhYqT

Changed password for user kibana
PASSWORD kibana = h99vY66pZSlfqFlUhYqT

Changed password for user logstash_system
PASSWORD logstash_system = Vj2AfcvuDAaQywqLaJfA

Changed password for user beats_system
PASSWORD beats_system = 40cNzHkWxd19hEwzLQk5

Changed password for user remote_monitoring_user
PASSWORD remote_monitoring_user = MACBLpVDGjmZsENVAcLE

Changed password for user elastic
PASSWORD elastic = hifnXu4LM77E98r29fvY


[elasticsearch@ea49796e1c21 /]$ curl -X GET http://localhost:9200/ -u elastic:hifnXu4LM77E98r29fvY
{
  "name" : "ea49796e1c21",
  "cluster_name" : "netology_test",
  "cluster_uuid" : "AkCYkQN7QH-3O8-lSCfpyw",
  "version" : {
    "number" : "8.2.2",
    "build_flavor" : "default",
    "build_type" : "tar",
    "build_hash" : "9876968ef3c745186b94fdabd4483e01499224ef",
    "build_date" : "2022-05-25T15:47:06.259735307Z",
    "build_snapshot" : false,
    "lucene_version" : "9.1.0",
    "minimum_wire_compatibility_version" : "7.17.0",
    "minimum_index_compatibility_version" : "7.0.0"
  },
  "tagline" : "You Know, for Search"
}
```
```
cat elasticsearch.yml
cluster.name: netology_test
discovery.type: single-node
path.data: /var/lib/data
path.logs: /var/lib/logs
network.host: 0.0.0.0
discovery.seed_hosts: ["127.0.0.1", "[::1]"]
```

https://hub.docker.com/repository/docker/sergespb/elastic


## 2.

```
[elasticsearch@9d352a83413d /]$ curl -X PUT localhost:9200/ind-1 -H 'Content-Type: application/json' -d'{ "settings": { "number_of_shards": 1,  "number_of_replicas": 0 }}' -u elastic:fJSj4zQUCShGgGsKsKLt
{"acknowledged":true,"shards_acknowledged":true,"index":"ind-1"}[elasticsearch@9d352a83413d /]$
```
```
[elasticsearch@9d352a83413d /]$ curl -X PUT localhost:9200/ind-2 -H 'Content-Type: application/json' -d'{ "settings": { "number_of_shards": 2,  "number_of_replicas": 1 }}' -u elastic:fJSj4zQUCShGgGsKsKLt
{"acknowledged":true,"shards_acknowledged":true,"index":"ind-2"}[elasticsearch@9d352a83413d /]$
```
```
[elasticsearch@9d352a83413d /]$ curl -X PUT localhost:9200/ind-3 -H 'Content-Type: application/json' -d'{ "settings": { "number_of_shards": 4,  "number_of_replicas": 2 }}'   -u elastic:fJSj4zQUCShGgGsKsKLt
{"acknowledged":true,"shards_acknowledged":true,"index":"ind-3"}[elasticsearch@9d352a83413d /]$
```
```
[elasticsearch@9d352a83413d /]$ curl -X GET 'http://localhost:9200/_cluster/health/ind-1?pretty' -u elastic:fJSj4zQUCShGgGsKsKLt
{
  "cluster_name" : "netology_test",
  "status" : "green",
  "timed_out" : false,
  "number_of_nodes" : 1,
  "number_of_data_nodes" : 1,
  "active_primary_shards" : 1,
  "active_shards" : 1,
  "relocating_shards" : 0,
  "initializing_shards" : 0,
  "unassigned_shards" : 0,
  "delayed_unassigned_shards" : 0,
  "number_of_pending_tasks" : 0,
  "number_of_in_flight_fetch" : 0,
  "task_max_waiting_in_queue_millis" : 0,
  "active_shards_percent_as_number" : 100.0
}
```

```
[elasticsearch@9d352a83413d /]$ curl -X GET 'http://localhost:9200/_cluster/health/ind-1?pretty' -u elastic:fJSj4zQUCShGgGsKsKLt
{
  "cluster_name" : "netology_test",
  "status" : "green",
  "timed_out" : false,
  "number_of_nodes" : 1,
  "number_of_data_nodes" : 1,
  "active_primary_shards" : 1,
  "active_shards" : 1,
  "relocating_shards" : 0,
  "initializing_shards" : 0,
  "unassigned_shards" : 0,
  "delayed_unassigned_shards" : 0,
  "number_of_pending_tasks" : 0,
  "number_of_in_flight_fetch" : 0,
  "task_max_waiting_in_queue_millis" : 0,
  "active_shards_percent_as_number" : 100.0
}
```
```
[elasticsearch@9d352a83413d /]$ curl -X GET 'http://localhost:9200/_cluster/health/ind-2?pretty' -u elastic:fJSj4zQUCShGgGsKsKLt
{
  "cluster_name" : "netology_test",
  "status" : "yellow",
  "timed_out" : false,
  "number_of_nodes" : 1,
  "number_of_data_nodes" : 1,
  "active_primary_shards" : 2,
  "active_shards" : 2,
  "relocating_shards" : 0,
  "initializing_shards" : 0,
  "unassigned_shards" : 2,
  "delayed_unassigned_shards" : 0,
  "number_of_pending_tasks" : 0,
  "number_of_in_flight_fetch" : 0,
  "task_max_waiting_in_queue_millis" : 0,
  "active_shards_percent_as_number" : 47.368421052631575
}
```
```
[elasticsearch@9d352a83413d /]$ curl -X GET 'http://localhost:9200/_cluster/health/ind-3?pretty' -u elastic:fJSj4zQUCShGgGsKsKLt
{
  "cluster_name" : "netology_test",
  "status" : "yellow",
  "timed_out" : false,
  "number_of_nodes" : 1,
  "number_of_data_nodes" : 1,
  "active_primary_shards" : 4,
  "active_shards" : 4,
  "relocating_shards" : 0,
  "initializing_shards" : 0,
  "unassigned_shards" : 8,
  "delayed_unassigned_shards" : 0,
  "number_of_pending_tasks" : 0,
  "number_of_in_flight_fetch" : 0,
  "task_max_waiting_in_queue_millis" : 0,
  "active_shards_percent_as_number" : 47.368421052631575
}
```
```
[elasticsearch@9d352a83413d /]$ curl -XGET localhost:9200/_cluster/health/?pretty=true  -u elastic:fJSj4zQUCShGgGsKsKLt
{
  "cluster_name" : "netology_test",
  "status" : "yellow",
  "timed_out" : false,
  "number_of_nodes" : 1,
  "number_of_data_nodes" : 1,
  "active_primary_shards" : 9,
  "active_shards" : 9,
  "relocating_shards" : 0,
  "initializing_shards" : 0,
  "unassigned_shards" : 10,
  "delayed_unassigned_shards" : 0,
  "number_of_pending_tasks" : 0,
  "number_of_in_flight_fetch" : 0,
  "task_max_waiting_in_queue_millis" : 0,
  "active_shards_percent_as_number" : 47.368421052631575
}
```
```
[elasticsearch@9d352a83413d /]$ curl -X DELETE 'http://localhost:9200/ind-1?pretty' -u elastic:fJSj4zQUCShGgGsKsKLt
{
  "acknowledged" : true
}
```
```
[elasticsearch@9d352a83413d /]$ curl -X DELETE 'http://localhost:9200/ind-2?pretty' -u elastic:fJSj4zQUCShGgGsKsKLt
{
  "acknowledged" : true
}
```
```
[elasticsearch@9d352a83413d /]$ curl -X DELETE 'http://localhost:9200/ind-3?pretty' -u elastic:fJSj4zQUCShGgGsKsKLt
{
  "acknowledged" : true
}
```

```
[elasticsearch@9d352a83413d /]$ curl -X DELETE 'http://localhost:9200/ind-1?pretty' -u elastic:fJSj4zQUCShGgGsKsKLt
{
  "acknowledged" : true
}
```
```
[elasticsearch@9d352a83413d /]$ curl -X DELETE 'http://localhost:9200/ind-2?pretty' -u elastic:fJSj4zQUCShGgGsKsKLt
{
  "acknowledged" : true
}
```
```
[elasticsearch@9d352a83413d /]$ curl -X DELETE 'http://localhost:9200/ind-3?pretty' -u elastic:fJSj4zQUCShGgGsKsKLt
{
  "acknowledged" : true
}
```

индексы жёлтые потому что у нас в кластере только один сервер и негде расположить реплики



## 3.

```
[elasticsearch@f4fd0e3af6d2 /]$ curl -X POST localhost:9200/_snapshot/netology_backup?pretty -H 'Content-Type: application/json' -d'{"type": "fs", "settings": { "location":"/local/elasticsearch/snapshots" }}' -u elastic:eSXB6eqVKOAJcVj9Cmkw
{
  "acknowledged" : true
}
```
```
[elasticsearch@f4fd0e3af6d2 /]$ curl -X PUT localhost:9200/test -H 'Content-Type: application/json' -d'{ "settings": { "number_of_shards": 1,  "number_of_replicas": 0 }}' -u elastic:eSXB6eqVKOAJcVj9Cmkw
{"acknowledged":true,"shards_acknowledged":true,"index":"test"}
```
```
[elasticsearch@f4fd0e3af6d2 /]$ curl -X GET http://localhost:9200/_cat/indices?v -u elastic:eSXB6eqVKOAJcVj9Cmkw
health status index uuid                   pri rep docs.count docs.deleted store.size pri.store.size
green  open   test  goA9798BR5CcmIHl0syMAA   1   0          0            0       225b           225b
```
```
 curl -X GET http://localhost:9200/test?pretty -u elastic:eSXB6eqVKOAJcVj9Cmkw
{
  "test" : {
    "aliases" : { },
    "mappings" : { },
    "settings" : {
      "index" : {
        "routing" : {
          "allocation" : {
            "include" : {
              "_tier_preference" : "data_content"
            }
          }
        },
        "number_of_shards" : "1",
        "provided_name" : "test",
        "creation_date" : "1654458187129",
        "number_of_replicas" : "0",
        "uuid" : "NsiVb7vrQzWrctE45Rsz1g",
        "version" : {
          "created" : "8020299"
        }
      }
    }
  }
}
```
```
[elasticsearch@f4fd0e3af6d2 /]$ curl -X PUT localhost:9200/_snapshot/netology_backup/elasticsearch?wait_for_completion=true -u elastic:eSXB6eqVKOAJcVj9Cmkw
{"snapshot":{"snapshot":"elasticsearch","uuid":"aqzijxY2Q1CQDuKJhHEr5Q","repository":"netology_backup","version_id":8020299,"version":"8.2.2","indices":["test",".security-7",".geoip_databases"],"data_streams":

[],"include_global_state":true,"state":"SUCCESS","start_time":"2022-06-05T19:48:43.055Z","start_time_in_millis":1654458523055,"end_time":"2022-06-

05T19:48:44.456Z","end_time_in_millis":1654458524456,"duration_in_millis":1401,"failures":[],"shards":{"total":3,"failed":0,"successful":3},"feature_states":[{"feature_name":"geoip","indices":[".geoip_databases"]},

{"feature_name":"security","indices":[".security-7"]}]}}[elasticsearch@f4fd0e3af6d2 /]$
```
```
[elasticsearch@f4fd0e3af6d2 /]$ ls -la /local/elasticsearch/snapshots/
total 48
drwxr-xr-x 3 elasticsearch elasticsearch  4096 Jun  5 19:48 .
drwxrwxrwx 1 elasticsearch elasticsearch  4096 Jun  5 19:29 ..
-rw-r--r-- 1 elasticsearch elasticsearch  1098 Jun  5 19:48 index-0
-rw-r--r-- 1 elasticsearch elasticsearch     8 Jun  5 19:48 index.latest
drwxr-xr-x 5 elasticsearch elasticsearch  4096 Jun  5 19:48 indices
-rw-r--r-- 1 elasticsearch elasticsearch 18392 Jun  5 19:48 meta-aqzijxY2Q1CQDuKJhHEr5Q.dat
-rw-r--r-- 1 elasticsearch elasticsearch   390 Jun  5 19:48 snap-aqzijxY2Q1CQDuKJhHEr5Q.dat
```
```
[elasticsearch@f4fd0e3af6d2 /]$ curl -X DELETE 'http://localhost:9200/test?pretty' -u elastic:eSXB6eqVKOAJcVj9Cmkw
{
  "acknowledged" : true
}
```
```
[elasticsearch@f4fd0e3af6d2 /]$ curl -X PUT localhost:9200/test-2?pretty -H 'Content-Type: application/json' -d'{ "settings": { "number_of_shards": 1,  "number_of_replicas": 0 }}' -u elastic:eSXB6eqVKOAJcVj9Cmkw
{
  "acknowledged" : true,
  "shards_acknowledged" : true,
  "index" : "test-2"
}
```
```
[elasticsearch@f4fd0e3af6d2 /]$ curl -X GET http://localhost:9200/_cat/indices?v -u elastic:eSXB6eqVKOAJcVj9Cmkw
health status index  uuid                   pri rep docs.count docs.deleted store.size pri.store.size
green  open   test-2 07mzryKdTpCghqvF6qctIQ   1   0          0            0       225b           225b
```
```
[elasticsearch@f4fd0e3af6d2 /]$ curl -X POST localhost:9200/_snapshot/netology_backup/elasticsearch/_restore?pretty -H 'Content-Type: application/json' -d'{"include_global_state":true}' -u elastic:eSXB6eqVKOAJcVj9Cmkw
{
  "accepted" : true
}
```
```
[elasticsearch@f4fd0e3af6d2 /]$ curl -X GET http://localhost:9200/_cat/indices?v -u elastic:eSXB6eqVKOAJcVj9Cmkw
health status index  uuid                   pri rep docs.count docs.deleted store.size pri.store.size
green  open   test-2 HC8g5uUITxGihdZhHRlwWw   1   0          0            0       225b           225b
green  open   test   KTRanCA3RWehzrG8Djl7bQ   1   0          0            0       225b           225b
```

