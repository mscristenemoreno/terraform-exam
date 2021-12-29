output "azs" {
  description = "A list of availability zones specified as argument to this module"
  value       = module.vpc.azs
}
