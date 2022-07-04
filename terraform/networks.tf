resource "yandex_vpc_network" "default" {
  name        = "default"
  description = "Test Network"

}

resource "yandex_vpc_subnet" "default" {
  name           = "default"
  network_id     = "${yandex_vpc_network.default.id}"
  description    = "Test"
  v4_cidr_blocks = ["10.0.0.0/24"]

}
