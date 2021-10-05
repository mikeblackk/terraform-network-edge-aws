# Terraform - Network Edge and AWS.

This repo will allow you to create an Equinix Network Edge device using a Cisco CSR1000V Small with the security package applied using Equinix provided licensing. 

Once created it will create the required Equinix Fabric virtual connection (VC) to AWS, where a private VIF and BGP peering will be created to peer with network edge.

The code is extensive based on your requirements for device sizing, license selection and virtual circuit bandwidth types.

All changes to variables can be done in the **variables.tf**

The following information is required:
- Equinix API Details available from your account at developer.equinix.com
- AWS credentials which are available from your API details ** Please Note: best practise is to never embedded AWS credentials into code, please use the shared file resource method available at: 
