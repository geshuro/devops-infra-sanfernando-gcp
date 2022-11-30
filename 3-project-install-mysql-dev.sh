#K8S
cd Dev/MySQL
terraform init
terraform workspace list
terraform workspace new mysql
terraform workspace select mysql
terraform init
terraform plan -var-file=variables.tfvars
terraform apply -var-file=variables.tfvars -auto-approve
terraform destroy -var-file=variables.tfvars -auto-approve