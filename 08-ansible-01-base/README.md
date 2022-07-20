# Домашнее задание к занятию "08.01 Введение в Ansible"

## 1.
```
root@nM:/home/cht/netology/ansible/mnt-homeworks/08-ansible-01-base/playbook# ansible-playbook -i inventory/test.yml site.yml

PLAY [Print os facts] 

***********************************************************************************************************************************************************************************************************************

TASK [Gathering Facts] 

**********************************************************************************************************************************************************************************************************************
ok: [localhost]

TASK [Print OS] 

*****************************************************************************************************************************************************************************************************************************
ok: [localhost] => {
    "msg": "Ubuntu"
}

TASK [Print fact] 

***************************************************************************************************************************************************************************************************************************
ok: [localhost] => {
    "msg": 12
}

PLAY RECAP 

**********************************************************************************************************************************************************************************************************************************
localhost                  : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
```

## 2.
```
sed -i "s/12/all default fact/g" group_vars/all/examp.yml
```
## 3.
```
cat docker-compose.yml;echo -e "=====";cat Dockerfile;echo -e "=====";cat Dockerfile2
version: '3.3'

services:
  ubuntu-netology:
    container_name: ubuntu
    build:
      context: .
      dockerfile: Dockerfile
    networks:
      - neto
  centos-netology:
    container_name: centos7
    build:
      context: .
      dockerfile: Dockerfile2
    networks:
      - neto
networks:
  neto:
    driver: bridge
    external: false
=====
FROM brunneis/python:3.7.3-ubuntu-18.04
ENTRYPOINT ["tail"]
CMD ["-f","/dev/null"]
=====
FROM centos/python-38-centos7
ENTRYPOINT ["tail"]
CMD ["-f","/dev/null"]
```
## 4.
```
root@nM:/home/cht/netology/ansible/mnt-homeworks/08-ansible-01-base/playbook# ansible-playbook -i inventory/prod.yml site.yml

PLAY [Print os facts] 

***********************************************************************************************************************************************************************************************************************

TASK [Gathering Facts] 

**********************************************************************************************************************************************************************************************************************
ok: [ubuntu]
ok: [centos7]

TASK [Print OS] 

*****************************************************************************************************************************************************************************************************************************
ok: [centos7] => {
    "msg": "CentOS"
}
ok: [ubuntu] => {
    "msg": "Ubuntu"
}

TASK [Print fact] 

***************************************************************************************************************************************************************************************************************************
ok: [centos7] => {
    "msg": "el"
}
ok: [ubuntu] => {
    "msg": "deb"
}

PLAY RECAP 

**********************************************************************************************************************************************************************************************************************************
centos7                    : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
ubuntu                     : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
```
## 5.
```
sed -i "s/deb/deb default fact/g" group_vars/deb/examp.yml
sed -i "s/el/el default fact/g" group_vars/el/examp.yml
```
## 6.
```
root@nM:/home/cht/netology/ansible/mnt-homeworks/08-ansible-01-base/playbook# ansible-playbook -i inventory/prod.yml site.yml

PLAY [Print os facts] 

***********************************************************************************************************************************************************************************************************************

TASK [Gathering Facts] 

**********************************************************************************************************************************************************************************************************************
ok: [ubuntu]
ok: [centos7]

TASK [Print OS] 

*****************************************************************************************************************************************************************************************************************************
ok: [centos7] => {
    "msg": "CentOS"
}
ok: [ubuntu] => {
    "msg": "Ubuntu"
}

TASK [Print fact] 

***************************************************************************************************************************************************************************************************************************
ok: [centos7] => {
    "msg": "el default fact"
}
ok: [ubuntu] => {
    "msg": "deb default fact"
}

PLAY RECAP 

**********************************************************************************************************************************************************************************************************************************
centos7                    : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
ubuntu                     : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
```
## 7.
```
root@nM:/home/cht/netology/ansible/mnt-homeworks/08-ansible-01-base/playbook# ansible-vault encrypt group_vars/deb/examp.yml
New Vault password:
Confirm New Vault password:
Encryption successful
root@nM:/home/cht/netology/ansible/mnt-homeworks/08-ansible-01-base/playbook# ansible-vault encrypt group_vars/el/examp.yml
New Vault password:
Confirm New Vault password:
Encryption successful
```
## 8.
```
root@nM:/home/cht/netology/ansible/mnt-homeworks/08-ansible-01-base/playbook# ansible-playbook -i inventory/prod.yml site.yml --ask-vault-pass
Vault password:

PLAY [Print os facts] 

***********************************************************************************************************************************************************************************************************************

TASK [Gathering Facts] 

**********************************************************************************************************************************************************************************************************************
ok: [ubuntu]
ok: [centos7]

TASK [Print OS] 

*****************************************************************************************************************************************************************************************************************************
ok: [centos7] => {
    "msg": "CentOS"
}
ok: [ubuntu] => {
    "msg": "Ubuntu"
}

TASK [Print fact] 

***************************************************************************************************************************************************************************************************************************
ok: [centos7] => {
    "msg": "el default fact"
}
ok: [ubuntu] => {
    "msg": "deb default fact"
}

PLAY RECAP 

**********************************************************************************************************************************************************************************************************************************
centos7                    : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
ubuntu                     : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
```
## 9.
```
для control node подходит local
```
## 10.
```
echo "  local:
    hosts:
      localhost:
        ansible_connection: local" >> inventory/prod.yml
```
## 11.
```
root@nM:/home/cht/netology/ansible/mnt-homeworks/08-ansible-01-base/playbook# ansible-playbook -i inventory/prod.yml site.yml --ask-vault-pass
Vault password:

PLAY [Print os facts] 

***********************************************************************************************************************************************************************************************************************

TASK [Gathering Facts] 

**********************************************************************************************************************************************************************************************************************
ok: [localhost]
ok: [ubuntu]
ok: [centos7]

TASK [Print OS] 

*****************************************************************************************************************************************************************************************************************************
ok: [localhost] => {
    "msg": "Ubuntu"
}
ok: [centos7] => {
    "msg": "CentOS"
}
ok: [ubuntu] => {
    "msg": "Ubuntu"
}

TASK [Print fact] 

***************************************************************************************************************************************************************************************************************************
ok: [localhost] => {
    "msg": "all default fact"
}
ok: [centos7] => {
    "msg": "el default fact"
}
ok: [ubuntu] => {
    "msg": "deb default fact"
}

PLAY RECAP 

**********************************************************************************************************************************************************************************************************************************
centos7                    : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
localhost                  : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
ubuntu                     : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
```

