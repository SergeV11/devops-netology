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

import socket

def get_ipv4_by_hostname(hostname):

    return list(
        i
            [4]
            [0]
        for i in
        socket.getaddrinfo(
            hostname,
            0
        )
        if i[0] is socket.AddressFamily.AF_INET

        and i[1] is socket.SocketKind.SOCK_RAW
    )

a='drive.google.com - ' + str(get_ipv4_by_hostname('drive.google.com'))
b='mail.google.com - ' + str(get_ipv4_by_hostname('mail.google.com'))
c='google.com - ' + str(get_ipv4_by_hostname('google.com'))

a1=str(get_ipv4_by_hostname('drive.google.com'))+ '\n'
b1=str(get_ipv4_by_hostname('mail.google.com'))+ '\n'
c1=str(get_ipv4_by_hostname('google.com'))+ '\n'

a2=str(get_ipv4_by_hostname('drive.google.com'))
b2=str(get_ipv4_by_hostname('mail.google.com'))
c2=str(get_ipv4_by_hostname('google.com'))



try:
    file = open('ips.log')
except IOError as e:
    print(u'не удалось открыть файл')
else:
    with file:
        array=[row.strip() for row in file]
        if (a2!=array[0]):
             print('[ERROR] drive.google.com IP mismatch:' + array[0] + a2)
        if (b2 != array[1]):
             print('[ERROR] mail.google.com IP mismatch:' + array[1] + b2)
        if (c2 != array[2]):
            print('[ERROR] google.com IP mismatch:' + array[2] + c2)

fp = open('ips.log', 'w')
fp.write(a1)
fp.write(b1)
fp.write(c1)
fp.close()

print(a)
print(b)
print(c)
```

### Вывод скрипта при запуске при тестировании:
```
python3 1.py
[ERROR] google.com IP mismatch:['142.250.179.174']['142.250.179.206']
drive.google.com - ['142.251.36.46']
mail.google.com - ['142.250.179.165']
google.com - ['142.250.179.206']

python3 1.py
drive.google.com - ['142.251.36.46']
mail.google.com - ['142.250.179.165']
google.com - ['142.250.179.206']
```
