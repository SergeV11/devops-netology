# Курсовая работа по итогам модуля "DevOps и системное администрирование"


##  1

```
Vagrant.configure("2") do |config|
 	config.vm.box = "bento/ubuntu-20.04"
 end
```
  https://disk.yandex.ru/i/LW90a97KvvyH7g
  
  ## 2
  ```
  root@vagrant:/home/vagrant# ufw status
Status: inactive
root@vagrant:/home/vagrant# ufw enable
Command may disrupt existing ssh connections. Proceed with operation (y|n)? y
Firewall is active and enabled on system startup
root@vagrant:/home/vagrant# ufw status
Status: active
root@vagrant:/home/vagrant# ufw allow 22/tcp
Rule added
Rule added (v6)
root@vagrant:/home/vagrant# ufw allow 443/tcp
Rule added
Rule added (v6)
root@vagrant:/home/vagrant# ufw status verbose
Status: active
Logging: on (low)
Default: deny (incoming), allow (outgoing), disabled (routed)
New profiles: skip

To                         Action      From
--                         ------      ----
22/tcp                     ALLOW IN    Anywhere
443/tcp                    ALLOW IN    Anywhere
22/tcp (v6)                ALLOW IN    Anywhere (v6)
443/tcp (v6)               ALLOW IN    Anywhere (v6)
```

https://disk.yandex.ru/i/vR0VeV2eRxGYWg

## 3

```
root@vagrant:/home/vagrant# curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
curl: (22) The requested URL returned error: 405
gpg: no valid OpenPGP data found.

root@vagrant:/home/vagrant# apt install tor

root@vagrant:/home/vagrant# torsocks curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
OK

root@vagrant:/home/vagrant# torsocks apt update

root@vagrant:/home/vagrant# apt install vault
Reading package lists... Done
Building dependency tree
Reading state information... Done
The following NEW packages will be installed:
  vault
0 upgraded, 1 newly installed, 0 to remove and 88 not upgraded.
Need to get 0 B/70.4 MB of archives.
After this operation, 191 MB of additional disk space will be used.
(Reading database ... 40726 files and directories currently installed.)
Preparing to unpack .../vault_1.10.0_amd64.deb ...
Unpacking vault (1.10.0) ...
Setting up vault (1.10.0) ...
Generating Vault TLS key and self-signed certificate...
Generating a RSA private key
...............++++
......................................................................................................................++++
writing new private key to 'tls.key'
-----
Vault TLS key and self-signed certificate have been generated in '/opt/vault/tls'.
root@vagrant:/home/vagrant#
```
https://disk.yandex.ru/i/_Zhjh177-AZ31g

## 4

```
vault server -dev -dev-root-token-id root &
vault secrets enable pki
vault secrets tune -max-lease-ttl=87600h pki
vault write -field=certificate pki/root/generate/internal  common_name="test.local"  ttl=87600h > CA_cert.crt
vault write pki/config/urls  issuing_certificates="$VAULT_ADDR/v1/pki/ca"  crl_distribution_points="$VAULT_ADDR/v1/pki/crl"
vault secrets enable -path=pki_int pki
vault secrets tune -max-lease-ttl=43800h pki_int
vault write -format=json pki/root/sign-intermediate csr=@pki_intermediate.csr | jq -r '.data.certificate' > intermediate.cert.pem
vault write -format=json pki_int/intermediate/generate/internal  common_name="test.local Intermediate Authority"  | jq -r '.data.csr' > pki_intermediate.csr
apt install jq
vault write -format=json pki_int/intermediate/generate/internal  common_name="test.local Intermediate Authority"  | jq -r '.data.csr' > pki_intermediate.csr
vault write pki_int/issue/example-dot-com common_name="netology.test.local" ttl="24h"
```

https://disk.yandex.ru/i/f1E5wbfVy9pNwA

https://disk.yandex.ru/i/ReBPk55Uf6_9jA

## 5

https://disk.yandex.ru/i/bJKR1MtT7Ktuyw

## 6

```
apt install nginx
```

https://disk.yandex.ru/i/JcvCvuGFmA0yNw

## 7

```
server {
    listen              443 ssl;
    server_name         netology.test.local;
    ssl_certificate     /home/vagrant/fullcert.crt;
    ssl_certificate_key /home/vagrant/netology.test.local.key;
    ssl_protocols       TLSv1 TLSv1.1 TLSv1.2;
    ssl_ciphers         HIGH:!aNULL:!MD5;
}



cat netology.test.local.crt intermediate.cert.pem > fullcert.crt
```

https://disk.yandex.ru/i/9j4r1U8iQ2VENA

## 8

```
C:\windows\system32\drivers\etc\hosts -> 127.0.0.1 netology.test.local
```

https://disk.yandex.ru/i/d20ayyLdR6O6ww

https://disk.yandex.ru/i/RiKf7P3yhVKzHQ

## 9

```
#!/bin/bash
dir=/home/vagrant/cert/`date +%Y%m%d`
mkdir -p  $dir
cd $dir
export VAULT_ADDR=http://127.0.0.1:8200
a=`ps aux|grep vault|grep -v grep`
if [ -n "$a" ]; then killall -9 vault;sleep 5;fi
vault server -dev -dev-root-token-id root &
sleep 10
vault secrets enable pki
vault secrets tune -max-lease-ttl=87600h pki
vault write -field=certificate pki/root/generate/internal  common_name="test.local"  ttl=87600h > CA_cert.crt
vault write pki/config/urls  issuing_certificates="$VAULT_ADDR/v1/pki/ca"  crl_distribution_points="$VAULT_ADDR/v1/pki/crl"
vault secrets enable -path=pki_int pki
vault secrets tune -max-lease-ttl=43800h pki_int
vault write -format=json pki_int/intermediate/generate/internal  common_name="test.local Intermediate Authority"  | jq -r '.data.csr' > pki_intermediate.csr
vault write -format=json pki/root/sign-intermediate csr=@pki_intermediate.csr | jq -r '.data.certificate' > intermediate.cert.pem
vault write pki_int/intermediate/set-signed certificate=@intermediate.cert.pem
vault write pki_int/roles/example-dot-com  allowed_domains="test.local"  allow_subdomains=true  max_ttl="720h"
vault write pki_int/issue/example-dot-com common_name="netology.test.local" ttl="24h" > temp.cert
cat temp.cert |awk 'split_after==1{n++;split_after=0} /-----END CERTIFICATE-----/ {split_after=1} {print > "cert" n ".pem"}'
mv cert1.pem netology.test.local.crt
mv cert3.pem netology.test.local.key
cat netology.test.local.crt |  sed -r '1 s/^.{20}//' > tmp; mv tmp netology.test.local.crt
cat netology.test.local.key| sed -r '1 s/^.{20}//' > tmp;mv tmp netology.test.local.key
cat netology.test.local.crt intermediate.cert.pem > fullcert.crt
cp netology.test.local.key /home/vagrant
cp fullcert.crt  /home/vagrant

service nginx restart

```

https://disk.yandex.ru/i/qUL6hQq4hxe1Zw

https://disk.yandex.ru/i/0s8QVRGo2Ujvcw

## 10

```
echo "0 10     6 * *   root    /bin/bash /home/vagrant/cron.sh" >> /etc/crontab
```
https://disk.yandex.ru/i/IR9GefdCpTQo2A

https://disk.yandex.ru/i/WYAaJAQZNp1BPQ
