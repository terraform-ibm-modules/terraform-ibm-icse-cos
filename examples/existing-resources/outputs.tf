##############################################################################
# Outputs
##############################################################################

output "vpc_id" {
  description = "ID of the existing VPC"
  value       = data.ibm_is_vpc.example.id
}
