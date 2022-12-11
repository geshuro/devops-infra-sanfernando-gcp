#K8S
cd Dev/Bastion
terraform init
terraform workspace list
terraform workspace new loadbalancer
terraform workspace select loadbalancer
terraform init
terraform plan -var-file=variables.tfvars
terraform apply -var-file=variables.tfvars -auto-approve
terraform destroy -var-file=variables.tfvars -auto-approve