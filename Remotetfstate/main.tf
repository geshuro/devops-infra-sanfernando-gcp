// Google Cloud provider
provider "google" {
  credentials = "${file("./gcloud-service-account.json")}"
  project     = "${var.project_id}"
  region      = "${var.region}"
}
##### Locals
locals {
  common_labels = {
    Owner        = "${var.owner}",
    Environment  = "${var.environment}",
    CostCenter   = "${var.costcenter}",
    CostCenterId = "${var.costcenterid}",
    ServiceId    = "${var.serviceid}",
    ProjectId    = "${var.project_id}"
  }
}
#------------------------------
# Remote State Locking
#------------------------------
module "remote_state" {
  source              = "../Modules/terraform-google-remote-state"
  name_prefix         = "${var.project_name}-tfstate-${var.environment}"
  location            = var.region
  project_id          = var.project_id
  backend_output_path = "${path.module}/backend.tf"

  prefix              = var.prefix
  force_destroy       = var.force_destroy
  enable_versioning   = var.enable_versioning

  //labels = local.common_labels
}
