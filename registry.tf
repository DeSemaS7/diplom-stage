resource "yandex_container_registry" "my-registry" {
  name      = "my-registry"
}
resource "yandex_container_registry_iam_binding" "pusher" {
  registry_id = yandex_container_registry.my-registry.id
  role        = "container-registry.images.pusher"

  members = [
    "system:allUsers",
  ]
}