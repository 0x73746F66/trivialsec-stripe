variable "stripe_api_token" {
  description = "The stripe api key"
  type        = string
  sensitive   = true
}
variable "aws_secret_access_key" {
  description = "AWS_SECRET_ACCESS_KEY"
  type        = string
  sensitive   = true
}
