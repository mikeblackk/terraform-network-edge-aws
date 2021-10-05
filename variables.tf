# Equinix Variables

variable "metro_code" {
  description = "2 digit Equinix Metro code example: SY/SG/HK"
}
variable "equinix_client_id" {
  description = "Client ID from the Equinix developer portal at https://developer.equinix.com/"
}
variable "equinix_client_secret" {
  description = "Client Secret generated from the Equinix developer portal at https://developer.equinix.com/"
}

variable "equinixaccountname" {
  description = "Equinix account name from the Equinix Fabric portal"

}
variable "hostname" {
  description = "Hostname of device - max 10 characters"
}
variable "devicename" {
  description = "Device name in Equinix portal - max 10 characters"
}

variable "csr_package" {
  description = "CSR license for Network Edge - Suported Sec, Appx, IPBase and AX. Refer to documentation at https://docs.equinix.com/en-us/Content/Interconnection/NE/deploy-guide/Cisco/NE-Cisco-specs.htm"
  default     = "SEC"
}

variable "term_length" {
  description = "Length up to 36 months"
  default     = 1
}
variable "customer_email" {
  description = "Customer email for notifications"
}

variable "device_throughput" {
  description = "500, 1, 2.5, 5, 10 are accepted depending on the size of the network edge device. Review documentation for sizing at https://docs.equinix.com/en-us/Content/Interconnection/NE/deploy-guide/Cisco/NE-Cisco-specs.htm"
  default     = 500
}
variable "device_throughput_unit" {
  description = "Mbps or Gbps are only accepted"
  default     = "Mbps"
}

variable "ne_local_ip" {
  description = "BGP peering address in /30 notation"
}

variable "ne_local_asn" {
  description = "Local BGP ASN"
}

variable "ne_remote_ip" {
  description = "Remote IP of BGP peer. This is usually the .2 from the local CIDR provided"
}

variable "ne_remote_asn" {
  description = "Remote ASN for BGP peer - default for AWS DX Gateway is 64512"
  default     = 64512
}

variable "bgpauthkey" {
  description = "BGP Authenication Key for the session"
}

variable "equinix_fabric_vc_speed" {
  description = "Equinix Fabric virtual circuit size throughput - 50, 100, 200, 500, 1, 2, 5 and 10 are accepted. Please Review documentation of device specs to ensure higher virtual circuits are supported."
  default     = 50
}

variable "equinix_fabric_vc_speed_unit" {
  description = "Equinix Fabric virtual circuit speed unit - Mb or Gb"
  default     = "Mb"
}

# AWS Variables

variable "aws_accountid" {
  description = "AWS Account ID"
}
variable "aws_access_key_id" {
  description = "AWS Access Key ID"
}
variable "aws_secret_access_key" {
  description = "AWS Secret Access Key"
}
variable "aws_region" {
  description = "AWS Region to deploy direct connect"
}