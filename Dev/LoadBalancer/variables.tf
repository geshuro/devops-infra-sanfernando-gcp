variable "region" {
  default = "us-west1"
}

variable "zona" {
  default = "us-west1-b"
}

variable "project_id" {
  type = string
}

variable "terraform_remote_state_bucket" {
  type    = string
  default = "sanfernando-dev-tfstate-dev-fcb5f37fb51df071c7f8"
}

variable "terraform_remote_state_prefix" {
  type    = string
  default = "terrform/dev.tfstate"
}