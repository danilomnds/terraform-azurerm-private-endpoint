resource "azurerm_private_endpoint" "pvted" {
  name                          = var.name
  resource_group_name           = var.resource_group_name
  location                      = var.location
  subnet_id                     = var.subnet_id
  custom_network_interface_name = var.custom_network_interface_name
  dynamic "private_dns_zone_group" {
    for_each = var.private_dns_zone_group != null ? [var.private_dns_zone_group] : []
    content {
      name                 = private_dns_zone_group.value.name == null ? "default" : private_dns_zone_group.value.name
      private_dns_zone_ids = private_dns_zone_group.value.private_dns_zone_ids
    }
  }
  private_service_connection {
    name                           = var.private_service_connection.name == null ? "pvt-connection-${var.name}" : var.private_service_connection.name
    is_manual_connection           = var.private_service_connection.is_manual_connection
    private_connection_resource_id = var.private_service_connection.private_connection_resource_id
    subresource_names              = var.private_service_connection.subresource_names
  }
  dynamic "ip_configuration" {
    for_each = var.ip_configuration != null ? [var.ip_configuration] : []
    content {
      member_name        = ip_configuration.value.member_name
      name               = ip_configuration.value.name
      private_ip_address = ip_configuration.value.private_ip_address
      subresource_name   = ip_configuration.value.subresource_name
    }
  }
  tags = local.tags
  lifecycle {
    ignore_changes = [
      tags["create_date"]
    ]
  }
}