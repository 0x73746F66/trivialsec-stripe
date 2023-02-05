resource "stripe_product" "trial" {
  name     = "Free Trial"
  type     = "service"
  metadata = {
    "On-demand Passive Domain Scans"  = "10/DAY"
    "On-demand Active Domain Scans"   = "0/DAY"
    "Domains Monitored"               = 0
    "Brand Protection"                = false
    "ThreatIntel"                     = false
    "Novel Vulnerabilities"           = false
    "Webhooks"                        = false
    # "IOC Feeds"                       = false
    # "SCA"                             = false
    # "SAST"                            = false
    "Compliance Reports"              = false
  }
}

output "trial" {
  value = stripe_product.trial.id
}
