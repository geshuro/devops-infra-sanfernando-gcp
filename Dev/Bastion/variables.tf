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