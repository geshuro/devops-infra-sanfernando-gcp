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

module "iap_bastion_group" {
  source      = "../../Modules/terraform-google-bastion-host/modules/bastion-group"
  #source      = "../../modules/bastion-group"
  project     = var.project_id
  region      = var.region
  zone        = var.zona
  network     = "${data.terraform_remote_state.networking.outputs.network_self_link}"
  subnet      = var.subnet_network_self_link
  members     = var.members
  target_size = 1
  machine_type  = var.machine_type
}

resource "google_compute_firewall" "allow_access_from_bastion" {
  project = var.project_id
  name    = "allow-bastion-group-ssh"
  network = "${data.terraform_remote_state.networking.outputs.network_self_link}"

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  # Allow SSH only from IAP Bastion
  source_service_accounts = [module.iap_bastion_group.service_account]
}
