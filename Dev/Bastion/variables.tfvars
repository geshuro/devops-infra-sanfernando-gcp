###############################################################################################################
# 
terraform_remote_state_bucket = "sanfernando-dev-tfstate-dev-fcb5f37fb51df071c7f8"

terraform_remote_state_prefix = "terrform/dev.tfstate"

project_id = "sanfernando-dev-369401"

region = "us-west1"

zona = "us-west1-a"

subnet_network_self_link = "https://www.googleapis.com/compute/v1/projects/sanfernando-dev-369401/regions/us-west1/subnetworks/vpcdev-priv-subnet-02"

members = ["iymendozah@geshuro.com"]

machine_type = "e2-small"





hostname = "api"



startup_script = ""

#metadata = {}

#service_account = 

subnetwork = "vpcdev-priv-subnet-02"

subnetwork_project = "sanfernando-dev-369401"

source_image = "projects/ubuntu-os-cloud/global/images/ubuntu-2204-jammy-v20221123"

disk_size_gb = "16"

disk_type = "pd-ssd"

disk_labels = { "api" : "true" }

target_size = 1

distribution_policy_zones = ["us-central1-a", "us-central1-f"]

max_replicas = 2

min_replicas = 1

autoscaling_enabled = true