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
