resource "stripe_webhook_endpoint" "appserver" {
  url            = "${local.webhook_base}/webhook/stripe"
  enabled_events = [ # https://stripe.com/docs/api/events/types
    "payment_intent.succeeded",
    "invoice.paid",
    "invoice.updated",
    "invoice.payment_succeeded",
    "invoice.payment_failed",
    "customer.subscription.deleted",
    "customer.subscription.created"
  ]
}

resource "stripe_webhook_endpoint" "logs" {
  url            = "${local.webhook_base}/webhook/stripe-log"
  enabled_events = ["*"]
}

output "webhook_appserver_id" {
  value = stripe_webhook_endpoint.appserver.id
}

output "webhook_logs_id" {
  value = stripe_webhook_endpoint.logs.id
}
