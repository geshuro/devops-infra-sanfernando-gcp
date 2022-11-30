#K8S
cd Dev/API
terraform init
terraform workspace list
terraform workspace new api
terraform workspace select api
terraform init
terraform plan -var-file=variables.tfvars
terraform apply -var-file=variables.tfvars -auto-approve
terraform destroy -var-file=variables.tfvars -auto-approve