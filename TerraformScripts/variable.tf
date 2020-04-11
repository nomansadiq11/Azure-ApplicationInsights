

variable "resouce_group_name" {
  default = "rg-ApplicationInsights"
}

variable "location" {
  default = "west europe"
}


variable "tag" {
  default = "Dev/Test"
}


resource "random_integer" "ri" {
  min = 10000
  max = 99999
}


resource "random_string" "fqdn" {
    length  = 6
    special = false
    upper   = false
    number  = false
}