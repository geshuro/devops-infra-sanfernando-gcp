variable "project_id" {
  description = "The project ID"
}

variable "region" {
  type        = string
  description = "Region"
  default     = "us-east1"
}

variable "name" {
  type        = string
  description = "Name policy"
  default     = "Policy"
}

variable "description" {
  type        = string
  description = "An optional description of this security policy. Max size is 2048."
  default     = ""
}

variable "type" {
  type        = string
  description = ""
  default     = "CLOUD_ARMOR"
}

variable "default_rules" {
  description = "Default rule"
  default = {
    def_rule = {
      action          = "allow"
      priority        = "2147483647"
      versioned_expr  = "SRC_IPS_V1"
      src_ip_ranges   = ["*"]
      description     = "Default rule"
    }
  }
  type = map(object({
    action          = string
    priority        = string
    versioned_expr  = string
    src_ip_ranges   = list(string)
    description     = string
  }))
}

#------------------------------------
# OWASP TOP-10 Rule
#-------------------------------------
variable "owasp_rules" {
  description = "Rules preconfigured from owasp top 10 for cloud armour protection"
  default = {
    rule_sqli = {
      action      = "deny(403)"
      priority    = "1000"
      expression  = <<EOF
        evaluatePreconfiguredExpr('sqli-stable', ['owasp-crs-v030001-id942110-sqli',
          'owasp-crs-v030001-id942120-sqli',
          'owasp-crs-v030001-id942150-sqli',
          'owasp-crs-v030001-id942180-sqli',
          'owasp-crs-v030001-id942200-sqli',
          'owasp-crs-v030001-id942210-sqli',
          'owasp-crs-v030001-id942260-sqli',
          'owasp-crs-v030001-id942300-sqli',
          'owasp-crs-v030001-id942310-sqli',
          'owasp-crs-v030001-id942330-sqli',
          'owasp-crs-v030001-id942340-sqli',
          'owasp-crs-v030001-id942380-sqli',
          'owasp-crs-v030001-id942390-sqli',
          'owasp-crs-v030001-id942400-sqli',
          'owasp-crs-v030001-id942410-sqli',
          'owasp-crs-v030001-id942430-sqli',
          'owasp-crs-v030001-id942440-sqli',
          'owasp-crs-v030001-id942450-sqli',
          'owasp-crs-v030001-id942251-sqli',
          'owasp-crs-v030001-id942420-sqli',
          'owasp-crs-v030001-id942431-sqli',
          'owasp-crs-v030001-id942460-sqli',
          'owasp-crs-v030001-id942421-sqli',
          'owasp-crs-v030001-id942432-sqli',
          'owasp-crs-v030001-id942190-sqli']
        )
        EOF
      description = "Prevent sql injection attacks"
    }

    rule_xss = {
      action      = "deny(403)"
      priority    = "1001"
      expression  = <<EOF
        evaluatePreconfiguredExpr('xss-stable', ['owasp-crs-v030001-id941340-xss',
          'owasp-crs-v030001-id941130-xss',
          'owasp-crs-v030001-id941170-xss',
          'owasp-crs-v030001-id941330-xss',
        ]
        )
        EOF
      description = "Prevent cross site scripting attacks"
    }

    rule_lfi = {
      action      = "deny(403)"
      priority    = "1002"
      expression  = "evaluatePreconfiguredExpr('lfi-stable')"
      description = "Prevent "
    }

    rule_canary = {
      action      = "deny(403)"
      priority    = "1003"
      expression  = "evaluatePreconfiguredExpr('rce-stable')"
      description = "Prevent "
    }

    rule_rfi = {
      action      = "deny(403)"
      priority    = "1004"
      expression  = <<EOF
        evaluatePreconfiguredExpr('rfi-stable', ['owasp-crs-v030001-id931130-rfi',
        ]
        )
        EOF
      description = "Prevent "
    }

    rule_methodenforcement = {
      action      = "deny(403)"
      priority    = "1005"
      expression  = "evaluatePreconfiguredExpr('methodenforcement-stable')"
      description = "Prevent "
    }

    rule_scandetection = {
      action      = "deny(403)"
      priority    = "1006"
      expression  = <<EOF
        evaluatePreconfiguredExpr('scannerdetection-stable', ['owasp-crs-v030001-id913101-scannerdetection',
          'owasp-crs-v030001-id913102-scannerdetection',
        ]
        )
        EOF
      description = "Prevent "
    }

    rule_protocolattach = {
      action      = "deny(403)"
      priority    = "1007"
      expression  = <<EOF
        evaluatePreconfiguredExpr('protocolattack-stable', ['owasp-crs-v030001-id921151-protocolattack',
          'owasp-crs-v030001-id921170-protocolattack',
        ]
        )
        EOF
      description = "Prevent "
    }

    rule_sessionfixation = {
      action      = "deny(403)"
      priority    = "1008"
      expression  = "evaluatePreconfiguredExpr('sessionfixation-stable')"
      description = "Prevent "
    }
  }
  type = map(object({
    action      = string
    priority    = string
    expression  = string
    description = string
  }))
}


#------------------------------------
# Apache Log4j Block Rule
#-------------------------------------
variable "apache_log4j_rule" {
  description = "Apache log4j rule"
  default = {
    rule_apache_log4j = {
      action          = "deny(403)"
      priority        = "1012"
      expression      = "evaluatePreconfiguredExpr('cve-canary')"
      description     = "Apache Log4j CVE-2021-44228 rule"
    }
  }
  type = map(object({
    action          = string
    priority        = string
    expression      = string
    description     = string
  }))
}


#------------------------------------
# Region Specific Access
#-------------------------------------
variable "region_specific_allow_rule" {
  description = "Region specific allow rule"
  default = {
    rule_allow = {
      action          = "allow"
      priority        = "0"
      expression      = "origin.region_code == 'PE'"
      description     = "Allowing access from only PE region"
    }
  }
  type = map(object({
    action          = string
    priority        = string
    expression      = string
    description     = string
  }))
}

variable "region_specific_deny_rule" {
  description = "Region specific deny rule"
  default = {
    rule_allow = {
      action          = "deny(403)"
      priority        = "1"
      expression      = "origin.region_code != 'CL'"
      description     = "Denying access from other than CL region"
    }
  }
  type = map(object({
    action          = string
    priority        = string
    expression      = string
    description     = string
  }))
}

#------------------------------------
# Security Response Headers
#-------------------------------------
variable "security_response_headers" {
  description = "Security headers to send in all responses"
  default = ["X-Content-Type-Options: nosniff"]
  type = list(string)
}

#------------------------------------
# IAP specific variables
#-------------------------------------
variable "google-iap-client-id" {
  type = string
  default = ""
}

variable "google-iap-client-secret" {
  type = string
  default = ""
}