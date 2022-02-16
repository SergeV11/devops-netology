1.  HTTP/1.1 301 Moved Permanently , значает что ресурс /questions перемещён на постоянной основе</br>
2.  200 OK, дольше всего выполняется запрос получения документа с корня сайта</br>
[скриншот] https://disk.yandex.ru/i/zljTOk58PQIBHg </br>
3.</br>
> curl ipinfo.io/ip</br>
> 81.163.247.71</br>
4.
> whois 81.163.247.71|grep org-name</br>
> org-name:       Koltushsky Internet Ltd</br>
> whois -h whois.radb.net 81.163.247.71 | grep '^origin'</br>
> origin:         AS51973

5.
> traceroute 8.8.8.8 </br>
> traceroute to 8.8.8.8 (8.8.8.8), 30 hops max, 60 byte packets</br>
>  1  _gateway (192.168.19.254)  0.287 ms  0.214 ms  0.198 ms</br>
> 2  l3.80-248-154-225.lsi.ru (80.248.154.225)  3.509 ms  3.472 ms  3.064 ms</br>
> 3  bbn.212-48-204-200.nwtelecom.ru (212.48.204.200)  3.200 ms * bbn.212-48-204-190.nwtelecom.ru (212.48.204.190)  2.842 ms</br>
> 4  188.254.2.6 (188.254.2.6)  7.881 ms  9.824 ms  7.964 ms</br>
> 5  87.226.194.47 (87.226.194.47)  4.605 ms  3.114 ms  4.188 ms</br>
> 6  74.125.244.132 (74.125.244.132)  5.258 ms  5.729 ms  3.243 ms</br>
> 7  72.14.232.85 (72.14.232.85)  5.076 ms  7.772 ms 216.239.48.163 (216.239.48.163)  9.981 ms</br>
> 8  108.170.233.161 (108.170.233.161)  8.679 ms 172.253.70.47 (172.253.70.47)  12.201 ms 142.251.61.221 (142.251.61.221)  10.926 ms</br>
> 9  * 216.239.58.69 (216.239.58.69)  10.883 ms 142.250.209.171 (142.250.209.171)  10.817 ms</br>
> 10  * * *</br>
> 11  * * *</br>
> 12  * * *</br>
> 13  * * *</br>
> 14  * * *</br>
> 15  * * *</br>
> 16  * * *</br>
> 17  * * *</br>
> 18  dns.google (8.8.8.8)  9.692 ms *  10.002 ms</br>


AS list:</br>
> traceroute -A 8.8.8.8</br>
traceroute to 8.8.8.8 (8.8.8.8), 30 hops max, 60 byte packets</br>
 1  _gateway (192.168.19.254) [*]  0.827 ms  0.762 ms  0.720 ms</br>
 2  l3.80-248-154-225.lsi.ru (80.248.154.225) [AS12380]  3.066 ms  3.445 ms  2.995 ms</br>
 3  bbn.212-48-204-190.nwtelecom.ru (212.48.204.190) [AS12389]  3.407 ms  3.460 ms  3.402 ms</br>
 4  188.254.2.4 (188.254.2.4) [AS12389]  8.734 ms  8.690 ms 188.254.2.6 (188.254.2.6) [AS12389]  21.442 ms</br>
 5  87.226.194.47 (87.226.194.47) [AS12389]  3.097 ms  5.613 ms  3.591 ms</br>
 6  74.125.244.180 (74.125.244.180) [AS15169]  5.775 ms  8.004 ms  7.941 ms</br>
 7  72.14.232.85 (72.14.232.85) [AS15169]  5.558 ms  8.705 ms 142.251.61.219 (142.251.61.219) [AS15169]  8.077 ms</br>
 8  142.251.61.221 (142.251.61.221) [AS15169]  8.157 ms 172.253.51.185 (172.253.51.185) [AS15169]  14.110 ms 142.251.51.187 (142.251.51.187) [AS15169]  9.877 ms</br>
 9  * 172.253.79.115 (172.253.79.115) [AS15169]  9.225 ms 216.239.56.113 (216.239.56.113) [AS15169]  11.039 ms</br>
10  * * *</br>
11  * * *</br>
12  * * *</br>
13  * * *</br>
14  * * *</br>
15  * * *</br>
16  * * *</br>
17  * * *</br>
18  * * *</br>
> 19  dns.google (8.8.8.8) [AS15169]  18.374 ms  16.108 ms  13.841 ms</br>



6.
> mtr --report -z 8.8.8.8</br>
>Start: 2022-02-16T10:15:59+0000</br>
>HOST: my_vm                       Loss%   Snt   Last   Avg  Best  Wrst StDev</br>
>  1. AS???    _gateway             0.0%    10    0.3   0.2   0.2   0.3   0.1</br>
>  2. AS???    ???                 100.0    10    0.0   0.0   0.0   0.0   0.0</br>
>  3. AS200081 201492xe0-1-1-r1.si  0.0%    10    0.5   0.4   0.3   0.5   0.1</br>
>  4. AS???    dtel-ix-2.google.co  0.0%    10   28.6  28.9  28.6  30.2   0.5</br>
>  5. AS15169  108.170.248.155      0.0%    10   29.0  29.0  28.7  30.1   0.4</br>
>  6. AS15169  72.14.239.111        0.0%    10   31.4  31.3  29.1  46.5   5.4</br>
>  7. AS15169  142.251.224.76       0.0%    10   35.2  33.9  29.6  51.3   7.0</br>
>  8. AS15169  74.125.242.241       0.0%    10   29.7  29.6  29.4  29.7   0.1</br>
>  9. AS15169  142.251.65.219       0.0%    10   29.9  29.6  29.4  29.9   0.1</br>
> 10. AS15169  dns.google           0.0%    10   29.6  29.6  29.4  29.8   0.1</br>
> на 7 участке самая большая задержка</br>

7.

> dig ns dns.google |grep ANSWER -A5</br>
>;; flags: qr rd ra; QUERY: 1, ANSWER: 4, AUTHORITY: 0, ADDITIONAL: 1</br>

>;; OPT PSEUDOSECTION:</br>
>; EDNS: version: 0, flags:; udp: 65494</br>
>;; QUESTION SECTION:</br>
>;dns.google.                    IN      NS</br>
>--</br>
>;; ANSWER SECTION:
>dns.google.             7020    IN      NS      ns2.zdns.google.</br>
>dns.google.             7020    IN      NS      ns1.zdns.google.</br>
>dns.google.             7020    IN      NS      ns4.zdns.google.</br>
>dns.google.             7020    IN      NS      ns3.zdns.google.</br>

> dig a dns.google |grep ANSWER -A5</br>
>;; flags: qr rd ra; QUERY: 1, ANSWER: 2, AUTHORITY: 0, ADDITIONAL: 1</br>
>
>;; OPT PSEUDOSECTION:</br>
>; EDNS: version: 0, flags:; udp: 65494</br>
>;; QUESTION SECTION:</br>
>;dns.google.                    IN      A</br>
>--</br>
>;; ANSWER SECTION:</br>
>dns.google.             404     IN      A       8.8.4.4</br>
>dns.google.             404     IN      A       8.8.8.8</br>


8.
> dig -x 8.8.8.8|grep ANSWER -A2</br>
> ;; flags: qr rd ra; QUERY: 1, ANSWER: 1, AUTHORITY: 0, ADDITIONAL: 1</br>
>
> ;; OPT PSEUDOSECTION:</br>
> --</br>
> ;; ANSWER SECTION:</br>
> 8.8.8.8.in-addr.arpa.   3137    IN      PTR     dns.google.</br>
>
> dig -x 8.8.4.4|grep ANSWER -A2</br>
> ;; flags: qr rd ra; QUERY: 1, ANSWER: 1, AUTHORITY: 0, ADDITIONAL: 1</br>
>
> --
> ;; ANSWER SECTION:</br>
> 4.4.8.8.in-addr.arpa.   6612    IN      PTR     dns.google.</br>
>
> dig -x 8.8.8.8 +short</br>
> dns.google.</br>

> dig -x 8.8.4.4 +short</br>
> dns.google.</br>



