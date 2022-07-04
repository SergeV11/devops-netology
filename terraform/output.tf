output "internal_ip_address_ubuntu2004" {
  value = "${yandex_compute_instance.vm-ubuntu-2004.network_interface.0.ip_address}"
}

output "external_ip_address_ubuntu2004" {
  value = "${yandex_compute_instance.vm-ubuntu-2004.network_interface.0.nat_ip_address}"
}
