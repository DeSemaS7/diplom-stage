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
  service_account_key_file = "${terraform.workspace} == stage ? ./terracloud.json : ./keytest.json"
  folder_id = "b1grcnk7hrc2350cime9"
  cloud_id  = "b1ge9kc6o4mjqkq8g442"

}

