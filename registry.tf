resource "yandex_container_registry" "my-registry" {
  name      = "my-registry"
}
resource yandex_container_repository myapp {
  name      = "${yandex_container_registry.my-registry.id}/myapp"
  depends_on = [yandex_container_registry.my-registry]
}
resource "yandex_container_repository_iam_binding" "pusher" {
  repository_id = yandex_container_repository.myapp.id
  role        = "container-registry.images.pusher"

  members = [
    "system:allUsers",
  ]
}