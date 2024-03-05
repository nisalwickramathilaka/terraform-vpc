variable "access_key" {
  type        = string
  default     = "AKIA5FTZDMNLEFIX5LPJ"
  description = "Access key of VPC"
}
variable "secret_key" {
  type        = string
  default     = "YtC2xTwPj1+nYLIY8fCpavntkV69JAVenXv+JLzu"
  description = "Secret key of VPC"
}
variable "region" {
  type        = string
  default     = "us-east-1"
  description = "Region of VPC"
}
variable "cidr_block" {
  type        = string
  default     = "10.0.0.0/16"
  description = "Ipv4 CIDR block "
}
variable "public_subnet_cidr_block" {
  type        = list
  default     = ["10.0.48.0/20","10.0.112.0/20","10.0.176.0/20"]
  description = "List of 3 public subnets"
}
variable "private_subnet_cidr_block" {
  type        = list
  default     = ["10.0.16.0/20","10.0.32.0/20","10.0.80.0/20","10.0.96.0/20","10.0.144.0/20","10.0.160.0/20"]
  description = "List of 6 private subnet"
}
variable "availability_zones" {
  type        = list
  default     = ["us-east-1a","us-east-1b","us-east-1c"]
  description = "Available zones of VPC"
}
