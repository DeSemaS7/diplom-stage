resource "yandex_vpc_network" "terra_network" {
  name = "network-${terraform.workspace}"
}

resource "yandex_vpc_subnet" "public-a" {
  name           = "public-a-${terraform.workspace}"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.terra_network.id
  v4_cidr_blocks = ["192.168.10.0/24"]

}
resource "yandex_vpc_subnet" "public-b" {
  name           = "public-b-${terraform.workspace}"
  zone           = "ru-central1-b"
  network_id     = yandex_vpc_network.terra_network.id
  v4_cidr_blocks = ["192.168.11.0/24"]
}
resource "yandex_vpc_subnet" "public-c" {
  name           = "public-c-${terraform.workspace}"
  zone           = "ru-central1-c"
  network_id     = yandex_vpc_network.terra_network.id
  v4_cidr_blocks = ["192.168.12.0/24"]
  count = "${terraform.workspace == "diplom-stage" ? 1 : 0}"
}