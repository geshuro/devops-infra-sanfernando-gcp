terraform {
  backend "gcs" {
    bucket      = "sanfernando-id-desarrollo-tfstate-dev-e08fa5cb60758852ac89"
    prefix      = "terraform/dev.tfstate"
    credentials = "gcloud-service-account.json"
  }
}