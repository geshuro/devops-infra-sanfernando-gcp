variable "bucket_name" {
  description = "(Optional) the name of the bucket"
  default     = null
}

variable "project_name" {
  description = "The name of Project"
  default     = "sanfernando-id-desarrollo"
}

variable "project_id" {
  description = "The ID of the project in which the resource belongs. If it is not provided, the provider project is used."
  default     = "sanfernando-id-desarrollo"
}

variable "environment" {
  type        = string
  description = "Tipo de entorno (dev, test, pre, pro)"
  default     = "dev"
}

variable "region" {
  type        = string
  description = "Backend region of remote state for terraform"
  default     = "us-central1"
}

variable "prefix" {
  description = "The name of the Blob used to retrieve/store Terraform's State file inside the Storage Container."
  default     = "terrform/dev.tfstate"
}

variable "backend_output_path" {
  default     = "./backend.tf"
  description = "The default file to output backend configuration to"
}

variable "force_destroy" {
  description = "Whether to force destroy the bucket and all it's contents"
  default     = false
}

variable "labels" {
  description = "A set of key/value label pairs to assign to the bucket."
  default     = null
}

variable "enable_versioning" {
  description = "Enable Bucket versioning"
  default     = true
}

variable "owner" {
  type        = string
  description = "User id of GCP account"
  default     = "isaac.mendoza.huamani@gmail.com"
}

variable "costcenter" {
  type        = string
  description = "Centro de coste aplicado a la cuenta, servicio o proyecto provisto por la empresa"
  default     = "SANFER"
}

variable "costcenterid" {
  type        = string
  description = "Centro de coste aplicado a la cuenta, servicio o proyecto provisto por uuid 4"
  default     = "SANFER"
}

variable "serviceid" {
  type        = string
  description = "Identificador unico de servicio provisto por uuid4"
  default     = "SANFER-ARQ"
}