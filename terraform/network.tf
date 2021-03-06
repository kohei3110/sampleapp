# VCN
resource "oci_core_vcn" "vcn" {
    cidr_block = var.vcn_cidr_block
    compartment_id = var.compartment_ocid
    display_name = var.vcn_display_name
    dns_label = var.vcn_dns_label
}

# Public Subnet
resource "oci_core_subnet" "public_subnet" {
  display_name        = var.public_subnet_display_name
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_vcn.vcn.id
  cidr_block          = var.public_subnet_cidr_block

  # To Do : add security list & route table
}

# Internet Gateway
resource "oci_core_internet_gateway" "internet_gateway" {
    compartment_id = var.compartment_ocid
    vcn_id = oci_core_vcn.vcn.id
    display_name = var.internet_gateway_display_name
    enabled = true
}

# NAT Gateway
resource "oci_core_nat_gateway" "nat_gateway" {
    # Required
    compartment_id = var.compartment_ocid
    vcn_id = oci_core_vcn.vcn.id

    # Optional
    display_name = var.nat_gateway_display_name
}
