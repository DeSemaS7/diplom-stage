terraform {
  backend "remote" {
    hostname = "app.terraform.io"
    organization = "neto-diplom"

    workspaces {
      prefix = "diplom-"
    }
  }
}

provider "yandex" {
  token     = "<OAuth>"
  cloud_id  = "b1ge9kc6o4mjqkq8g442"

}

