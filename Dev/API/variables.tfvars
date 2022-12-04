###############################################################################################################
# 
terraform_remote_state_bucket = "sanfernando-id-desarrollo-tfstate-dev-e08fa5cb60758852ac89"

terraform_remote_state_prefix = "terraform/dev.tfstate"

project_id = "alpine-effort-370518"

region = "us-west1"

zona = "us-west1-a"

hostname = "api"

machine_type = "e2-medium"

startup_script = ""

#metadata = {}

#service_account = 

subnetwork = "vpcdev-priv-subnet-02"

subnetwork_project = "alpine-effort-370518"

source_image = "projects/ubuntu-os-cloud/global/images/ubuntu-2204-jammy-v20221123"

disk_size_gb = "16"

disk_type = "pd-ssd"

disk_labels = { "api" : "true" }

target_size = 1

distribution_policy_zones = ["us-west1-a", "us-west1-b"]

max_replicas = 2

min_replicas = 1

autoscaling_enabled = true

#tags = ["egress-inet"]