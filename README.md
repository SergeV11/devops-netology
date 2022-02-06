1. Изучено. эффективное использование в частности для p2p сетей
2. не могут, так как метаданные записаны в одном и том же иноде, и при изменении прав на файле,они изменятся на остальных хард линках
3. 
root@vagrant:/home/vagrant# fdisk -l |grep "Disk /dev/sd"
Disk /dev/sda: 64 GiB, 68719476736 bytes, 134217728 sectors
Disk /dev/sdb: 2.51 GiB, 2684354560 bytes, 5242880 sectors
Disk /dev/sdc: 2.51 GiB, 2684354560 bytes, 5242880 sectors
4.
root@vagrant:/home/vagrant# fdisk -l |grep /dev/sdb
Disk /dev/sdb: 2.51 GiB, 2684354560 bytes, 5242880 sectors
/dev/sdb1          2048 4196351 4194304    2G 83 Linux
/dev/sdb2       4196352 5242879 1046528  511M 83 Linux
5.
sfdisk -d /dev/sdb|sfdisk --force /dev/sdc

root@vagrant:/home/vagrant# fdisk -l |grep /dev/sdc
Disk /dev/sdc: 2.51 GiB, 2684354560 bytes, 5242880 sectors
/dev/sdc1          2048 4196351 4194304    2G 83 Linux
/dev/sdc2       4196352 5242879 1046528  511M 83 Linux

6. mdadm --create --verbose /dev/md0 --level=1 --raid-devices=2 /dev/sdb1 /dev/sdc1
7. mdadm --create --verbose /dev/md1 --level=0 --raid-devices=2 /dev/sdb2 /dev/sdc2
8. pvcreate /dev/md0 /dev/md1
9. vgcreate vg1 /dev/md0 /dev/md1
10. lvcreate -L 100M vg1 /dev/md1
11. mkfs.ext4 /dev/vg1/lvol0
12. mkdir /tmp/new && mount /dev/vg1/lvol0 /tmp/new
13. wget https://mirror.yandex.ru/ubuntu/ls-lR.gz -O /tmp/new/test.gz
14.
lsblk
NAME                      MAJ:MIN RM  SIZE RO TYPE  MOUNTPOINT
loop0                       7:0    0 55.5M  1 loop  /snap/core18/2253
loop1                       7:1    0 61.9M  1 loop  /snap/core20/1328
loop2                       7:2    0 43.3M  1 loop  /snap/snapd/14295
loop3                       7:3    0 61.9M  1 loop  /snap/core20/1270
loop4                       7:4    0 55.5M  1 loop  /snap/core18/2284
loop5                       7:5    0 67.2M  1 loop  /snap/lxd/21835
loop6                       7:6    0 43.4M  1 loop  /snap/snapd/14549
loop7                       7:7    0 70.3M  1 loop  /snap/lxd/21029
sda                         8:0    0   64G  0 disk
+-sda1                      8:1    0    1M  0 part
+-sda2                      8:2    0    1G  0 part  /boot
L-sda3                      8:3    0   63G  0 part
  L-ubuntu--vg-ubuntu--lv 253:0    0 31.5G  0 lvm   /
sdb                         8:16   0  2.5G  0 disk
+-sdb1                      8:17   0    2G  0 part
¦ L-md0                     9:0    0    2G  0 raid1
L-sdb2                      8:18   0  511M  0 part
  L-md1                     9:1    0 1018M  0 raid0
    L-vg1-lvol0           253:1    0  100M  0 lvm   /tmp/new
sdc                         8:32   0  2.5G  0 disk
+-sdc1                      8:33   0    2G  0 part
¦ L-md0                     9:0    0    2G  0 raid1
L-sdc2                      8:34   0  511M  0 part
  L-md1                     9:1    0 1018M  0 raid0
    L-vg1-lvol0           253:1    0  100M  0 lvm   /tmp/new
sr0                        11:0    1 1024M  0 rom

15.
root@vagrant:/tmp/new# gzip -t /tmp/new/test.gz
root@vagrant:/tmp/new# echo $?
0
16. pvmove /dev/md1
17. mdadm /dev/md0 --fail /dev/sdb1
18.
dmesg |grep md0
[  925.760457] md/raid1:md0: not clean -- starting background reconstruction
[  925.760458] md/raid1:md0: active with 2 out of 2 mirrors
[  925.760469] md0: detected capacity change from 0 to 2144337920
[  925.761266] md: resync of RAID array md0
[  936.067807] md: md0: resync done.
[ 3881.179646] md/raid1:md0: Disk failure on sdb1, disabling device.
               md/raid1:md0: Operation continuing on 1 devices.
19.
root@vagrant:/tmp/new#  gzip -t /tmp/new/test.gz
root@vagrant:/tmp/new# echo $?
0

20.vagrant destroy




======================================================================================================================================================================
=====================================================================================================================================================================
=====================================================================================================================================================================





1.
useradd node_exporter -s /sbin/nologin
 wget https://github.com/prometheus/node_exporter/releases/download/v1.1.2/node_exporter-1.1.2.linux-amd64.tar.gz
 tar xvfz node_exporter-*.*-amd64.tar.gz
 cp node_exporter-*.*-amd64/node_exporter /usr/sbin/
 echo "
[Unit]
Description=Node Exporter

[Service]
User=node_exporter
EnvironmentFile=/etc/sysconfig/node_exporter
ExecStart=/usr/sbin/node_exporter $OPTIONS

[Install]
WantedBy=multi-user.target
" > /etc/systemd/system/node_exporter.service

 mkdir -p /etc/sysconfig
 touch /etc/sysconfig/node_exporter

 systemctl daemon-reload
 systemctl enable node_exporter
 systemctl start node_exporter
 systemctl restart node_exporter


2.
curl http://localhost:9100/metrics|grep node_cpu_seconds
node_cpu_seconds_total{cpu="0",mode="idle"} 2046.66
node_cpu_seconds_total{cpu="0",mode="iowait"} 9.93
node_cpu_seconds_total{cpu="0",mode="system"} 10.57
node_cpu_seconds_total{cpu="0",mode="user"} 2.64

root@vagrant:/home/vagrant# curl http://localhost:9100/metrics|grep node_memory_Mem|grep -v "#"
node_memory_MemAvailable_bytes 7.28158208e+08
node_memory_MemFree_bytes 6.75213312e+08
node_memory_MemTotal_bytes 1.028685824e+09

root@vagrant:/home/vagrant# curl http://localhost:9100/metrics|grep node_disk|grep sda |grep -v " 0"
node_disk_io_time_seconds_total{device="sda"} 18.748
node_disk_io_time_weighted_seconds_total{device="sda"} 42.92
node_disk_read_bytes_total{device="sda"} 3.5017728e+08
node_disk_read_time_seconds_total{device="sda"} 32.102000000000004
node_disk_reads_completed_total{device="sda"} 21152
node_disk_reads_merged_total{device="sda"} 3968
node_disk_write_time_seconds_total{device="sda"} 34.412
node_disk_writes_completed_total{device="sda"} 40779
node_disk_writes_merged_total{device="sda"} 1203
node_disk_written_bytes_total{device="sda"} 2.38563328e+08

root@vagrant:/home/vagrant# curl http://localhost:9100/metrics|grep eth0|grep -v " 0"
node_arp_entries{device="eth0"} 2
node_network_receive_bytes_total{device="eth0"} 1.0106128e+07
node_network_receive_drop_total{device="eth0"} 63
node_network_receive_multicast_total{device="eth0"} 63
node_network_receive_packets_total{device="eth0"} 13419
node_network_speed_bytes{device="eth0"} 1.25e+08
node_network_transmit_bytes_total{device="eth0"} 1.947757e+06
node_network_transmit_packets_total{device="eth0"} 8959
node_network_transmit_queue_length{device="eth0"} 1000
node_network_up{device="eth0"} 1


3.
root@vagrant:/home/vagrant# ps aux |grep netdata
netdata     2116  1.3  3.6 301884 36852 ?        Sl   20:31   0:03 /usr/sbin/netdata
netdata     2118  0.0  0.8  33924  9028 ?        Sl   20:31   0:00 /usr/sbin/netdata --special-spawn-server
netdata     2283  0.1  0.2   4032  2952 ?        S    20:31   0:00 bash /usr/libexec/netdata/plugins.d/tc-qos-helper.sh 1
netdata     2284  0.2  2.5 731560 25400 ?        Sl   20:31   0:00 /usr/libexec/netdata/plugins.d/go.d.plugin 1
netdata     2289  1.7  0.5  59208  5336 ?        S    20:31   0:04 /usr/libexec/netdata/plugins.d/apps.plugin 1
root        2290  0.0  0.2  10548  2024 ?        S    20:31   0:00 /usr/libexec/netdata/plugins.d/nfacct.plugin 1
netdata     2557  1.5  4.2 307504 42412 ?        Sl   20:32   0:03 /usr/sbin/netdata
netdata     2559  0.0  0.9  33924  9284 ?        Sl   20:32   0:00 /usr/sbin/netdata --special-spawn-server
netdata     2715  0.1  0.2   4032  2780 ?        S    20:32   0:00 bash /usr/libexec/netdata/plugins.d/tc-qos-helper.sh 1
root        2732  0.0  0.2  10548  2088 ?        S    20:32   0:00 /usr/libexec/netdata/plugins.d/nfacct.plugin 1
netdata     2737  1.7  0.5  59196  5528 ?        S    20:32   0:03 /usr/libexec/netdata/plugins.d/apps.plugin 1
netdata     2740  0.2  2.4 731304 24680 ?        Sl   20:32   0:00 /usr/libexec/netdata/plugins.d/go.d.plugin 1
root        2750  0.8  0.7 1233960 7508 ?        Sl   20:32   0:01 /usr/libexec/netdata/plugins.d/ebpf.plugin 1
root        3090  0.0  0.0   6432   736 pts/0    S+   20:36   0:00 grep --color=auto netdata
root@vagrant:/home/vagrant# netstat -an |grep 19999
tcp        0      0 0.0.0.0:19999           0.0.0.0:*               LISTEN
tcp        0      0 0.0.0.0:19999           0.0.0.0:*               LISTEN
tcp        0      0 10.0.2.15:19999         10.0.2.2:65073          ESTABLISHED
tcp        0      0 10.0.2.15:19999         10.0.2.2:65061          ESTABLISHED
tcp        0      0 10.0.2.15:19999         10.0.2.2:65058          ESTABLISHED

с метриками и комментариями ознакомился

4. В целом да
 dmesg |grep virt
[    0.002278] CPU MTRRs all blank - virtualized system.
[    0.070393] Booting paravirtualized kernel on KVM
[    3.211414] systemd[1]: Detected virtualization oracle.

5.
Судя по документации fs.nr_open обозначает максимальное количество файловых дескрипторов, которые может выделить процесс. Значение по умолчанию — 1024*1024 (1048576)
sysctl -n fs.nr_open
1048576

мягкий и жёсткий лимиты для пользователя (soft hard) не позволяют достичь максимального лимита для системы



6.
root@vagrant:/home/vagrant# unshare --pid --fork --mount-proc bash --norc -c 'sleep 3600' &
[1] 1511
root@vagrant:/home/vagrant# ps aux |grep sleep
root        1511  0.0  0.0   5480   528 pts/0    S    22:41   0:00 unshare --pid --fork --mount-proc bash --norc -c sleep 3600
root        1512  0.0  0.0   5476   588 pts/0    S    22:41   0:00 sleep 3600
root        1542  0.0  0.0   6432   724 pts/0    S+   22:42   0:00 grep --color=auto sleep
root@vagrant:/home/vagrant# nsenter --pid --target 1512 --mount
root@vagrant:/# ps a
    PID TTY      STAT   TIME COMMAND
      1 pts/0    S      0:00 sleep 3600
      2 tty1     S+     0:00 -bash
     14 pts/0    S      0:00 -bash
     25 pts/0    R+     0:00 ps a
root@vagrant:/#




7. это форк-бомба, функция создаёт два своих экземпляра бесконечно, пока не упрётся в лимит процессов системы.
отвечает за это судя по всему cgroup: fork rejected by pids controller in /user.slice/user-1000.slice/session-3.scope
изменить лимит можно ulimit -u 100 или /etc/security/limits.conf



=============================================================================================================================================================
=============================================================================================================================================================
==============================================================================================================================================================

1. chdir("/tmp")     = 0
2. openat(AT_FDCWD, "/usr/share/misc/magic.mgc", O_RDONLY) = 3
3. этот файл должен храниться в procfs, соответсвенно нужно его найти через файловый дескиптор и сделать echo "" > /proc/pid/fd/num_fd
4. нет, они освобождают свои ресурсы
5. на хостовой машине в первые секунды ничего не происходит, а на виртуальной:
863    vminfo              5   0 PID    COMM               FD ERR PATH
/var/run/utmp
647    dbus-daemon        -1   2 /usr/local/share/dbus-1/system-services
647    dbus-daemon        20   0 /usr/share/dbus-1/system-services
647    dbus-daemon        -1   2 /lib/dbus-1/system-services
647    dbus-daemon        20   0 /var/lib/snapd/dbus-1/system-services/
1      systemd            21   0 /proc/388/cgroup
388    systemd-udevd      14   0 /sys/fs/cgroup/unified/system.slice/systemd-udevd.service/cgroup.procs
388    systemd-udevd      14   0 /sys/fs/cgroup/unified/system.slice/systemd-udevd.service/cgroup.threads
655    irqbalance          6   0 /proc/interrupts
6. использует системный вызов uname() ,  man 2 uname|grep -- "/proc"
       Part of the utsname information is also accessible via /proc/sys/kernel/{ostype, hostname, osrelease, version, domainname}.
7. в случае ";" команды выполняются по очереди, не зависимо от завершения предыдущей, а в случае с "&&" только при успешном завершении предыдущей.
set -e будет прерывать последовательность команд при неудачном завершении любой из них кроме последней, поэтому смысла нет, так как конвеер команд так и так завершится при первой неудаче.
8. 
-e приведет к немедленному завершению сценария bash в случае ошибки
-o pipefail параметр устанавливает код выхода конвейера на код самой правой команды для выхода с ненулевым статусом или на ноль, если все команды конвейера завершаются успешно.
-у рассматривает неустановленные переменные как ошибку и немедленно завершает работу
-x печатает каждую команду перед ее выполнением

так как в баше нет встроенных механизмов защиты от ошибок, как например в других высокоуровневых языках, поэтому эти ключи делают выполнение сценария более безопасным и предсказуемым, а также помогают в отладке.
9.
 ps -eo stat=|sort|uniq -c|sort -nr
     92 S
     71 I<
     22 Ss
     13 I
     11 Ssl
      5 S+
      2 SN
      1 S<sl
      1 Ss+
      1 S<s
      1 Sl
      1 R+
      Получается самый популярный S - Процесс ожидает выполнение
Дополнительные буквы - это дополнительные  характеристики процесса, описанные в мане




==============================================================================================================================================================================
==============================================================================================================================================================================
==============================================================================================================================================================================


1. тип команды cd встроенный.
type cd
cd is a shell builtin
объясняется это тем что она работает в текущей сессии со своим окружением, если допустим использовать ssh cd , то это будет внешний вызов с другим окружением и смена каталога произойдёт на удалённом сервере.
можно создать свою функцию cd (), например cd () { echo "no change directory"; }, в таком случае cd не будет менять каталог.
либо можно использовать алиас alias cd='no change directory', в этих случаях она перестаёт быть встроенной и изменит всой функционал.

2. grep <some_string> <some_file> -с
3. pstree -p|head -1
systemd(1)-+-VBoxService(863)-+-{VBoxService}(864)
получается systemd родитель
4.ls / 2>/dev/pts/1
5. echo "test1" > 111;echo "test2" >> 111;echo "test3" >> 111
cat 111
test1
test2
test3
cat < 111 > 222
cat 222
test1
test2
test3
6. отправить из pty в tty получится, а чтобы посмотреть вывод нужно переключиться в контекст tty
7. bash 5>&1 - команда создаёт дескриптор с именем 5 и перенаправляет его в поток stdout
echo netology > /proc/$$/fd/5 команда выводит "netology" в текущей сессии, потому что  дескриптор с именем 5 перенаправлен в stdout
8. Да, whoami 5>&2 2>&1 1>&5 |grep root
9. Команда выведет переменные окружения текущего сеанса. налогичный вывод env или printenv
10. man proc
 /proc/<PID>/cmdline в этом файле хранится командная строка, в которой был запущен данный процесс
/proc/<PID>/exe это симлинк на исполняемый файл, который инициировал запуск процесса
11. cat /proc/cpuinfo|grep sse   4.2
12. это происходит потому что по умолчанию в момент подключения tty не существует, чтобы это изменить нужно добавить ключ -t 
13. cat 111.sh
#!/bin/bash
ping 8.8.8.8
bash 111.sh &
[1] 31476
PING 8.8.8.8 (8.8.8.8) 56(84) bytes of data.
64 bytes from 8.8.8.8: icmp_seq=1 ttl=117 time=29.3 ms
64 bytes from 8.8.8.8: icmp_seq=2 ttl=117 time=29.3 ms


other terminal
sudo su
reptyr -T 31476
64 bytes from 8.8.8.8: icmp_seq=113 ttl=117 time=29.4 ms
64 bytes from 8.8.8.8: icmp_seq=114 ttl=117 time=29.6 ms

14.
Команда tee считывает стандартный ввод и записывает его одновременно в стандартный вывод и в казанный файл
в примере с эхо перенаправление вывода выполняется оболочкой, а не командой echo, а у неё нет разрешения на запись. то есть права рута у echo есть, а у перенаправления нет
в примере с пайпом  и tee и echo будут запущены от рута поэтому всё получится
 
 
 
 
================================================================================================================================
================================================================================================================================
================================================================================================================================
================================================================================================================================




1. +
2. +
3. +
4. +
5. hdd 64 gb, 1024 ram, 2 core proc,1 share directory
6. Добавить в конфиг файл:

config.vm.provider "virtualbox" do |v|
  v.memory = 2048
  v.cpus = 4
end
7.+
8. HISTFILESIZE, строка 974 (man bash|grep -A5 -B5 -n HISTFILESIZE)
ignoreboth - игнорирование сохранения команды в историю если она уже есть в истории или начинается с пробела
9. строка 294 (man bash |grep -n { |head -10 )
фигурные скобки применяют в функциях, в условиях, в циклах, везде где необходим список элементов.
10. touch {000001..100000}, не получится, максимальное число элементов 139672
11. проверяет существование директории
12.
В задании указано  bash is /usr/local/bin/bash, но в 20 версии убунту его нет:
cat /usr/local/bin/bash
cat: /usr/local/bin/bash: No such file or directory
поэтому в выводе будет дефолт /usr/bin/bash

команды:
mkdir /tmp/new_path_directory
cp  /bin/bash /tmp/new_path_directory
PATH=/tmp/new_path_directory/:$PATH
root@vagrant:/home/vagrant# type -a bash
bash is /tmp/new_path_directory/bash
bash is /usr/bin/bash
bash is /bin/bash

13. at используется для запуска команды в определнное время
batch - используется когда load average загрузки системы будет ниже 1.5
14. vagrant suspend



=================================================================================================================================================








1. aefead2207ef7e2aa5dc81a34aedf0cad4c32545  Update CHANGELOG.md
2. (tag: refs/tags/v0.12.23) v0.12.23
3.56cd7859e05c36c06b56d013b55a252d0bb7e158, 9ea88f22fc6269854151c571162c5bcf958bee2b
4. commit 33ff1c03bb960b332be3af2e333462dde88b279e
    v0.12.24
commit b14b74c4939dcab573326f4e3ee2a62e23e12f89
    [Website] vmc provider links
commit 3f235065b9347a758efadc92295b540ee0a5e26e
    Update CHANGELOG.md
commit 6ae64e247b332925b872447e9ce869657281c2bf
    registry: Fix panic when server is unreachable
commit 5c619ca1baf2e21a155fcdb4c264cc9e24a2a353
    website: Remove links to the getting started guide's old location
commit 06275647e2b53d97d4f0a19a0fec11f6d69820b5
    Update CHANGELOG.md
commit d5f9411f5108260320064349b757f55c09bc4b80
    command: Fix bug when using terraform login on Windows
commit 4b6d06cc5dcb78af637bbb19c198faff37a066ed
    Update CHANGELOG.md
commit dd01a35078f040ca984cdd349f18d0b67e486c35
    Update CHANGELOG.md
commit 225466bc3e5f35baa5d07197bbc079345b77525e
    Cleanup after v0.12.23 release
5. main: Consult local directories as potential mirrors of providers,8c928e835
6.78b12205587fe839f10d946ea3fdc06719decb05,52dbf94834cb970b510f2fba853a5b49ad9b1a46,41ab0aef7a0fe030e84018973a64135b11abcd70,66ebff90cdfaa6938f26f908c7ebad8d547fea17,8364383c359a6b738a436d1b7745ccdce178df47

7. Author: Martin Atkins <mart@degeneration.co.uk> 


(Пояснение:
1. git show aefea |grep aefea -A4
2. git show 85024d3 |grep Date: -A2|tail -1
3. git show b8d720 видим что это мердж, в котором указано начало хешей обоих родителей, git show 56cd7859e 9ea88f22f
4. git log v0.12.23..v0.12.24 --oneline
5. git log -S "func providerSource"  |head -1, первый коммит покажет когда она создана
6. ищем функцию в логе git log -S "func globalPluginDir", смотрим найденный коммит git show 8364383c359a6b738a436d1b7745ccdce178df47, видим что функция определена в plugins.go, далее git log -L :globalPluginDir:plugins.go
7 .git log -S "func synchronizedWriters(" |grep commit -A2 выведет два коммита и даты, первое упоминание функции в 2017 году Martin Atkins <mart@degeneration.co.uk> , также это видно если сделать git show обоих коммитов
)



===========================================================================================================







Будут проигорированы:
-  локальная директория .terraform
- файлы и директории содержащие в имени .tfstate.
- файлы и директории содержащие в конце имени .tfstate .tfvars _override.tf _override.tf.json
- файлы с именем crash.log override.tf override.tf.json .terraformrc terraform.rc
