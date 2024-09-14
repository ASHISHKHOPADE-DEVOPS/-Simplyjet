# Cloudflare Provider for API integration
provider "cloudflare" {
  email   = "your-email"  # Replace with your Cloudflare email
  api_key = "your-api-key"  # Replace with your Cloudflare API key
}

# Add the Cloudflare zone (your domain must already exist in Cloudflare)
resource "cloudflare_zone" "my_zone" {
  zone = "yourdomain.com"
}

# Proxy DNS records via Cloudflare for security and caching
resource "cloudflare_record" "www" {
  zone_id = cloudflare_zone.my_zone.id
  name    = "www"
  value   = aws_lb.my_lb.dns_name  # Use AWS resource DNS (e.g., ELB)
  type    = "A"
  proxied = true  # Enable Cloudflare proxying for performance and security
  ttl     = 300
}

# Add Cloudflare CNAME for API subdomain
resource "cloudflare_record" "api" {
  zone_id = cloudflare_zone.my_zone.id
  name    = "api"
  value   = aws_route53_record.api.fqdn
  type    = "CNAME"
  proxied = true
  ttl     = 300
}
