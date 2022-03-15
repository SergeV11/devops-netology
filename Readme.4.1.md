1.

>c - a+b</br>
>d - 1+2</br>
>e - 3</br>
></br>
>переменной c присвоен обычный текст</br>
>переменная d принимает значение переменной a, потом текст "+" и значение переменной b, знак $ указывает что это переменная, а не текст</br>
>переменная e принимает результат математической операции сложения, так как выражение указано в скобках и начинается с $</br>

 
2.

>в скрипте не указан выход из цикла, поэтому в файл curl.log будет дописываться дата до тех пор пока сервис не поднимется, а потом цикл так и будет вечно висеть. исправить ситуацию можно например ператором break</br>
>к тому же там пропущена скобка while ((1==1)</br>
></br>
>while ((1==1))</br>
>do</br>
>	curl https://localhost:4757</br>
>	if (($? != 0))</br>
>	then</br>
>		date >> curl.log</br>
>		else</br>
>		break</br>
>	fi</br>
>done</br>


3.

>nmap -Pn -p 80 192.168.0.1 173.194.222.113 87.250.250.242 --max-retries 5|grep  'report\\|http'|sed "s/Nmap scan report for/ /g" > log; sed -i '1d' log</br>
>cat log</br>
>  192.168.0.1</br>
>80/tcp filtered http</br>
>  lo-in-f113.1e100.net (173.194.222.113)</br>
>80/tcp open  http</br>
>  ya.ru (87.250.250.242)</br>
>80/tcp open  http</br>


4.


>#!/bin/bash</br>
>ip1=192.168.0.1</br>
>ip2=173.194.222.113</br>
>ip3=87.250.250.242</br>
>port=80</br>
>stop=0</br>
></br>
>echo -e "$ip1\n$ip2\n$ip3" > ips</br>
></br>
>while ((stop==0))</br>
>do</br>
>        while IFS= read -r ip; do</br>
>        a=\`nmap -p $port $ip|grep "80/tcp"|grep open\`</br>
>        if [[ -z "$a" ]];then echo $ip >error;stop=1;fi</br>
>        done < ips</br>
>done</br>
></br>
> cat error</br>
>192.168.0.1</br>

