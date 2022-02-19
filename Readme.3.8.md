1. 

>telnet route-views.routeviews.org</br>
>Trying 128.223.51.103...</br>
>Connected to route-views.routeviews.org.</br>
></br>
>route-views>show ip route 81.163.247.71</br>
>Routing entry for 81.163.240.0/21</br>
>  Known via "bgp 6447", distance 20, metric 0</br>
>  Tag 6939, type external</br>
>  Last update from 64.71.137.241 1w4d ago</br>
>  Routing Descriptor Blocks:</br>
>  * 64.71.137.241, from 64.71.137.241, 1w4d ago</br>
>      Route metric is 0, traffic share count is 1</br>
>      AS Hops 2</br>
>      Route tag 6939</br>
>      MPLS label: none</br>

>route-views>show bgp 81.163.247.71</br>
>BGP routing table entry for 81.163.240.0/21, version 298691341</br>
>Paths: (4 available, best #4, table default)</br>
>  Not advertised to any peer</br>
>  Refresh Epoch 1</br>
>  1351 6939 51973</br>
>    132.198.255.253 from 132.198.255.253 (132.198.255.253)</br>
>      Origin IGP, localpref 100, valid, external</br>
>      path 7FE0FD4A4B28 RPKI State not found</br>
>      rx pathid: 0, tx pathid: 0</br>
>  Refresh Epoch 1</br>
>  20130 6939 51973</br>
>    140.192.8.16 from 140.192.8.16 (140.192.8.16)</br>
>      Origin IGP, localpref 100, valid, external</br>
>      path 7FE0B5744930 RPKI State not found</br>
>      rx pathid: 0, tx pathid: 0</br>
>  Refresh Epoch 1</br>
>  3303 6939 51973</br>
>    217.192.89.50 from 217.192.89.50 (138.187.128.158)</br>
>      Origin IGP, localpref 100, valid, external</br>
>      Community: 3303:1006 3303:1021 3303:1030 3303:3067 6939:7156 6939:8428 6939:9002</br>
>      path 7FE00435CA78 RPKI State not found</br>
>      rx pathid: 0, tx pathid: 0</br>
>  Refresh Epoch 1</br>
>  6939 51973</br>
>    64.71.137.241 from 64.71.137.241 (216.218.252.164)</br>
>      Origin IGP, localpref 100, valid, external, best</br>
>      path 7FE0DEEF42F0 RPKI State not found</br>
>      rx pathid: 0, tx pathid: 0x0</br>
>route-views>Connection closed by foreign host.</br>


2.

>root@vagrant:/home/vagrant# modprobe -v dummy numdummies=1</br>
>insmod /lib/modules/5.4.0-91-generic/kernel/drivers/net/dummy.ko numdummies=0 numdummies=1</br>
>
>root@vagrant:/home/vagrant# ip a</br>
>1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000</br>
>    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00</br>
>    inet 127.0.0.1/8 scope host lo</br>
>       valid_lft forever preferred_lft forever</br>
>    inet6 ::1/128 scope host</br>
>       valid_lft forever preferred_lft forever</br>
>2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP group default qlen 1000</br>
>    link/ether 08:00:27:b1:28:5d brd ff:ff:ff:ff:ff:ff</br>
>    inet 10.0.2.15/24 brd 10.0.2.255 scope global dynamic eth0</br>
>       valid_lft 54471sec preferred_lft 54471sec</br>
>    inet6 fe80::a00:27ff:feb1:285d/64 scope link</br>
>       valid_lft forever preferred_lft forever</br>
>3: dummy0: <BROADCAST,NOARP> mtu 1500 qdisc noop state DOWN group default qlen 1000</br>
>    link/ether 9e:da:aa:6e:1e:e6 brd ff:ff:ff:ff:ff:ff</br>


>root@vagrant:/home/vagrant# netstat -rn</br>
>Kernel IP routing table</br>
>Destination     Gateway         Genmask         Flags   MSS Window  irtt Iface</br>
>0.0.0.0         10.0.2.2        0.0.0.0         UG        0 0          0 eth0</br>
>10.0.2.0        0.0.0.0         255.255.255.0   U         0 0          0 eth0</br>
>10.0.2.2        0.0.0.0         255.255.255.255 UH        0 0          0 eth0</br>

>root@vagrant:/home/vagrant# route add -net 192.168.0.0/16 gw 10.0.2.1</br>
>root@vagrant:/home/vagrant# netstat -rn</br>
>Kernel IP routing table</br>
>Destination     Gateway         Genmask         Flags   MSS Window  irtt Iface</br>
>0.0.0.0         10.0.2.2        0.0.0.0         UG        0 0          0 eth0</br>
>10.0.2.0        0.0.0.0         255.255.255.0   U         0 0          0 eth0</br>
>10.0.2.2        0.0.0.0         255.255.255.255 UH        0 0          0 eth0</br>
>192.168.0.0     10.0.2.1        255.255.0.0     UG        0 0          0 eth0</br>

>root@vagrant:/home/vagrant# ip route add 172.16.10.0/24 via 10.0.2.1</br>
>root@vagrant:/home/vagrant# netstat -rn</br>
>Kernel IP routing table</br>
>Destination     Gateway         Genmask         Flags   MSS Window  irtt Iface</br>
>0.0.0.0         10.0.2.2        0.0.0.0         UG        0 0          0 eth0</br>
>10.0.2.0        0.0.0.0         255.255.255.0   U         0 0          0 eth0</br>
>10.0.2.2        0.0.0.0         255.255.255.255 UH        0 0          0 eth0</br>
>172.16.10.0     10.0.2.1        255.255.255.0   UG        0 0          0 eth0</br>
>192.168.0.0     10.0.2.1        255.255.0.0     UG        0 0          0 eth0</br>



3.

>root@vagrant:/home/vagrant# netstat -at</br>
>Active Internet connections (servers and established)</br>
>Proto Recv-Q Send-Q Local Address           Foreign Address         State</br>
>tcp        0      0 localhost:domain        0.0.0.0:*               LISTEN</br>
>tcp        0      0 0.0.0.0:ssh             0.0.0.0:*               LISTEN</br>
>tcp        0      0 vagrant:ssh             _gateway:58210          ESTABLISHED</br>
>tcp6       0      0 [::]:9100               [::]:*                  LISTEN</br>
>tcp6       0      0 [::]:ssh                [::]:*                  LISTEN</br>

>root@vagrant:/home/vagrant# ss -lt</br>
>State                       Recv-Q                      Send-Q                                           Local Address:Port                                              Peer Address:Port                      Process</br>
>LISTEN                      0                           4096                                             127.0.0.53%lo:domain                                                 0.0.0.0:*</br>
>LISTEN                      0                           128                                                    0.0.0.0:ssh                                                    0.0.0.0:*</br>
>LISTEN                      0                           4096                                                         *:9100                                                         *:*</br>
>LISTEN                      0                           128                                                       [::]:ssh                                                       [::]:*</br>


>root@vagrant:/home/vagrant# netstat -l</br>
>Active Internet connections (only servers)</br>
>Proto Recv-Q Send-Q Local Address           Foreign Address         State</br>
>tcp        0      0 localhost:domain        0.0.0.0:*               LISTEN</br>
>tcp        0      0 0.0.0.0:ssh             0.0.0.0:*               LISTEN</br>
>tcp6       0      0 [::]:9100               [::]:*                  LISTEN</br>
>tcp6       0      0 [::]:ssh                [::]:*                  LISTEN</br>
>udp        0      0 localhost:domain        0.0.0.0:*</br>
>udp        0      0 vagrant:bootpc          0.0.0.0:*</br>
>raw6       0      0 [::]:ipv6-icmp          [::]:*                  7</br>

>systemd-resolved слушает 53 порт udp и tcp</br>
>ssh server слушает 22 порт на всех доступных адресах ipv4 и ipv6 tcp</br>
>node_exporter слушает порт 9100 tcp</br>


4.

>ss -u -a</br>
>State                       Recv-Q                      Send-Q                                            Local Address:Port                                             Peer Address:Port                      Process</br>
>UNCONN                      0                           0                                                 127.0.0.53%lo:domain                                                0.0.0.0:*</br>
>UNCONN                      0                           0                                                10.0.2.15%eth0:bootpc                                                0.0.0.0:*</br>

>systemd-resolved слушает 53 udp порт на локалхосте для резолва dns</br>
>systemd-network слушает 68 udp порт на интерфейсе для получения dhcp адреса</br>

5. 

> https://disk.yandex.ru/i/qzJlAbgZ8Mr17g



