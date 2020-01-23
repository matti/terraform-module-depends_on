provider "google" {}

module "ip_address_1" {
  source = "./modules/ip_address"

  name = "first"
}

module "ip_address_2" {
  source = "./modules/ip_address"
  # list all dependencies here
  depends_list = [module.ip_address_1.depend_on]

  name = "second"
}
