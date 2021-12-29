resource "stripe_product" "std" {
  name     = "Standard Plan"
  type     = "service"
  metadata = {
    "On-demand Passive Domain Scans"  = "10/DAY"
    "On-demand Active Domain Scans"   = "1/DAY"
    "Domains Monitored"               = 1
    "Brand Protection"                = false
    "ThreatIntel"                     = true
    "Novel Vulnerabilities"           = true
    "Webhooks"                        = true
    # "IOC Feeds"                       = true
    # "SCA"                             = true
    # "SAST"                            = true
    "Compliance Reports"              = true
  }
}

resource "stripe_price" "std_plan_year" {
  product        = stripe_product.std.id
  currency       = local.currency
  unit_amount    = 23000
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

resource "stripe_price" "std_plan_month" {
  product     = stripe_product.std.id
  currency    = local.currency
  unit_amount = 2999
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

resource "stripe_coupon" "std_internal_free" {
  code            = "CARBONMAC"
  name            = "Internal Testing - Free Plan"
  duration        = "forever"       # forever, once, repeating
  # duration_in_months = 12
  percent_off     = 100
  max_redemptions = 1
  redeem_by       = "2022-06-30T12:59:00+11:00"
}

output "standard" {
  value = stripe_product.std.id
}

output "std_plan_year" {
  value = stripe_price.std_plan_year.id
}

output "std_plan_month" {
  value = stripe_price.std_plan_month.id
}

output "std_internal_free" {
  value = stripe_coupon.std_internal_free.id
}
