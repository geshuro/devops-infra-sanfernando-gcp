output "id" {
  description = "An identifier for the resource with format projects/{{project}}/global/securityPolicies/{{name}}"
  value = google_compute_security_policy.policy.id
}

output "fingerprint" {
  description = "Fingerprint of this resource"
  value = google_compute_security_policy.policy.fingerprint
}

output "self_link" {
  description = "The URI of the created resource"
  value = google_compute_security_policy.policy.self_link
}