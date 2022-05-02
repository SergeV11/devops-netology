# Домашнее задание к занятию "5.2. Применение принципов IaaC в работе с виртуальными машинами"

## 1.

- из преимуществ можно отметить удобство управлением конфигурациями серверов, удобство обновления (не нужно заходить на каждый сервер и обновлять какое-то по), а также посмотрев в плейбук можно определить в каком состоянии находится та или иная группа серверов, какое ПО стоит и какие конфиги используются.
- идемпотентность, то есть если запустить плейбук много раз, то мы получим одно и тоже состояние сервера.


## 2.

- энсибл использует метод push, который избавляет от необходимости установки агента на все сервера, а также он проще в освоении 
- метод pull более надёжный, так как при большом парке серверов нет одновременной нагрузки на сервер при отправке новых заданий


## 3.

```
root@nM:/home/cht# vagrant --version
Vagrant 2.0.2
```
```
root@nM:/home/cht# vboxmanage --version
5.2.42_Ubuntur137960
```
```
root@nM:/home/cht# ansible --version
ansible 2.5.1
config file = /etc/ansible/ansible.cfg
configured module search path = [u'/root/.ansible/plugins/modules', u'/usr/share/ansible/plugins/modules']
ansible python module location = /usr/lib/python2.7/dist-packages/ansible
executable location = /usr/bin/ansible
python version = 2.7.17 (default, Mar 18 2022, 13:21:42) [GCC 7.5.0]
```
