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
  backend_output_path_name = var.backend_output_path == null ? "${path.module}/backend.tf" : "${path.module}/${var.backend_output_path}"
}
#------------------------------
# Remote State Locking
#------------------------------
module "remote_state" {
  source              = "../Modules/terraform-google-remote-state"
  name_prefix         = "${var.project_name}-tfstate-${var.environment}"
  location            = var.region
  project_id          = var.project_id
  backend_output_path = local.backend_output_path_name

  prefix              = var.prefix
  force_destroy       = var.force_destroy
  enable_versioning   = var.enable_versioning

  //labels = local.common_labels
}
