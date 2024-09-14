# Route 53 Hosted Zone for your domain
resource "aws_route53_zone" "my_domain" {
  name = "yourdomain.com"  # Replace with your domain name
}

# A record to route traffic to AWS Load Balancer or other resources
resource "aws_route53_record" "www" {
  zone_id = aws_route53_zone.my_domain.zone_id
  name    = "www"
  type    = "A"
  ttl     = "300"
  # Replace with your resource (e.g., AWS ELB, S3, etc.)
  records = [aws_lb.my_lb.dns_name]
}

# CNAME record for a subdomain to route traffic to a resource
resource "aws_route53_record" "api" {
  zone_id = aws_route53_zone.my_domain.zone_id
  name    = "api"
  type    = "CNAME"
  ttl     = "300"
  records = ["api.yourdomain.com"]
}
