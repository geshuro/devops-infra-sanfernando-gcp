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

data "terraform_remote_state" "mysql" {
  backend = "gcs"
  config = {
    bucket  = "${var.terraform_remote_state_bucket}"
    prefix  = "${var.terraform_remote_state_prefix}"
    credentials = "${file("./gcloud-service-account.json")}"
  }
  workspace = "mysql"
}

data "template_file" "init" {
  template = "${file("${path.module}/templates/init.tpl")}"
  vars = {
    instance_connection_name  = "${data.terraform_remote_state.mysql.outputs.mysql_conn}"
    instance_port             = "3306"
  }
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
  image_family  = var.image_family
  image_project = var.image_project
  #startup_script = var.startup_script
  startup_script = data.template_file.init.rendered
  //atributos adicionales a modulo original
  disk_size_gb  = var.disk_size_gb
  disk_type     = var.disk_type
  additional_ports = var.additional_ports
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

/*resource "google_compute_firewall" "allow_access_mysql_from_bastion" {
  project = var.project_id
  name    = "allow-bastion-group-mysql"
  network = "${data.terraform_remote_state.networking.outputs.network_self_link}"

  allow {
    protocol = "tcp"
    ports    = ["3306"]
  }
  source_ranges = ["0.0.0.0/0"]
  # Allow SSH only from IAP Bastion
  source_service_accounts = [module.iap_bastion_group.service_account]
}*/