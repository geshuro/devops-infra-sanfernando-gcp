// Google Cloud provider
provider "google-beta" {
  credentials = "${file("./gcloud-service-account.json")}"
  project     = "${var.project_id}"
  region      = "${var.region}"
}

provider "google" {
  credentials = "${file("./gcloud-service-account.json")}"
  project     = "${var.project_id}"
  region      = "${var.region}"
}

data "terraform_remote_state" "networking" {
  backend = "gcs"
  config = {
    bucket  = "${var.terraform_remote_state_bucket}"
    prefix  = "${var.terraform_remote_state_prefix}"
    credentials = "${file("./gcloud-service-account.json")}"
  }
  workspace = "networking"
}

data "terraform_remote_state" "api" {
  backend = "gcs"
  config = {
    bucket  = "${var.terraform_remote_state_bucket}"
    prefix  = "${var.terraform_remote_state_prefix}"
    credentials = "${file("./gcloud-service-account.json")}"
  }
  workspace = "api"
}

module "gce-lb-http" {
  source            = "../../Modules/terraform-google-lb-http"
  #source            = "../../"
  name              = "mig-http-lb"
  project           = var.project_id
  target_tags       = ["${data.terraform_remote_state.networking.outputs.network_name}"]
  firewall_networks = ["${data.terraform_remote_state.networking.outputs.network_name}"]


  backends = {
    default = { 
      description                     = null
      protocol                        = "HTTP"
      port                            = 80
      port_name                       = "http"
      timeout_sec                     = 10
      connection_draining_timeout_sec = null
      enable_cdn                      = false
      compression_mode                = null
      security_policy                 = null
      session_affinity                = null
      affinity_cookie_ttl_sec         = null
      custom_request_headers          = null
      custom_response_headers         = null

      health_check = {
        check_interval_sec  = null
        timeout_sec         = null
        healthy_threshold   = null
        unhealthy_threshold = null
        request_path        = "/"
        port                = 80
        host                = null
        logging             = null
      }

      log_config = {
        enable      = false
        sample_rate = null
      }

      groups = [
        {
          group                        = "${data.terraform_remote_state.api.outputs.instance_group}"
          #group                        = module.mig.instance_group
          balancing_mode               = null
          capacity_scaler              = null
          description                  = null
          max_connections              = null
          max_connections_per_instance = null
          max_connections_per_endpoint = null
          max_rate                     = null
          max_rate_per_instance        = null
          max_rate_per_endpoint        = null
          max_utilization              = null
        }
      ]

      iap_config = {
        enable               = false
        oauth2_client_id     = ""
        oauth2_client_secret = ""
      }
    }
  }
}
