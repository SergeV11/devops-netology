provider "yandex" {
service_account_key_file = "/home/cht/netology/yc/key.json"
}

resource "yandex_compute_instance" "vm-ubuntu-2004" {
  name                      = "vm-ubuntu-2004"
  description               = "Netology instance"
  allow_stopping_for_update = true

  resources {
    cores         = 2
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
