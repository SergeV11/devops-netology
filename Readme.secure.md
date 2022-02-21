1.
https://disk.yandex.ru/i/6XB8byGQnjNJDA

2.
https://disk.yandex.ru/i/12gBT8WmAii1hA

3.

>root@vagrant:/home/vagrant# curl 127.0.0.1</br>
> Test SSL</br>
></br>
>root@vagrant:/home/vagrant# curl https://127.0.0.1</br>
>curl: (60) SSL certificate problem: self signed certificate</br>
>More details here: https://curl.haxx.se/docs/sslcerts.html</br>
></br>
>curl failed to verify the legitimacy of the server and therefore could not</br>
>establish a secure connection to it. To learn more about this situation and</br>
>how to fix it, please visit the web page mentioned above.</br>
></br>
></br>
>root@vagrant:/home/vagrant# curl -k https://127.0.0.1</br>
>Test SSL</br>

4.

> ./testssl.sh -U --sneaky https://bash.im</br>
>уязвимостей нет</br>

5.

>root@vagrant:/home/vagrant/testssl.sh# apt install openssh-server</br>
></br>
>root@vagrant:/home/vagrant/testssl.sh# ssh-keygen -t rsa</br>
>Generating public/private rsa key pair.</br>
>Enter file in which to save the key (/root/.ssh/id_rsa):</br>
>Enter passphrase (empty for no passphrase):</br>
>Enter same passphrase again:</br>
>Your identification has been saved in /root/.ssh/id_rsa</br>
>Your public key has been saved in /root/.ssh/id_rsa.pub</br>
>The key fingerprint is:</br>
>SHA256:FQLBQcubsSwfKlnG8TZ1gkQfzvtJD6VKgkqTSNu7aEw root@vagrant</br>
>The key's randomart image is:</br>
>+---[RSA 3072]----+</br>
>|     +B+o .      |</br>
>|     o.* o .     |</br>
>| .  . = * o .    |</br>
>|..oo = * = o     |</br>
>|..+.* @ S +      |</br>
>| E *.= = + +     |</br>
>|o +.. . . o .    |</br>
>| o...            |</br>
>|.. .             |</br>
>+----[SHA256]-----+</br>
></br>
></br>
>root@vagrant:/home/vagrant/testssl.sh# ssh-copy-id -i \~/.ssh/id_rsa.pub root@104.168.182.130</br>
>/usr/bin/ssh-copy-id: INFO: Source of key(s) to be installed: "/root/.ssh/id_rsa.pub"</br>
>The authenticity of host '104.168.182.130 (104.168.182.130)' can't be established.</br>
>ECDSA key fingerprint is SHA256:TNTIM9YPVWCWHZGvOzGTKaqXXJbKsLsyzXazlO5oQv4.</br>
>Are you sure you want to continue connecting (yes/no/[fingerprint])? yes</br>
>/usr/bin/ssh-copy-id: INFO: attempting to log in with the new key(s), to filter out any that are already installed</br>
>/usr/bin/ssh-copy-id: INFO: 1 key(s) remain to be installed -- if you are prompted now it is to install the new keys</br>
></br>
>root@104.168.182.130's password:</br>
></br>
>Number of key(s) added: 1</br>
></br>
>Now try logging into the machine, with:   "ssh 'root@104.168.182.130'"</br>
>and check to make sure that only the key(s) you wanted were added.</br>
></br>
>root@vagrant:/home/vagrant/testssl.sh# ssh  root@104.168.182.130</br>
></br>
>New release '18.04.6 LTS' available.</br>
>Run 'do-release-upgrade' to upgrade to it.</br>
></br>
>Last login: Thu Jan 20 20:57:38 2022 from 178.236.131.116</br>
>root@V1-NODE:~#</br>

6.

>mv id_rsa id_rsa2</br>
>mv id_rsa.pub id_rsa2.pub</br>
></br>
>root@vagrant:\~/.ssh# </br>
>echo "</br>
>   IdentityFile \~/.ssh/id_rsa2</br>
> Host V1</br>
>    HostName 104.168.182.130</br>
>    User root " >> /etc/ssh/ssh_config</br>
></br>
>root@vagrant:\~/.ssh# service ssh restart</br>
></br>
>root@vagrant:\~/.ssh# ssh V1</br>
>Welcome to Ubuntu 16.04.7 LTS (GNU/Linux 4.4.0-210-generic x86_64)</br>
></br>
>New release '18.04.6 LTS' available.</br>
>Run 'do-release-upgrade' to upgrade to it.</br>
></br>
>Last login: Mon Feb 21 18:13:08 2022 from 81.163.247.71</br>

7.

>sudo tcpdump -c 100 -w dump.pcap</br>
