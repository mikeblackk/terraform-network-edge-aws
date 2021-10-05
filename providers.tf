terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
    equinix = {
      source  = "equinix/equinix"
      version = "1.2.0"
    }
  }
}

provider "equinix" {
  client_id     = var.equinix_client_id
  client_secret = var.equinix_client_secret
}

provider "aws" {
  access_key = var.aws_access_key_id
  secret_key = var.aws_secret_access_key
  region     = var.aws_region
}

data "equinix_ecx_l2_sellerprofile" "aws" {
  name = "AWS Direct Connect"
}

# Equinix Billing Account Lookup

data "equinix_network_account" "customer-csr-api1" {
  metro_code = var.metro_code
  status     = "Active"
  name       = var.equinixaccountname
}

# Equinix Network Edge Device Availabiliy Lookup

data "equinix_network_device_type" "customer-csr-api1" {
  category    = "Router"
  vendor      = "Cisco"
  metro_codes = [data.equinix_network_account.customer-csr-api1.metro_code]
}

data "equinix_network_device_software" "customer-csr-api1" {
  device_type   = data.equinix_network_device_type.customer-csr-api1.code
  version_regex = "^16.09.+"
  packages      = [var.csr_package]
  most_recent   = true
}

data "equinix_network_device_platform" "customer-csr-api1" {
  device_type = data.equinix_network_device_type.customer-csr-api1.code
  flavor      = "small"
}


# AWS Data Source Lookup
data "aws_dx_connection" "awsdx" {
  name = local.equinixid_aws
  depends_on = [
    equinix_network_bgp.customer-csr-api1
  ]
}