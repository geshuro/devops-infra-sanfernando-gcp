terraform {
  backend "gcs" {
    bucket      = "sanfernando-id-desarrollo-tfstate-dev-974f5e2777751dffd9b5"
    prefix      = "terraform/dev.tfstate"
    credentials = "sa.json"
  }
}
