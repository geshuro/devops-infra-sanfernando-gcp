#K8S
cd Dev/Security
terraform init
terraform workspace list
terraform workspace new security
terraform workspace select security
terraform init
terraform plan -var-file=variables.tfvars
terraform apply -var-file=variables.tfvars -auto-approve
terraform destroy -var-file=variables.tfvars -auto-approve