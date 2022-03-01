

>cat /etc/apache2/sites-enabled/testdomain.conf</br>
> <VirtualHost *:443></br>
>   ServerName testdomain.local</br>
>   DocumentRoot /var/www/html</br>
></br>
>   SSLEngine on</br>
>   SSLCertificateFile /etc/ssl/certs/apache-selfsigned.crt</br>
>   SSLCertificateKeyFile /etc/ssl/private/apache-selfsigned.key</br>
> </VirtualHost></br>




>sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/apache-selfsigned.key -out /etc/ssl/certs/apache-selfsigned.crt -subj "/C=RU/ST=Moscow/L=Moscow/O=Company Name/OU=Org/CN=testdomain.local"</br>


>root@vagrant:/home/vagrant# openssl x509 -in  /etc/ssl/certs/apache-selfsigned.crt -text</br>
>Certificate:</br>
>    Data:</br>
>        Version: 3 (0x2)</br>
>        Serial Number:</br>
>            34:64:56:84:17:f9:5c:7c:57:f7:fb:9d:34:b1:be:e6:07:38:d8:89</br>
>        Signature Algorithm: sha256WithRSAEncryption</br>
>        Issuer: C = RU, ST = Moscow, L = Moscow, O = Company Name, OU = Org, CN = testdomain.local</br>
>        Validity</br>
>            Not Before: Mar  1 06:48:45 2022 GMT</br>
>            Not After : Mar  1 06:48:45 2023 GMT</br>
>        Subject: C = RU, ST = Moscow, L = Moscow, O = Company Name, OU = Org, CN = testdomain.local</br>
>        Subject Public Key Info:</br>
>            Public Key Algorithm: rsaEncryption</br>
>                RSA Public-Key: (2048 bit)</br>
>                Modulus:</br>
>                    00:c2:ef:83:26:35:a8:03:f3:e0:d1:fe:b6:a8:95:</br>
>                    dc:77:25:d2:d8:f0:14:02:a5:6d:16:18:10:08:35:</br>
>                    d5:c3:7c:9b:f6:71:b2:40:17:ae:a6:c5:7a:62:fb:</br>
>                    72:fc:69:c7:fe:2f:d6:a6:ab:1b:dd:08:6a:26:bb:</br>
>                    f4:0e:25:72:4e:1f:b9:92:8e:c9:87:b8:f6:cc:b8:</br>
>                    25:55:75:50:d2:05:58:69:f4:2f:1c:8a:4a:8b:0d:</br>
>                    8a:2c:f4:1d:5c:f7:63:1d:7f:6a:0a:59:cc:39:e1:</br>
>                    62:08:9d:d8:ff:f8:bd:97:d4:4f:6b:80:f8:47:58:</br>
>                    4c:36:83:3b:2e:33:83:c7:7d:f7:cc:db:58:32:ef:</br>
>                    b1:f9:03:24:f3:75:75:2c:c1:4d:7b:b2:72:44:c3:</br>
>                    3c:30:2a:d3:16:92:83:27:a3:a7:82:a4:c5:9d:68:</br>
>                    4d:ca:a3:89:5c:d7:58:4a:76:24:ac:c6:aa:6c:fc:</br>
>                    89:fc:34:88:a3:13:84:4e:89:26:71:57:b5:39:4c:</br>
>                    fb:b6:b6:26:39:92:5c:35:12:bf:1c:60:af:82:b1:</br>
>                    71:4b:76:24:22:e0:41:f4:d1:a2:22:76:12:90:7a:</br>
>                    08:b2:75:f7:34:d3:2e:bd:31:83:5b:73:81:43:48:</br>
>                    8d:8a:bd:a2:d7:89:e0:f7:ee:f4:d1:09:f3:78:46:</br>
>                    73:29</br>
>                Exponent: 65537 (0x10001)</br>
>        X509v3 extensions:</br>
>            X509v3 Subject Key Identifier:</br>
>                6C:97:4F:66:33:58:EF:DB:65:51:BD:45:7B:E3:96:BC:92:1D:D9:76</br>
>            X509v3 Authority Key Identifier:</br>
>                keyid:6C:97:4F:66:33:58:EF:DB:65:51:BD:45:7B:E3:96:BC:92:1D:D9:76</br>
></br>
>            X509v3 Basic Constraints: critical</br>
>                CA:TRUE</br>
>    Signature Algorithm: sha256WithRSAEncryption</br>
>         a5:46:b0:f5:d0:78:4f:b2:e6:7f:20:50:b4:a9:1e:49:46:7d:</br>
>         b5:24:c8:b4:8d:4f:82:1a:f8:7d:a4:32:9c:1e:05:28:d4:1e:</br>
>         8c:ed:0f:0e:37:a8:7c:89:2c:c0:92:44:9a:c0:b9:49:32:19:</br>
>         67:80:19:14:57:8c:8a:6f:37:35:24:fa:fe:9a:d3:99:ce:96:</br>
>         3a:27:29:dd:35:f2:d7:ad:8c:b6:a2:cb:ae:17:6e:ca:18:50:</br>
>         df:fb:a0:dc:ed:46:6e:23:72:e3:4d:6b:fa:38:62:58:52:f0:</br>
>         10:12:41:32:5a:21:b8:43:aa:63:dc:06:4f:ef:d8:c1:83:62:</br>
>         cd:20:34:c9:6a:75:a9:f7:16:9d:2f:f2:be:89:43:66:54:7f:</br>
>         ea:21:bf:1a:27:dc:41:49:bb:c7:96:4f:37:ac:e1:79:5f:86:</br>
>         e8:32:4f:1d:9c:f1:f7:84:b3:ef:88:50:5d:98:22:b6:33:06:</br>
>         fe:b5:a9:68:66:02:16:a9:fb:39:27:6a:c8:7d:1e:60:63:a2:</br>
>         8c:42:78:ed:6a:37:37:35:49:2d:38:4c:38:48:37:2a:bd:c4:</br>
>         c1:be:1d:91:07:1e:2c:1a:a4:64:0b:f8:f5:a2:32:40:c2:18:</br>
>         0f:52:c6:ee:aa:96:b0:8b:49:db:a2:86:f9:02:ea:5d:49:4b:</br>
>         20:14:02:28</br>
>-----BEGIN CERTIFICATE-----</br>
>MIIDvzCCAqegAwIBAgIUNGRWhBf5XHxX9/udNLG+5gc42IkwDQYJKoZIhvcNAQEL</br>
>BQAwbzELMAkGA1UEBhMCUlUxDzANBgNVBAgMBk1vc2NvdzEPMA0GA1UEBwwGTW9z</br>
>Y293MRUwEwYDVQQKDAxDb21wYW55IE5hbWUxDDAKBgNVBAsMA09yZzEZMBcGA1UE</br>
>AwwQdGVzdGRvbWFpbi5sb2NhbDAeFw0yMjAzMDEwNjQ4NDVaFw0yMzAzMDEwNjQ4</br>
>NDVaMG8xCzAJBgNVBAYTAlJVMQ8wDQYDVQQIDAZNb3Njb3cxDzANBgNVBAcMBk1v</br>
>c2NvdzEVMBMGA1UECgwMQ29tcGFueSBOYW1lMQwwCgYDVQQLDANPcmcxGTAXBgNV</br>
>BAMMEHRlc3Rkb21haW4ubG9jYWwwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEK</br>
>AoIBAQDC74MmNagD8+DR/raoldx3JdLY8BQCpW0WGBAINdXDfJv2cbJAF66mxXpi</br>
>+3L8acf+L9amqxvdCGomu/QOJXJOH7mSjsmHuPbMuCVVdVDSBVhp9C8cikqLDYos</br>
>9B1c92Mdf2oKWcw54WIIndj/+L2X1E9rgPhHWEw2gzsuM4PHfffM21gy77H5AyTz</br>
>dXUswU17snJEwzwwKtMWkoMno6eCpMWdaE3Ko4lc11hKdiSsxqps/In8NIijE4RO</br>
>iSZxV7U5TPu2tiY5klw1Er8cYK+CsXFLdiQi4EH00aIidhKQegiydfc00y69MYNb</br>
>c4FDSI2KvaLXieD37vTRCfN4RnMpAgMBAAGjUzBRMB0GA1UdDgQWBBRsl09mM1jv</br>
>22VRvUV745a8kh3ZdjAfBgNVHSMEGDAWgBRsl09mM1jv22VRvUV745a8kh3ZdjAP</br>
>BgNVHRMBAf8EBTADAQH/MA0GCSqGSIb3DQEBCwUAA4IBAQClRrD10HhPsuZ/IFC0</br>
>qR5JRn21JMi0jU+CGvh9pDKcHgUo1B6M7Q8ON6h8iSzAkkSawLlJMhlngBkUV4yK</br>
>bzc1JPr+mtOZzpY6JyndNfLXrYy2osuuF27KGFDf+6Dc7UZuI3LjTWv6OGJYUvAQ</br>
>EkEyWiG4Q6pj3AZP79jBg2LNIDTJanWp9xadL/K+iUNmVH/qIb8aJ9xBSbvHlk83</br>
>rOF5X4boMk8dnPH3hLPviFBdmCK2Mwb+taloZgIWqfs5J2rIfR5gY6KMQnjtajc3</br>
>NUktOEw4SDcqvcTBvh2RBx4sGqRkC/j1ojJAwhgPUsbuqpawi0nboob5AupdSUsg</br>
>FAIo</br>
>-----END CERTIFICATE-----</br>
