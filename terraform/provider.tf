terraform {
  required_version = ">= 1.0.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  # You can change this to your preferred region (e.g., us-east-1, eu-west-1)
  region = "us-east-1" 
  
  default_tags {
    tags = {
      Project     = "AWS-Disaster-Recovery"
      Environment = "Production"
      ManagedBy   = "Terraform"
    }
  }
}
