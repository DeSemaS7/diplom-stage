resource "yandex_container_registry" "my-registry" {
  name      = "my-registry"
}
resource yandex_container_repository mynginx {
  name      = "${yandex_container_registry.my-registry.id}/mynginx"
  depends_on = [yandex_container_registry.my-registry]
}
resource "yandex_container_repository_iam_binding" "pusher" {
  repository_id = yandex_container_repository.mynginx.id
  role        = "container-registry.images.pusher"

  members = [
    "system:allUsers",
  ]
}