# Домашнее задание к занятию "4.2. Использование Python для решения типовых DevOps задач"

## Обязательная задача 1

Есть скрипт:
```python
#!/usr/bin/env python3
a = 1
b = '2'
c = a + b
```

### Вопросы:
| Вопрос  | Ответ |
| ------------- | ------------- |
| Какое значение будет присвоено переменной `c`?  | скрипт завершится с ошибкой, так как тут попытка сложить текст и число  |
| Как получить для переменной `c` значение 12?  | привести переменную а к строке: str(a)  |
| Как получить для переменной `c` значение 3?  | привести переменную b к числу int(b)  |

## Обязательная задача 2
Мы устроились на работу в компанию, где раньше уже был DevOps Engineer. Он написал скрипт, позволяющий узнать, какие файлы модифицированы в репозитории, относительно локальных изменений. Этим скриптом недовольно начальство, потому что в его выводе есть не все изменённые файлы, а также непонятен полный путь к директории, где они находятся. Как можно доработать скрипт ниже, чтобы он исполнял требования вашего руководителя?

```python
#!/usr/bin/env python3

import os

bash_command = ["cd ~/netology/sysadm-homeworks", "git status"]
result_os = os.popen(' && '.join(bash_command)).read()
is_change = False
for result in result_os.split('\n'):
    if result.find('modified') != -1:
        prepare_result = result.replace('\tmodified:   ', '')
        print(prepare_result)
        break
```

### Ваш скрипт:
```python
#!/usr/bin/env python3

import os

bash_command = ["cd git/devops-netology", "git status"]
result_os = os.popen(' && '.join(bash_command)).read()
is_change = False
for result in result_os.split('\n'):
    if result.find('modified') != -1:
        prepare_result = os.getcwd()  + '/' + result.replace('\tmodified:   ', '')
        print(prepare_result)
       # break
```

### Вывод скрипта при запуске при тестировании:
```
/home/adm/netology/has_been_moved.txt
/home/adm/netology/merge.sh
```

## Обязательная задача 3
1. Доработать скрипт выше так, чтобы он мог проверять не только локальный репозиторий в текущей директории, а также умел воспринимать путь к репозиторию, который мы передаём как входной параметр. Мы точно знаем, что начальство коварное и будет проверять работу этого скрипта в директориях, которые не являются локальными репозиториями.

### Ваш скрипт:
```python
#!/usr/bin/env python3

import os
import sys
from subprocess import call, STDOUT

os.chdir(sys.argv[1])

if call(["git", "branch"], stderr=STDOUT, stdout=open(os.devnull, 'w')) != 0:
    print("Directory is not repository!")
    sys.exit()
else:
    bash_command = [ "git status"]
    result_os = os.popen(' && '.join(bash_command)).read()
    is_change = False
    for result in result_os.split('\n'):
        if result.find('modified') != -1:
            prepare_result = os.getcwd()  + '/' + result.replace('\tmodified:   ', '')
            print(prepare_result)
```

### Вывод скрипта при запуске при тестировании:
```
python3 1.py /home/adm/netology/git/devops-netology
/home/adm/netology/git/devops-netology/has_been_moved.txt
/home/adm/netology/git/devops-netology/merge.sh

python3 1.py /home/admin1/netology/git
Directory is not repository!
```

## Обязательная задача 4
1. Наша команда разрабатывает несколько веб-сервисов, доступных по http. Мы точно знаем, что на их стенде нет никакой балансировки, кластеризации, за DNS прячется конкретный IP сервера, где установлен сервис. Проблема в том, что отдел, занимающийся нашей инфраструктурой очень часто меняет нам сервера, поэтому IP меняются примерно раз в неделю, при этом сервисы сохраняют за собой DNS имена. Это бы совсем никого не беспокоило, если бы несколько раз сервера не уезжали в такой сегмент сети нашей компании, который недоступен для разработчиков. Мы хотим написать скрипт, который опрашивает веб-сервисы, получает их IP, выводит информацию в стандартный вывод в виде: <URL сервиса> - <его IP>. Также, должна быть реализована возможность проверки текущего IP сервиса c его IP из предыдущей проверки. Если проверка будет провалена - оповестить об этом в стандартный вывод сообщением: [ERROR] <URL сервиса> IP mismatch: <старый IP> <Новый IP>. Будем считать, что наша разработка реализовала сервисы: `drive.google.com`, `mail.google.com`, `google.com`.

### Ваш скрипт:
```python
#!/usr/bin/env python3

import dns.resolver
import time
import os

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
      servers[host]=ip
  chislo_proverok +=1
  #change dns
  if chislo_proverok ==3 :
    os.popen('echo 127.0.0.1 drive.google.com >> /etc/hosts ')
  if chislo_proverok  >= 10 :
    break
  time.sleep(zaderjka)

```

### Вывод скрипта при запуске при тестировании:
```
[ERROR] google.com IP mistmatch: 127.0.0.1 172.217.168.14
[ERROR] mail.google.com IP mistmatch: 127.0.0.1 172.217.168.69
[ERROR] drive.google.com IP mistmatch: 127.0.0.1 172.217.168.46


[ERROR] drive.google.com IP mistmatch: 172.217.168.46 127.0.0.1

```
