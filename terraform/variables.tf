variable "hosted_zone_id" {
  description = "The Route 53 Hosted Zone ID"
  type        = string
  default     = "Z0123456789ABCDEF" # Replace with your ID
}

variable "domain_name" {
  description = "The domain name for the application"
  type        = string
  default     = "app.yourdomain.com"
}

variable "primary_ip" {
  description = "Public IP of the primary server"
  type        = string
  default     = "1.2.3.4"
}

variable "secondary_ip" {
  description = "Public IP of the disaster recovery server"
  type        = string
  default     = "5.6.7.8"
}
