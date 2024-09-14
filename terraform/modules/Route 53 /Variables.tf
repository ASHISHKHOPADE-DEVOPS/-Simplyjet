variable "domain_name" {
  description = "Domain name for Route 53 hosted zone"
  type        = string
  default     = "yourdomain.com"
}

variable "cloudflare_email" {
  description = "Email address for Cloudflare API"
  type        = string
}

variable "cloudflare_api_key" {
  description = "API key for Cloudflare"
  type        = string
}

output "route53_zone_id" {
  description = "Route 53 Hosted Zone ID"
  value       = aws_route53_zone.my_domain.zone_id
}
