# -- workaround
variable "depends_list" {
  default = []
}

output "depend_on" {
  # list all resources in this module here so that other modules are able to depend on this
  value = [google_compute_address.default.id]
}

# -- actual module
variable "name" {}
resource "google_compute_address" "default" {
  # set this for every resource created in this module so that creation blocks until the dependencies have been created
  depends_on = [var.depends_list]

  name = var.name
}
