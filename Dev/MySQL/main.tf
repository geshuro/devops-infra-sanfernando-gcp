// Google Cloud provider
provider "google-beta" {
  credentials = "${file("./gcloud-service-account.json")}"
  project     = "${var.project_id}"
  region      = "${var.region}"
}

provider "google" {
  credentials = "${file("./gcloud-service-account.json")}"
  project     = "${var.project_id}"
  region      = "${var.region}"
}

data "terraform_remote_state" "networking" {
  backend = "gcs"
  config = {
    bucket  = "${var.terraform_remote_state_bucket}"
    prefix  = "${var.terraform_remote_state_prefix}"
    credentials = "${file("./gcloud-service-account.json")}"
  }
  workspace = "networking"
}

module "private-service-access" {
  source      = "../../Modules/terraform-google-sql-db/modules/private_service_access"
  #source      = "../../modules/private_service_access"
  project_id  = var.project_id
  vpc_network =  "${data.terraform_remote_state.networking.outputs.network_name}"
}

module "safer-mysql-db" {
  source      = "../../Modules/terraform-google-sql-db/modules/safer_mysql"
  #source               = "../../modules/safer_mysql"
  name                 = var.db_name
  random_instance_name = true
  project_id           = var.project_id

  deletion_protection = false
  create_timeout      = "59m"

  database_version = "MYSQL_5_6"
  region           = var.region
  zone             = var.zona
  tier             = var.mysql_tier

  // By default, all users will be permitted to connect only via the
  // Cloud SQL proxy.
  additional_users = [
    {
      name     = "app"
      password = "PaSsWoRd"
      host     = "localhost"
      type     = "BUILT_IN"
    },
    {
      name     = "readonly"
      password = "PaSsWoRd"
      host     = "localhost"
      type     = "BUILT_IN"
    },
  ]

  assign_public_ip   = "true"
  vpc_network        = "${data.terraform_remote_state.networking.outputs.network_self_link}"
  allocated_ip_range = module.private-service-access.google_compute_global_address_name

  // Optional: used to enforce ordering in the creation of resources.
  module_depends_on = [module.private-service-access.peering_completed]
}
