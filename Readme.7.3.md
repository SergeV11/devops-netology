# Домашнее задание к занятию "7.3. Основы и принцип работы Терраформ"

так как в yc нет instance_type ,то я использовал количество ядер вм. для прода 2, для стейджа 1</br>
также там нет count (по крайней мере в документации не нашёл) поэтому использовал группу вм с масштабированием, для прода 2, для стейджа 1


## 1.
```
terraform workspace list

  default
* prod
  stage
```

## 2.
```
terraform plan

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

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
                extor:ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDFpPxepfrS4+JSs+jGRmZPRfh7cuDtzOzUTYKR4pYZCrKfVEFGxY+pwgUN6JRU0zUkcOHkgT11P62VF14vnBIEl9XdwvhnGF8vHGLAkW1LnTeQ86elt3mFgyZMVr3/L

+kx6PeZh2wgS4dkQSwY14mIQnRPUxGUqIrAXh0wXGikKLJJ9RqAVx45JKo4ENIv1AyrpN8THsP/Una7LlpIo3Ny0V3DOWe2kiZd30SewAfYPAorXGSG1O3xlI9lvxjopLU0dFQEb8+fCC0exJ88FhiyX5Ale1Ihi7amrxnqCOPabO9dIupxBerSLi7j4J5bHKZBbYNErsmbShYa68yD/EuJ root@nM
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

  # yandex_kubernetes_node_group.netology-node will be created
  + resource "yandex_kubernetes_node_group" "netology-node" {
      + cluster_id        = "1"
      + created_at        = (known after apply)
      + description       = "test nodes"
      + id                = (known after apply)
      + instance_group_id = (known after apply)
      + labels            = (known after apply)
      + name              = "node"
      + status            = (known after apply)
      + version           = (known after apply)
      + version_info      = (known after apply)

      + allocation_policy {
          + location {
              + subnet_id = (known after apply)
              + zone      = (known after apply)
            }
        }

      + deploy_policy {
          + max_expansion   = (known after apply)
          + max_unavailable = (known after apply)
        }

      + instance_template {
          + metadata                  = (known after apply)
          + nat                       = (known after apply)
          + network_acceleration_type = (known after apply)
          + platform_id               = "standard-v2"

          + boot_disk {
              + size = 64
              + type = "network-hdd"
            }

          + container_runtime {
              + type = (known after apply)
            }

          + network_interface {
              + ipv4               = (known after apply)
              + ipv6               = (known after apply)
              + nat                = (known after apply)
              + security_group_ids = (known after apply)
              + subnet_ids         = (known after apply)
            }

          + resources {
              + core_fraction = (known after apply)
              + cores         = 2
              + gpus          = 0
              + memory        = 4
            }

          + scheduling_policy {
              + preemptible = false
            }
        }

      + maintenance_policy {
          + auto_repair  = (known after apply)
          + auto_upgrade = (known after apply)

          + maintenance_window {
              + day        = (known after apply)
              + duration   = (known after apply)
              + start_time = (known after apply)
            }
        }

      + scale_policy {

          + fixed_scale {
              + size = 2
            }
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

Plan: 5 to add, 0 to change, 0 to destroy.

Changes to Outputs:
  + external_ip_address_ubuntu2004 = (known after apply)
  + internal_ip_address_ubuntu2004 = (known after apply)
```


 и на всякий случай main.tf :

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

        count_instance_map = {
        stage = 1
        prod  = 2
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

  secondary_disk {
    disk_id     = "${yandex_compute_disk.disk-srv.id}"
    auto_delete = true
  }

  network_interface {
    subnet_id = "${yandex_vpc_subnet.default.id}"
    nat       = true
  }

  metadata = {
    ssh-keys = "extor:${file("~/.ssh/id_rsa.pub")}"
  }

}

resource "yandex_compute_disk" "disk-srv" {
  name = "disk-srv"
  type = "network-hdd"
  size = "${var.instance_additional_disk}"

}



resource "yandex_kubernetes_node_group" "netology-node" {
  cluster_id  = 1
  name        = "node"
  description = "test nodes"

  instance_template {
    platform_id = "standard-v2"

    resources {
      memory = 4
      cores  = 2
    }

    boot_disk {
      type = "network-hdd"
      size = 64
    }

    scheduling_policy {
      preemptible = false
    }
  }

  scale_policy {
    fixed_scale {
      size = local.count_instance_map[terraform.workspace]
    }
  }

}
```
