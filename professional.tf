resource "stripe_product" "pro" {
  name     = "Professional Plan"
  type     = "service"
  metadata = {
    "On-demand Passive Domain Scans"  = "500/DAY"
    "On-demand Active Domain Scans"   = "50/DAY"
    "Domains Monitored"               = 10
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

resource "stripe_price" "pro_plan_year" {
  product     = stripe_product.pro.id
  unit_amount = 155400
  currency    = local.currency
  billing_scheme = "per_unit"
  metadata       = {}
  recurring = {
    interval = "year"
    interval_count = 1
  }    
  lifecycle {
      prevent_destroy = true
  }
}

resource "stripe_price" "pro_plan_month" {
  product     = stripe_product.pro.id
  unit_amount = 18500
  currency    = local.currency
  billing_scheme = "per_unit"
  metadata       = {}
  recurring = {
    interval = "month"
    interval_count = 1
  }
  lifecycle {
      prevent_destroy = true
  }
}

resource "stripe_coupon" "beta_testers_free" {
  code                = "BETA2022"
  name                = "2022 Beta Testers - invite only"
  duration            = "repeating"
  duration_in_months  = 12
  percent_off         = 100
  max_redemptions     = 5
  redeem_by           = "2022-06-30T12:59:00+11:00"
}

resource "stripe_coupon" "pro_internal_free" {
  code            = "CARBONMAC"
  name            = "Internal Testing - Free Plan"
  duration        = "forever"       # forever, once, repeating
  # duration_in_months = 12
  percent_off     = 100
  max_redemptions = 1
  redeem_by       = "2022-06-30T12:59:00+11:00"
}

output "professional" {
  value = stripe_product.pro.id
}

output "pro_plan_year" {
  value = stripe_price.pro_plan_year.id
}

output "pro_plan_month" {
  value = stripe_price.pro_plan_month.id
}

output "pro_beta_testers_free" {
  value = stripe_coupon.beta_testers_free.id
}

output "pro_internal_free" {
  value = stripe_coupon.pro_internal_free.id
}
