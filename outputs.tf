output "master_ext_address" {
  value = yandex_kubernetes_cluster.first-cluster.master.external_v4_address
}
output "master_ext_endpoint" {
  value = yandex_kubernetes_cluster.first-cluster.master.external_v4_endpoint
}