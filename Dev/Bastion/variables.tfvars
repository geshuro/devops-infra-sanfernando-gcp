###############################################################################################################
# 
terraform_remote_state_bucket = "sanfernando-id-desarrollo-tfstate-dev-974f5e2777751dffd9b5"

terraform_remote_state_prefix = "terraform/dev.tfstate"

project_id = "sanfernando-id-desarrollo"

region = "us-central1"

zona = "us-central1-a"

subnet_network_self_link = "https://www.googleapis.com/compute/v1/projects/sanfernando-id-desarrollo/regions/us-central1/subnetworks/vpcdev-priv-subnet-02"

members = ["user:isaac.mendoza.huamani@gmail.com"]

machine_type = "e2-small"

image_family = "centos-7-v20221102"

image_project = "centos-cloud"

disk_size_gb = "20"

disk_type = "pd-ssd"

additional_ports = ["3306"]