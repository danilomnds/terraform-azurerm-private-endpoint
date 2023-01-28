# Module - Private Endpoint
[![COE](https://img.shields.io/badge/Created%20By-CCoE-blue)]()
[![HCL](https://img.shields.io/badge/language-HCL-blueviolet)](https://www.terraform.io/)
[![Azure](https://img.shields.io/badge/provider-Azure-blue)](https://registry.terraform.io/providers/hashicorp/azurerm/latest)

Module developed to standardize the Private Endpoint creation.

## Compatibility Matrix

| Module Version | Terraform Version | AzureRM Version |
|----------------|-------------------| --------------- |
| v1.0.0         | v1.3.6            | 3.37.0          |

## Specifying a version

To avoid that your code get updates automatically, is mandatory to set the version using the `source` option. 
By defining the `?ref=***` in the the URL, you can define the version of the module.

Note: The `?ref=***` refers a tag on the git module repo.

## Use case
```hcl
module "pvted-<pvted name>" {
  source                         = "git::https://github.com/danilomnds/terraform-azurerm-private-endpoint?ref=v1.0.0"
  name                           = "<pvted-name>"
  location                       = "<region>"
  resource_group_name            = "<rg-name>"
  subnet_id                      = "<subnet_id>"
  private_dns_zone_group = {
    private_dns_zone_ids = ["<list of private dns zone ids>"]
  }
  private_service_connection = {
    private_connection_resource_id = <resource id that will be linked to this pvted>
    subresource_names = ["<resource type>"]
    is_manual_connection = <connection type default = false>
  }  
  tags = {
    "key1" = "value1"
    "key2" = "value2"    
  }
}
output "pvted_name" {
  value = module.pvted-<pvted name>.name
}
```

## Input variables

For object variables, please check the documentation on terraform.io. All variables for the blocks: private_dns_zone_group, private_service_connection and ip_configuration can be definided (please check the AzureRM used).

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| name | private endpoint name | `string` | n/a | `Yes` |
| resource_group_name | resource group where the private endpoint will be created | `string` | n/a | `Yes` |
| location | azure region | `string` | n/a | `Yes` |
| subnet_id | the id of the subnet from which private ip addresses will be allocated for this private endpoint | `string` | n/a | `Yes` |
| custom_network_interface_name | he custom name of the network interface attached to the private endpoint | `string` | `null` | No |
| private_dns_zone_group | block used to specify the privated dns zone used for the pvted | `object()` | `null` | No |
| private_service_connection | block used to specify the privated service connection | `object()` | `null` | `Yes` |
| ip_configuration | block used to configure the ip options | `object()` | `null` | No |
| tags | tags for the resource | `map(string)` | `{}` | No

## Output variables

| Name | Description |
|------|-------------|
| name | private endpoint name |

## Documentation
Terraform Private Endpoint: <br>
[https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint)