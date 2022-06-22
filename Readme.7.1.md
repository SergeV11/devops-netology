# Домашнее задание к занятию "7.1. Инфраструктура как код"

## 1.



1.1. на первом этапе можно использовать оба типа, так как будет много изменений и корректировок, а затем неизменяемая для того чтобы среда разработки не отличалась от продакшена

1.2. на первом этапе мне кажется лучше использовать без центрального сервера в целях простоты, удобства и минимального времени внедрения, например Ansible. в дальнейшем можно перейти например на chef.

1.3. пока будет использоваться ansible агентов не будет

1.4. будут использованы оба типа

2.1 я бы оставил все инструменты, разве что поменял тимсити на дженксинс и избавился бы от Сloud Formation , переведя код в терраформ

3.1 на данном этапе нет, а когда процесс будет отлажен и внешних клиентов станет больше, то можно подумать об оптимизации


## 2.

в каком-то домашнем задании мы уже использовали терраформ

```
root@nM:/home/cht/netology/terraform# terraform --version
Terraform v1.1.9
on linux_amd64
+ provider registry.terraform.io/yandex-cloud/yandex v0.74.0

Your version of Terraform is out of date! The latest version
is 1.2.3. You can update by downloading from https://www.terraform.io/downloads.html
```

## 3.

```
mkdir terraform_new && cd terraform_new
torsocks wget https://releases.hashicorp.com/terraform/1.2.3/terraform_1.2.3_linux_amd64.zip
unzip terraform_1.2.3_linux_amd64.zip
./terraform --version
Terraform v1.2.3
on linux_amd64

terraform --version
Terraform v1.1.9
on linux_amd64
+ provider registry.terraform.io/yandex-cloud/yandex v0.74.0

Your version of Terraform is out of date! The latest version
is 1.2.3. You can update by downloading from https://www.terraform.io/downloads.html
```
