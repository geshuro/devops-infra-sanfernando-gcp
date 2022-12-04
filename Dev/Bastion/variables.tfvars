###############################################################################################################
# 
terraform_remote_state_bucket = "sanfernando-id-desarrollo-tfstate-dev-e08fa5cb60758852ac89"

terraform_remote_state_prefix = "terraform/dev.tfstate"

project_id = "alpine-effort-370518"

region = "us-west1"

zona = "us-west1-a"

subnet_network_self_link = "https://www.googleapis.com/compute/v1/projects/alpine-effort-370518/regions/us-west1/subnetworks/vpcdev-priv-subnet-02"

members = ["user:iymendozah@geshuro.com"]

machine_type = "e2-small"

image_family = "centos-7-v20221102"

image_project = "centos-cloud"

disk_size_gb = "20"

disk_type = "pd-ssd"

additional_ports = ["3306"]