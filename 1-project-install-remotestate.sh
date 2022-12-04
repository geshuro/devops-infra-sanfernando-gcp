#!/bin/bash
# Ejecutar proceso y pasos para creacion del remote state.
cd Remotetfstate
terraform init
terraform plan -var-file=variables.tfvars
terraform apply -var-file=variables.tfvars -auto-approve