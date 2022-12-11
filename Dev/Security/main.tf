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

#------------------------------------
# Security Policies for Cloud Armor
#-------------------------------------
resource "google_compute_security_policy" "policy" {
  name = var.name
  project = var.project_id
  description = var.description
  type = var.type

#------------------------------------
# For Default Allow Rule
#-------------------------------------
  dynamic "rule" {
    for_each = var.default_rules
    content {
      action   = rule.value.action
      priority = rule.value.priority
      match {
        versioned_expr = rule.value.versioned_expr
        config {
            src_ip_ranges = rule.value.src_ip_ranges
        }
      }
      description = rule.value.description
    }
  }

#------------------------------------
# For OWASP TOP Rule
#-------------------------------------
  dynamic "rule" {
    for_each = var.owasp_rules
    content {
      action   = rule.value.action
      priority = rule.value.priority
      match {
        expr {
            expression = rule.value.expression
        }
      }
      description = rule.value.description
    }
  }

#------------------------------------
# For Apache Log4j Block Rule
#-------------------------------------
  dynamic "rule" {
    for_each = var.apache_log4j_rule
    content {
      action   = rule.value.action
      priority = rule.value.priority
      match {
        expr {
            expression = rule.value.expression
        }
      }
      description = rule.value.description
    }
  }

#------------------------------------
# For Region Rule
#-------------------------------------
  dynamic "rule" {
    for_each = var.region_specific_allow_rule
    content {
      action   = rule.value.action
      priority = rule.value.priority
      match {
        expr {
            expression = rule.value.expression
        }
      }
      description = rule.value.description
    }
  }

  dynamic "rule" {
    for_each = var.region_specific_deny_rule
    content {
      action   = rule.value.action
      priority = rule.value.priority
      match {
        expr {
            expression = rule.value.expression
        }
      }
      description = rule.value.description
    }
  }

}