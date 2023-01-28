variable "name" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "subnet_id" {
  type = string
}

variable "custom_network_interface_name" {
  type    = string
  default = null
}

variable "private_dns_zone_group" {
  type = object({
    name                 = optional(string)
    private_dns_zone_ids = optional(list(string))
  })
  default = null
}

variable "private_service_connection" {
  type = object({
    name                              = optional(string)
    is_manual_connection              = optional(bool)
    private_connection_resource_id    = optional(string)
    private_connection_resource_alias = optional(string)
    subresource_names                 = optional(list(string))
    request_message                   = optional(string)
  })
  default = null
}

variable "ip_configuration" {
  type = object({
    name               = optional(string)
    private_ip_address = optional(string)
    subresource_name   = optional(string)
    member_name        = optional(string)
  })
  default = null
}

variable "tags" {
  type    = map(string)
  default = {}
}