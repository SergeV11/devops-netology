# Доработка к домашнему заданию к занятию "7.3. Основы и принцип работы Терраформ"


у меня count работает далеко не во всех ресурсах, тем более в описании инстансов, обычно я получаю такую ошибку:</br>
An argument named "count" is not expected here.</br>
я нашёл только 3 ресурса где его можно использовать, это metadata, local_file и vpc_route_table поэтому в задании использовал их


```
 terraform plan

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # local_file.test["description"] will be created
  + resource "local_file" "test" {
      + content              = "test2"
      + directory_permission = "0777"
      + file_permission      = "0777"
      + filename             = "description"
      + id                   = (known after apply)
    }

  # local_file.test["name"] will be created
  + resource "local_file" "test" {
      + content              = "test1"
      + directory_permission = "0777"
      + file_permission      = "0777"
      + filename             = "name"
      + id                   = (known after apply)
    }

  # yandex_compute_disk.disk-srv will be created
  + resource "yandex_compute_disk" "disk-srv" {
      + block_size  = 4096
      + created_at  = (known after apply)
      + folder_id   = (known after apply)
      + id          = (known after apply)
      + name        = "disk-srv"
      + product_ids = (known after apply)
      + size        = 5
      + status      = (known after apply)
      + type        = "network-hdd"
      + zone        = (known after apply)

      + disk_placement_policy {
          + disk_placement_group_id = (known after apply)
        }
    }

  # yandex_compute_instance.vm-ubuntu-2004 will be created
  + resource "yandex_compute_instance" "vm-ubuntu-2004" {
      + allow_stopping_for_update = true
      + created_at                = (known after apply)
      + description               = "Netology instance"
      + folder_id                 = (known after apply)
      + fqdn                      = (known after apply)
      + hostname                  = (known after apply)
      + id                        = (known after apply)
      + metadata                  = {
          + "ssh-keys" = <<-EOT
                extor:ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDFpPxepfrS4+JSs+jGRmZPRfh7cuDtzOzUTYKR4pYZCrKfVEFGxY+pwgUN6JRU0zUkcOHkgT11P62VF14vnBIEl9XdwvhnGF8vHGLAkW1LnTeQ86elt3mFgyZMVr3/L+kx6PeZh2wgS4dkQSwY14mIQnRPUxGUqIrAXh0wXGikKLJJ9RqAVx45JKo4ENIv1AyrpN8THsP/Una7LlpIo3Ny0V3DOWe2kiZd30SewAfYPAorXGSG1O3xlI9lvxjopLU0dFQEb8+fCC0exJ88FhiyX5Ale1Ihi7amrxnqCOPabO9dIupxBerSLi7j4J5bHKZBbYNErsmbShYa68yD/EuJ root@nM
            EOT
        }
      + name                      = "vm-ubuntu-2004"
      + network_acceleration_type = "standard"
      + platform_id               = "standard-v1"
      + service_account_id        = (known after apply)
      + status                    = (known after apply)
      + zone                      = (known after apply)

      + boot_disk {
          + auto_delete = true
          + device_name = (known after apply)
          + disk_id     = (known after apply)
          + mode        = (known after apply)

          + initialize_params {
              + block_size  = (known after apply)
              + description = "Disk for the root"
              + image_id    = "fd8u31li6herqe2ummsn"
              + name        = "disk-root"
              + size        = 20
              + snapshot_id = (known after apply)
              + type        = "network-hdd"
            }
        }

      + network_interface {
          + index              = (known after apply)
          + ip_address         = (known after apply)
          + ipv4               = true
          + ipv6               = (known after apply)
          + ipv6_address       = (known after apply)
          + mac_address        = (known after apply)
          + nat                = true
          + nat_ip_address     = (known after apply)
          + nat_ip_version     = (known after apply)
          + security_group_ids = (known after apply)
          + subnet_id          = (known after apply)
        }

      + placement_policy {
          + host_affinity_rules = (known after apply)
          + placement_group_id  = (known after apply)
        }

      + resources {
          + core_fraction = 5
          + cores         = 2
          + memory        = 2
        }

      + scheduling_policy {
          + preemptible = (known after apply)
        }

      + secondary_disk {
          + auto_delete = true
          + device_name = (known after apply)
          + disk_id     = (known after apply)
          + mode        = "READ_WRITE"
        }
    }

  # yandex_vpc_network.default will be created
  + resource "yandex_vpc_network" "default" {
      + created_at                = (known after apply)
      + default_security_group_id = (known after apply)
      + description               = "Test Network"
      + folder_id                 = (known after apply)
      + id                        = (known after apply)
      + labels                    = (known after apply)
      + name                      = "default"
      + subnet_ids                = (known after apply)
    }

  # yandex_vpc_route_table.private[0] will be created
  + resource "yandex_vpc_route_table" "private" {
      + created_at = (known after apply)
      + folder_id  = (known after apply)
      + id         = (known after apply)
      + labels     = (known after apply)
      + network_id = (known after apply)
    }

  # yandex_vpc_route_table.private[1] will be created
  + resource "yandex_vpc_route_table" "private" {
      + created_at = (known after apply)
      + folder_id  = (known after apply)
      + id         = (known after apply)
      + labels     = (known after apply)
      + network_id = (known after apply)
    }

  # yandex_vpc_subnet.default will be created
  + resource "yandex_vpc_subnet" "default" {
      + created_at     = (known after apply)
      + description    = "Test"
      + folder_id      = (known after apply)
      + id             = (known after apply)
      + labels         = (known after apply)
      + name           = "default"
      + network_id     = (known after apply)
      + v4_cidr_blocks = [
          + "10.0.0.0/24",
        ]
      + v6_cidr_blocks = (known after apply)
      + zone           = (known after apply)
    }

Plan: 8 to add, 0 to change, 0 to destroy.

Changes to Outputs:
  + external_ip_address_ubuntu2004 = (known after apply)
  + internal_ip_address_ubuntu2004 = (known after apply)
```

```
cat main.tf
provider "yandex" {
service_account_key_file = "/home/cht/netology/yc/key.json"
}

locals {

        instance_count_core_map = {
        stage = "1"
        prod  = "2"
       }

        count_vpc_map = {
        stage = 1
        prod  = 2
       }

files = {
name = "test1"
description = "test2"
}

      }

resource "yandex_compute_instance" "vm-ubuntu-2004"  {
  name                      = "vm-ubuntu-2004"
  description               = "Netology instance"
  allow_stopping_for_update = true


lifecycle {
create_before_destroy = true
}

  resources {
    cores         = local.instance_count_core_map[terraform.workspace]
    memory        = 2
    core_fraction = 5
  }

  boot_disk {
    auto_delete = true

    initialize_params {
      image_id    = "fd8u31li6herqe2ummsn"
      name        = "disk-root"
      description = "Disk for the root"
      size        = "${var.instance_root_disk}"
    }
  }

  metadata = {
    ssh-keys = "extor:${file("~/.ssh/id_rsa.pub")}"
  }

  secondary_disk {
    disk_id     = "${yandex_compute_disk.disk-srv.id}"
    auto_delete = true
  }

  network_interface {
    subnet_id = "${yandex_vpc_subnet.default.id}"
    nat       = true
  }

}

resource "yandex_compute_disk" "disk-srv" {
  name = "disk-srv"
  type = "network-hdd"
  size = "${var.instance_additional_disk}"

}

resource "yandex_vpc_route_table" "private" {
  count = local.count_vpc_map[terraform.workspace]
  network_id = "${yandex_vpc_network.default.id}"

}

resource "local_file" "test" {
  for_each = local.files
  content  = each.value
  filename =  each.key

}

```
