# Terraform - Network Edge and AWS

This repo will allow you to create an Equinix Network Edge device using a Cisco CSR1000V Small with the security package applied using Equinix provided licensing. 

Once created it will create the required Equinix Fabric virtual connection (VC) to AWS, where a private VIF and BGP peering will be created to peer with network edge.

The code is extensible based on your requirements for device sizing, license selection and virtual circuit bandwidth types.

All changes to variables can be done in the **variables.tf**

The code has been built to accept variables for the relevant components to configure the device, virtual circuit
and BGP session.

Please review the variables.tf file and created a terraform.tfvar file to input the required
variables. Which contains links to documentation to assist.

Key components required are:
- Device details such as hostname,
size, term length, license type and throughput
- Equinix Fabric vc size
- BGP details such as peering details (BGP) and networking information

- AWS details such as account id, access key id and secret key id ** please note best practice is to never embedded aws details into terraform files but use a reference to the local ~/.aws shared files but for the automation we will use the embedded method.



