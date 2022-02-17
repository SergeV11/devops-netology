1.
>Linux:</br></br>
>root@vagrant:/home/vagrant# ip l</br>
>1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN mode DEFAULT group default qlen 1000</br>
>    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00</br>
>2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP mode DEFAULT group default qlen 1000</br>
>    link/ether 08:00:27:b1:28:5d brd ff:ff:ff:ff:ff:ff</br>
></br>
>root@vagrant:/home/vagrant# ifconfig</br>
>eth0: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500</br>
>        inet 10.0.2.15  netmask 255.255.255.0  broadcast 10.0.2.255</br>
>        inet6 fe80::a00:27ff:feb1:285d  prefixlen 64  scopeid 0x20<link></br>
>        ether 08:00:27:b1:28:5d  txqueuelen 1000  (Ethernet)</br>
>        RX packets 31323  bytes 41764435 (41.7 MB)</br>
>        RX errors 0  dropped 0  overruns 0  frame 0</br>
>        TX packets 12228  bytes 1310946 (1.3 MB)</br>
>        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0</br>
></br>
>lo: flags=73<UP,LOOPBACK,RUNNING>  mtu 65536</br>
>        inet 127.0.0.1  netmask 255.0.0.0</br>
>        inet6 ::1  prefixlen 128  scopeid 0x10<host></br>
>        loop  txqueuelen 1000  (Local Loopback)</br>
>        RX packets 324  bytes 25601 (25.6 KB)</br>
>        RX errors 0  dropped 0  overruns 0  frame 0</br>
>        TX packets 324  bytes 25601 (25.6 KB)</br>
>        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0</br></br>
>Windows:</br>
>ipconfig /all</br>

2.
>используется протокол lldp</br>
>sudo apt-get install lldpd snmp</br>
>lldpcli show neighbors</br>

3.
>используется технология vlan</br>

>sudo apt-get install vlan</br>
>sudo modprobe 8021q</br>
></br>
>cat /etc/network/interfaces</br>
></br>
>auto lo</br>
>iface lo inet loopback</br>
></br>
>auto enp1s0</br>
>iface enp1s0 inet dhcp</br>
></br>
>auto enp1s0.10</br>
>iface enp1s0.10 inet dhcp</br>
>	vlan-raw-device enp1s0</br>
></br>
>sudo ifup enp1s0.10</br>


или динамически</br>

>sudo vconfig add enp1s0 10</br>

4.
Типы бондинга в linux:</br>
>Mode-0(balance-rr)</br>
>Mode-1(active-backup)</br>
>Mode-2(balance-xor) </br>
>Mode-3(broadcast)</br>
>Mode-4(802.3ad) </br>
>Mode-5(balance-tlb) </br>
>Mode-6(balance-alb) </br>
></br>
опции балансировки нагрузки:</br></br>
> balance-rr - политика round robin, пакеты отправляются по очереди на каждый интерфейс</br>
> balance-xor  - передача распределяется между сетевыми картами используя формулу: [( «MAC адрес источника» XOR «MAC адрес назначения») по модулю «число интерфейсов»]</br>
> balance-tlb - адаптивная балансировка</br>
> balance-alb - адаптивная балансировка и исходящего и входящего трафика</br>

>cat /etc/network/interfaces</br>
>auto bond0</br>
>iface bond0 inet dhcp</br>
>   bond-slaves none</br>
>   bond-mode active-backup</br>
>   bond-miimon 100</br>
></br>
>auto eth0</br>
>   iface eth0 inet manual</br>
>   bond-master bond0</br>
>   bond-primary eth0 eth1</br>
></br>
>auto eth1</br>
>iface eth1 inet manual</br>
>   bond-master bond0</br>
>   bond-primary eth0 eth1</br>

5.

> ipcalc -b 192.168.1.0/29|grep Hosts/Net</br>
>Hosts/Net: 6                     Class C, Private Internet</br>
></br>
>ipcalc -b  192.168.1.0/24 29 |grep "Subnets:"</br>
>Subnets:   32</br>
></br>
>ipcalc -b  10.10.10.0/24 29 |grep "Network:"|tail -3</br>
>Network:   10.10.10.232/29</br>
>Network:   10.10.10.240/29</br>
>Network:   10.10.10.248/29</br>

6.
>100.64.0.0/26</br>
>в качестве альтернативы можно было бы использовать протокол EoIP, ему нужна как раз одинаковая адресация на обоих концах</br>

7.
>windows:</br>
>arp -a</br>
>netsh interface ip delete arpcache</br>
>arp -d 192.168.100.25</br>
>Linux:</br>
>arp -a</br>
>arp -d 192.168.100.25</br>
>ip -s -s neigh flush all</br>
