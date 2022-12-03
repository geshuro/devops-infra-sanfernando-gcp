variable "project_id" {
  description = "Project ID where to set up the instance and IAP tunneling"
}

variable "region" {
  type        = string
  description = "Region"
  default     = "us-east1"
}

variable "zona" {
  type        = string
  description = "Zona"
  default     = "us-east1-a"
}

variable "subnet_network_self_link" {
  description = ""
}

variable "members" {
  description = "List of members in the standard GCP form: user:{email}, serviceAccount:{email}, group:{email}"
  type        = list(string)
  default     = []
}

variable "machine_type" {
  description = "Instance type for the Bastion host"
  default     = "e2-small"
}

variable "image_family" {
  description = "Source image family for the Bastion."
  default     = "debian-11"
}

variable "image_project" {
  description = "Project where the source image for the Bastion comes from"
  default     = "debian-cloud"
}

variable "startup_script" {
  description = "Render a startup script with a template."
  default     = ""
}

//atributos adicionales a modulo original
variable "disk_size_gb" {
  description = "Boot disk size in GB"
  default     = 100
}

variable "disk_type" {
  description = "Boot disk type, can be either pd-ssd, local-ssd, or pd-standard"
  default     = "pd-standard"
}

variable "additional_ports" {
  description = "A list of additional ports/ranges to open access to on the instances from IAP."
  type        = list(string)
  default     = []
}
//atributos adicionales a modulo original

variable "terraform_remote_state_bucket" {
  type    = string
  default = "sanfernando-id-desarrollo-tfstate-dev-974f5e2777751dffd9b5"
}

variable "terraform_remote_state_prefix" {
  type    = string
  default = "terraform/dev.tfstate"
}
