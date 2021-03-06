resource "yandex_iam_service_account" "k8s-admin" {
  name        = "k8s-admin"
}

resource "yandex_resourcemanager_folder_iam_member" "k8s-editor" {
  folder_id = "${yandex_vpc_network.terra_network.folder_id}"
  role = "editor"
  member = "serviceAccount:${yandex_iam_service_account.k8s-admin.id}"
  depends_on = [yandex_vpc_network.terra_network]
}

resource "yandex_kubernetes_cluster" "stage-cluster" {
  name        = "stage-cluster"
    network_id = "${yandex_vpc_network.terra_network.id}"

  master {
    regional {
      region = "ru-central1"
      location {
        zone      = "${yandex_vpc_subnet.network-a.zone}"
        subnet_id = "${yandex_vpc_subnet.network-a.id}"
      }
      location {
        zone      = "${yandex_vpc_subnet.network-b.zone}"
        subnet_id = "${yandex_vpc_subnet.network-b.id}"
      }
      location {
        zone      = "${yandex_vpc_subnet.network-c.zone}"
        subnet_id = "${yandex_vpc_subnet.network-c.id}"
      }
    }
    public_ip = true

    maintenance_policy {
      auto_upgrade = true
      maintenance_window {
        day        = "monday"
        start_time = "02:00"
        duration   = "3h"
      }
      maintenance_window {
        day        = "sunday"
        start_time = "03:00"
        duration   = "4h"
      }
    }
  }

  service_account_id      = "${yandex_iam_service_account.k8s-admin.id}"
  node_service_account_id = "${yandex_iam_service_account.k8s-admin.id}"

  release_channel = "STABLE"
  depends_on = [yandex_resourcemanager_folder_iam_member.k8s-editor]
}
resource "yandex_kubernetes_node_group" "k8s-nodes" {
  cluster_id  = "${yandex_kubernetes_cluster.stage-cluster.id}"
  name        = "k8s-nodes"

  instance_template {
    platform_id = "standard-v2"

    network_interface {
      nat                = true
      subnet_ids         = ["${yandex_vpc_subnet.network-a.id}","${yandex_vpc_subnet.network-b.id}","${yandex_vpc_subnet.network-c.id}"]
    }

    resources {
      memory = 2
      cores  = 2
      core_fraction = 50
    }

    boot_disk {
      type = "network-hdd"
      size = 64
    }

    scheduling_policy {
      preemptible = true
    }

    container_runtime {
      type = "containerd"
    }
    metadata = {
      ssh-keys          = "${file("pubkey.txt")}"
      }
  }

  scale_policy {
    fixed_scale {
      size = 3
    }
  }

  allocation_policy {
    location {
      zone = "${yandex_vpc_subnet.network-a.zone}"
    }
    location {
      zone = "${yandex_vpc_subnet.network-b.zone}"
    }
	location {
      zone = "${yandex_vpc_subnet.network-c.zone}"
    }
  }

}