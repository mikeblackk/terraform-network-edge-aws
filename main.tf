locals {
  equinixid_aws = join("-", ["${data.equinix_network_account.customer-csr-api1.number}", "AWS-VC1"])
}
resource "equinix_network_device" "customer-csr-api1" {
  name            = var.devicename
  hostname        = var.hostname
  throughput      = var.device_throughput
  throughput_unit = join("", [upper(substr(var.device_throughput_unit, 0, 1)), lower(substr(var.device_throughput_unit, 1, 5))])
  metro_code      = data.equinix_network_account.customer-csr-api1.metro_code
  type_code       = data.equinix_network_device_type.customer-csr-api1.code
  package_code    = upper(var.csr_package)
  notifications   = [var.customer_email]
  term_length     = var.term_length
  account_number  = data.equinix_network_account.customer-csr-api1.number
  version         = data.equinix_network_device_software.customer-csr-api1.version
  core_count      = data.equinix_network_device_platform.customer-csr-api1.core_count
}

resource "equinix_ecx_l2_connection" "aws" {
  name                = local.equinixid_aws
  profile_uuid        = data.equinix_ecx_l2_sellerprofile.aws.id
  speed               = var.equinix_fabric_vc_speed
  speed_unit          = upper(var.equinix_fabric_vc_speed_unit)
  notifications       = [var.customer_email]
  device_uuid         = equinix_network_device.customer-csr-api1.id
  authorization_key   = var.aws_accountid
  seller_metro_code   = var.metro_code
  seller_region       = var.aws_region
  device_interface_id = 9
}

resource "equinix_ecx_l2_connection_accepter" "aws" {
  connection_id = equinix_ecx_l2_connection.aws.id
  access_key    = var.aws_access_key_id
  secret_key    = var.aws_secret_access_key
}

resource "equinix_network_bgp" "customer-csr-api1" {
  connection_id      = equinix_ecx_l2_connection.aws.id
  local_ip_address   = var.ne_local_ip
  local_asn          = var.ne_local_asn
  remote_ip_address  = var.ne_remote_ip
  remote_asn         = var.ne_remote_asn
  authentication_key = var.bgpauthkey
}

resource "aws_dx_private_virtual_interface" "eqx-dx-privatevif" {
  connection_id    = data.aws_dx_connection.awsdx.id
  name             = "${local.equinixid_aws}-PVIF"
  vlan             = equinix_ecx_l2_connection.aws.zside_vlan_stag
  address_family   = "ipv4"
  bgp_asn          = var.ne_local_asn
  dx_gateway_id    = aws_dx_gateway.equinix-dx-gateway.id
  amazon_address   = "${var.ne_remote_ip}/30"
  customer_address = var.ne_local_ip
  bgp_auth_key     = var.bgpauthkey
  depends_on = [
    equinix_network_bgp.customer-csr-api1
  ]
}

resource "aws_dx_gateway" "equinix-dx-gateway" {
  name            = "${local.equinixid_aws}-EQX-DXGW"
  amazon_side_asn = var.ne_remote_asn
}

