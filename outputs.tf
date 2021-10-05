output "Device-Name" {
    value = equinix_network_device.customer-csr-api1.name
}

output "Device-UUID" {
    value = equinix_network_device.customer-csr-api1.uuid
}

output "AWS-Connection-Name" {
    value = data.aws_dx_connection.awsdx.name
}

output "AWS-VC-BW" {
    value = "${equinix_ecx_l2_connection.aws.speed} ${equinix_ecx_l2_connection.aws.speed_unit}"
}

output "BGP-CIDR" {
    value = equinix_network_bgp.customer-csr-api1.local_ip_address
}

output "Local-ASN" {
    value = equinix_network_bgp.customer-csr-api1.local_asn
}
output "Remote-ASN" {
    value = equinix_network_bgp.customer-csr-api1.remote_asn
}
output "BGP-Secret" {
    value = equinix_network_bgp.customer-csr-api1.authentication_key
    sensitive = true
}