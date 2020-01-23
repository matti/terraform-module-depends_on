# terraform module depends_list

This is a workaround for https://github.com/hashicorp/terraform/issues/10462 to make terraform modules work like resources depends_on


## demo

With following main.tf

```
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
```

Modules (resources) are created after each other:

```
GOOGLE_PROJECT=my-project GOOGLE_REGION=europe-north1  terraform apply -auto-approve
module.ip_address_1.google_compute_address.default: Creating...
module.ip_address_1.google_compute_address.default: Creation complete after 4s [id=projects/my-project/regions/europe-north1/addresses/first]
module.ip_address_2.google_compute_address.default: Creating...
module.ip_address_2.google_compute_address.default: Creation complete after 4s [id=projects/my-project/regions/europe-north1/addresses/second]

Apply complete! Resources: 2 added, 0 changed, 0 destroyed.
```
