# Домашнее задание к занятию "08.04 Создание собственных modules"

## 1.

ok

## 2.

ok

## 3.

ok

## 4.

```
(venv) root@nM:/home/cht/netology/ansible/modules/ansible# python3 -m ansible.modules.my_own_module  args.json

{"changed": true, "original_message": "test text", "message": "success", "invocation": {"module_args": {"path": "/tmp/test.file", "content": "test text"}}}

(venv) root@nM:/home/cht/netology/ansible/modules/ansible# cat /tmp/test.file
test text

(venv) root@nM:/home/cht/netology/ansible/modules/ansible# cat args.json
{
"ANSIBLE_MODULE_ARGS": {
"path": "/tmp/test.file",
"content": "test text"
}
}
```

## 5.

```
(venv) root@nM:/home/cht/netology/ansible/modules/ansible# ansible-playbook  file_task.yml

PLAY [test] 

*********************************************************************************************************************************************************************************************************************************

TASK [Gathering Facts] 

**********************************************************************************************************************************************************************************************************************
ok: [127.0.0.1]

TASK [execute own module] 

*******************************************************************************************************************************************************************************************************************
changed: [127.0.0.1]

PLAY RECAP 

**********************************************************************************************************************************************************************************************************************************
127.0.0.1                  : ok=2    changed=1    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0


(venv) root@nM:/home/cht/netology/ansible/modules/ansible# cat /tmp/test.log
random text
(venv) root@nM:/home/cht/netology/ansible/modules/ansible# cat file_task.yml
- name: test
  hosts:
    - 127.0.0.1
  connection: local
  tasks:
    - name  : execute own module
      my_own_module:
        path: "/tmp/test.log"
        content: "random text"
```

## 6.

```
(venv) root@nM:/home/cht/netology/ansible/modules/ansible# ansible-playbook  file_task.yml
[WARNING]: You are running the development version of Ansible. You should only run Ansible from "devel" if you are modifying the Ansible engine, or trying out features under development. This is a rapidly changing source of code and can
become unstable at any point.

PLAY [test] 

*********************************************************************************************************************************************************************************************************************************

TASK [Gathering Facts] 

**********************************************************************************************************************************************************************************************************************
ok: [127.0.0.1]

TASK [execute own module] 

*******************************************************************************************************************************************************************************************************************
ok: [127.0.0.1]

PLAY RECAP 

**********************************************************************************************************************************************************************************************************************************
127.0.0.1                  : ok=2    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
```

## 7.

```
(venv) root@nM:/home/cht/netology/ansible/modules/ansible# deactivate
```

## 8.

```
root@nM:/home/cht/netology/ansible/modules/ansible# ansible-galaxy collection init my_own_namespace.my_own_collection
- Collection my_own_namespace.my_own_collection was created successfully
```

## 9.

```
root@nM:/home/cht/netology/ansible/modules/ansible# mkdir my_own_namespace/my_own_collection/plugins/modules && cp lib/ansible/modules/my_own_module.py my_own_namespace/my_own_collection/plugins/modules
```

## 10.

ok

## 11.

```
root@nM:/home/cht/netology/ansible/modules/ansible/my_own_namespace/my_own_collection# cat site_role.yml
- name: test
  hosts:
    - 127.0.0.1
  connection: local
  tasks:
    - include_role:
        name: my_own_role


root@nM:/home/cht/netology/ansible/modules/ansible/my_own_namespace/my_own_collection# ansible-playbook site_role.yml
[WARNING]: provided hosts list is empty, only localhost is available. Note that the implicit localhost does not match 'all'

PLAY [test] 

*********************************************************************************************************************************************************************************************************************************

TASK [Gathering Facts] 

**********************************************************************************************************************************************************************************************************************
ok: [127.0.0.1]

TASK [include_role : my_own_role] 

***********************************************************************************************************************************************************************************************************

TASK [my_own_role : run module] 

*************************************************************************************************************************************************************************************************************
changed: [127.0.0.1]

PLAY RECAP 

**********************************************************************************************************************************************************************************************************************************
127.0.0.1                  : ok=2    changed=1    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
```

## 12.

ok

## 13.

```
root@nM:/home/cht/netology/ansible/modules/ansible/my_own_namespace/my_own_collection# ansible-galaxy collection build
Created collection for my_own_namespace.my_own_collection at /home/cht/netology/ansible/modules/ansible/my_own_namespace/my_own_collection/my_own_namespace-my_own_collection-1.0.0.tar.gz
```

## 14.

```
root@nM:/home/cht/netology/ansible/modules/ansible/my_own_namespace/my_own_collection# mkdir /tmp/111
root@nM:/home/cht/netology/ansible/modules/ansible/my_own_namespace/my_own_collection# cp ../../file_task.yml /tmp/111/
root@nM:/home/cht/netology/ansible/modules/ansible/my_own_namespace/my_own_collection# cp my_own_namespace-my_own_collection-1.0.0.tar.gz /tmp/111/
```

## 15.

```
root@nM:/home/cht/netology/ansible/modules/ansible/my_own_namespace/my_own_collection# cd /tmp/111/
root@nM:/tmp/111# ansible-galaxy collection install my_own_namespace-my_own_collection-1.0.0.tar.gz
Process install dependency map
Starting collection install process
Installing 'my_own_namespace.my_own_collection:1.0.0' to '/root/.ansible/collections/ansible_collections/my_own_namespace/my_own_collection'
```

## 16.

```
root@nM:/tmp/111# ansible-playbook file_task.yml
[WARNING]: provided hosts list is empty, only localhost is available. Note that the implicit localhost does not match 'all'

PLAY [test] 

*********************************************************************************************************************************************************************************************************************************

TASK [Gathering Facts] 

**********************************************************************************************************************************************************************************************************************
ok: [127.0.0.1]

TASK [execute own module] 

*******************************************************************************************************************************************************************************************************************
changed: [127.0.0.1]

PLAY RECAP 

**********************************************************************************************************************************************************************************************************************************
127.0.0.1                  : ok=2    changed=1    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
```

## 17.

```
https://github.com/SergeV11/my_own_collection
```
