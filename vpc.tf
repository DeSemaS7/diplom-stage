resource "yandex_vpc_network" "terra_network" {
  name = "network"
}

resource "yandex_vpc_subnet" "network-a" {
  name           = "network-a"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.terra_network.id
  v4_cidr_blocks = ["192.168.10.0/24"]

}
resource "yandex_vpc_subnet" "network-b" {
  name           = "network-b"
  zone           = "ru-central1-b"
  network_id     = yandex_vpc_network.terra_network.id
  v4_cidr_blocks = ["192.168.11.0/24"]
}
resource "yandex_vpc_subnet" "network-c" {
  name           = "network-c"
  zone           = "ru-central1-c"
  network_id     = yandex_vpc_network.terra_network.id
  v4_cidr_blocks = ["192.168.12.0/24"]
}

