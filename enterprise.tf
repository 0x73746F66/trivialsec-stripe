resource "stripe_product" "enterprise" {
  name     = "Enterprise Plan"
  type     = "service"
  metadata = {
    "On-demand Passive Domain Scans"  = "CUSTOM"
    "On-demand Active Domain Scans"   = "CUSTOM"
    "Domains Monitored"               = "CUSTOM"
    "Brand Protection"                = true
    "ThreatIntel"                     = true
    "Novel Vulnerabilities"           = true
    "Webhooks"                        = true
    # "IOC Feeds"                       = true
    # "SCA"                             = true
    # "SAST"                            = true
    "Compliance Reports"              = true
  }
}

output "enterprise" {
  value = stripe_product.enterprise.id
}
