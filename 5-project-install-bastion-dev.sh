#K8S
cd Dev/Bastion
terraform init
terraform workspace list
terraform workspace new bastion
terraform workspace select bastion
terraform init
terraform plan -var-file=variables.tfvars
terraform apply -var-file=variables.tfvars -auto-approve
terraform destroy -var-file=variables.tfvars -auto-approve