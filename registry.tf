resource "yandex_container_registry" "my-registry" {
  name      = "my-registry"
}
resource "yandex_container_registry_iam_binding" "editor" {
  registry_id = yandex_container_registry.my-registry.id
  role        = "editor"

  members = [
    "system:allUsers",
  ]
}