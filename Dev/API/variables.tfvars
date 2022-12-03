###############################################################################################################
# 
terraform_remote_state_bucket = "sanfernando-id-desarrollo-tfstate-dev-974f5e2777751dffd9b5"

terraform_remote_state_prefix = "terraform/dev.tfstate"

project_id = "sanfernando-id-desarrollo"

region = "us-central1"

zona = "us-central1-a"

hostname = "api"

machine_type = "e2-medium"

startup_script = ""

#metadata = {}

#service_account = 

subnetwork = "vpcdev-priv-subnet-02"

subnetwork_project = "sanfernando-id-desarrollo"

source_image = "projects/ubuntu-os-cloud/global/images/ubuntu-2204-jammy-v20221123"

disk_size_gb = "16"

disk_type = "pd-ssd"

disk_labels = { "api" : "true" }

target_size = 1

distribution_policy_zones = ["us-central1-a", "us-central1-b"]

max_replicas = 2

min_replicas = 1

autoscaling_enabled = true

#tags = ["egress-inet"]