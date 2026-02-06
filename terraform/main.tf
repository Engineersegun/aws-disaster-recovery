# 1. Create the Health Check for the Primary Server
resource "aws_route53_health_check" "primary_health" {
  fqdn              = "primary.yourdomain.com"
  port              = 80
  type              = "HTTP"
  resource_path     = "/health"
  failure_threshold = "3"
  request_interval  = "30"

  tags = {
    Name = "primary-site-health-check"
  }
}

# 2. Primary Record (High Priority - 100% Traffic by default)
resource "aws_route53_record" "primary" {
  zone_id = "YOUR_HOSTED_ZONE_ID" # Replace with your actual Hosted Zone ID
  name    = "app.yourdomain.com"
  type    = "A"
  ttl     = "60"

  failover_routing_policy {
    type = "PRIMARY"
  }

  set_identifier = "primary-endpoint"
  records        = ["1.2.3.4"] # Replace with your Primary Server Public IP
  health_check_id = aws_route53_health_check.primary_health.id
}

# 3. Secondary Record (Disaster Recovery - 0% Traffic unless Primary fails)
resource "aws_route53_record" "secondary" {
  zone_id = "YOUR_HOSTED_ZONE_ID" # Replace with your actual Hosted Zone ID
  name    = "app.yourdomain.com"
  type    = "A"
  ttl     = "60"

  failover_routing_policy {
    type = "SECONDARY"
  }

  set_identifier = "secondary-endpoint"
  records        = ["5.6.7.8"] # Replace with your DR Server Public IP
}
