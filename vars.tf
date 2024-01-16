variable "default_tags" {
  type = map(string)
  default = {
    "env" = "jdesjardins"
  }
  description = "owners name"  
}
variable "public_subnet_count" {
    type = number
    description = "avoiding conflict"
    default = 2
}

