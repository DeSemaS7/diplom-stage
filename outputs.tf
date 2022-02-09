output "master_ext_address" {
  value = yandex_kubernetes_cluster.first-cluster.master[0].external_v4_address
}
output "registry_id" {
  value = yandex_container_registry.my-registry.id
}


