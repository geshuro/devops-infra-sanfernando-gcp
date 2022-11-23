terraform {
  backend "gcs" {
    bucket      = "sanfernando-dev-tfstate-dev-fcb5f37fb51df071c7f8"
    prefix      = "terrform/dev.tfstate"
    credentials = "sa.json"
  }
}
