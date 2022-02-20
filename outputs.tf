output "master_ext_address" {
  value = yandex_kubernetes_cluster.stage-cluster.master[0].external_v4_address
}
output "repo_name" {
  value = yandex_container_repository.myapp.name
}
