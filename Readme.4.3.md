# Домашнее задание к занятию "4.3. Языки разметки JSON и YAML"


## Обязательная задача 1
Мы выгрузили JSON, который получили через API запрос к нашему сервису:
```
    { "info" : "Sample JSON output from our service\t",
        "elements" :[
            { "name" : "first",
            "type" : "server",
            "ip" : 7175 
            }
            { "name" : "second",
            "type" : "proxy",
            "ip : 71.78.22.43
            }
        ]
    }
```
  Нужно найти и исправить все ошибки, которые допускает наш сервис
  
  Ответ:</br>
  пропущена запятая после фигурной скобки "ip" : 7175 }</br>
ключ ip , пропущены кавычки "ip : 71.78.22.43</br>
значение ip, пропущены кавычки 71.78 .22 .43</br>

правильный json будет выглядеть так:
```
 {
  	"info": "Sample JSON output from our service\t",
  	"elements": [{
  		"name": "first",
  		"type": "server",
  		"ip": 7175
  	}, {
  		"name": "second",
  		"type": "proxy",
  		"ip": "71.78 .22 .43"
  	}]
  }
```
## Обязательная задача 2
В прошлый рабочий день мы создавали скрипт, позволяющий опрашивать веб-сервисы и получать их IP. К уже реализованному функционалу нам нужно добавить возможность записи JSON и YAML файлов, описывающих наши сервисы. Формат записи JSON по одному сервису: `{ "имя сервиса" : "его IP"}`. Формат записи YAML по одному сервису: `- имя сервиса: его IP`. Если в момент исполнения скрипта меняется IP у сервиса - он должен так же поменяться в yml и json файле.

### Ваш скрипт:
```python
#!/usr/bin/env python3

import dns.resolver
import time
import os
import json
import yaml

b=0
chislo_proverok = 1
zaderjka = 3
servers = {'google.com':'127.0.0.1', 'mail.google.com':'127.0.0.1', 'drive.google.com':'127.0.0.1'}

while 1==1 :
  for host in servers:
    answer=dns.resolver.query(host, "A")
    for data in answer:
     ip = data.address

    if ip != servers[host]:
      if chislo_proverok==1 or b !=1:
         print('[ERROR] ' + str(host) +' IP mistmatch: '+servers[host]+' '+ip)

                 # json
         with open(host + "_server.json",'w') as x:
           json_string= json.dumps({host:ip})
           x.write(json_string)

        # yaml
         with open(host + "_server.yaml",'w') as y:
           yaml_string= yaml.dump([{host : ip}])
           y.write(yaml_string)

      servers[host]=ip
  chislo_proverok +=1
  #change dns 1
  if chislo_proverok ==3 :
    os.popen('echo 127.0.0.1 drive.google.com >> /etc/hosts ')

  #change dns 2
  if chislo_proverok ==7 :
    os.popen('sed -i "\$ d" /etc/hosts ')

  if chislo_proverok  >= 10 :
    break

  time.sleep(zaderjka)

```

### Вывод скрипта при запуске при тестировании:
```
[ERROR] google.com IP mistmatch: 127.0.0.1 142.250.179.142
[ERROR] mail.google.com IP mistmatch: 127.0.0.1 142.250.179.165
[ERROR] drive.google.com IP mistmatch: 127.0.0.1 142.251.36.46
[ERROR] drive.google.com IP mistmatch: 142.251.36.46 127.0.0.1
[ERROR] drive.google.com IP mistmatch: 127.0.0.1 142.251.36.46
```

### json-файл(ы), который(е) записал ваш скрипт:
```bash

ll |grep json
-rw-r--r--  1 root   root     37 Mar 30 06:42 drive.google.com_server.json
-rw-r--r--  1 root   root     33 Mar 30 06:42 google.com_server.json
-rw-r--r--  1 root   root     38 Mar 30 06:42 mail.google.com_server.json

cat google.com_server.json drive.google.com_server.json mail.google.com_server.json
{"google.com": "142.250.179.142"}{"drive.google.com": "142.251.36.46"}{"mail.google.com": "142.250.179.165"}
```

### yml-файл(ы), который(е) записал ваш скрипт:
```yaml
 ll |grep yaml
-rw-r--r--  1 root   root     36 Mar 30 06:42 drive.google.com_server.yaml
-rw-r--r--  1 root   root     32 Mar 30 06:42 google.com_server.yaml
-rw-r--r--  1 root   root     37 Mar 30 06:42 mail.google.com_server.yaml

 cat drive.google.com_server.yaml google.com_server.yaml mail.google.com_server.yaml
- {drive.google.com: 142.251.36.46}
- {google.com: 142.250.179.142}
- {mail.google.com: 142.250.179.165}
```
