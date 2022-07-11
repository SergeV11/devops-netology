# Домашнее задание к занятию "7.6. Написание собственных провайдеров для Terraform."

## 1. 


resource:</br>
https://github.com/hashicorp/terraform-provider-aws/blob/8e4d8a3f3f781b83f96217c2275f541c893fec5a/aws/provider.go#L411</br>

data_source:</br>
https://github.com/hashicorp/terraform-provider-aws/blob/8e4d8a3f3f781b83f96217c2275f541c893fec5a/aws/provider.go#L169</br>


## 2.

- конфликтует с name_prefix</br>
https://github.com/hashicorp/terraform-provider-aws/blob/8e4d8a3f3f781b83f96217c2275f541c893fec5a/aws/resource_aws_sqs_queue.go#L56</br>

- максимальная длина имени 80 символов</br>
https://github.com/hashicorp/terraform-provider-aws/blob/8e4d8a3f3f781b83f96217c2275f541c893fec5a/aws/validators.go#L1038</br>

- регулярное выражение regexp.MustCompile(`^[0-9A-Za-z-_]+(\.fifo)?$`).MatchString(value)</br>
это означает что имя может начинаться с любой буквы, цифры,тире или подчеркивания, а заканчиваться должно на .fifo</br>
https://github.com/hashicorp/terraform-provider-aws/blob/8e4d8a3f3f781b83f96217c2275f541c893fec5a/aws/validators.go#L1041
