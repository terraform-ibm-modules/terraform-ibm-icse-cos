<!-- BEGIN MODULE HOOK -->

<!-- Update the title to match the module name and add a description -->
# Terraform IBM ICSE Cloud Object Storage Module

<!-- UPDATE BADGE: Update the link for the badge below-->
[![Build Status](https://github.com/terraform-ibm-modules/terraform-ibm-module-template/actions/workflows/ci.yml/badge.svg)](https://github.com/terraform-ibm-modules/terraform-ibm-module-template/actions/workflows/ci.yml)
[![semantic-release](https://img.shields.io/badge/%20%20%F0%9F%93%A6%F0%9F%9A%80-semantic--release-e10079.svg)](https://github.com/semantic-release/semantic-release)
[![pre-commit](https://img.shields.io/badge/pre--commit-enabled-brightgreen?logo=pre-commit&logoColor=white)](https://github.com/pre-commit/pre-commit)

This module creates Cloud Object Storage instances, buckets, and resource keys. It also supports can create service-to-service authorizations dynamically to allow encryption of Cloud Object Storage instances by IBM Key Protect or Hyper Protect Crypto Services.

## Usage

```terraform
module cos {
  source                      = "github.com/terraform-ibm-modules/terraform-ibm-icse-cos"
  region                      = "us-south"
  prefix                      = "my-prefix"
  tags                        = var.tags
  use_random_suffix           = ["icse", "cloud-services"]
  service_endpoints           = "public"
  cos                         = [
    {
        name = "my-cos-instance"
    }
  ]
}
```
<!-- END MODULE HOOK -->
<!-- BEGIN EXAMPLES HOOK -->
## Examples

- [Examples](examples)
<!-- END EXAMPLES HOOK -->

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >=1.3.0 |
| <a name="requirement_ibm"></a> [ibm](#requirement\_ibm) | >=1.43.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | 3.4.3 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_cos_bucket_map"></a> [cos\_bucket\_map](#module\_cos\_bucket\_map) | ./config_modules/nested_list_to_map_and_merge | n/a |
| <a name="module_cos_key_map"></a> [cos\_key\_map](#module\_cos\_key\_map) | ./config_modules/nested_list_to_map_and_merge | n/a |
| <a name="module_cos_to_key_management"></a> [cos\_to\_key\_management](#module\_cos\_to\_key\_management) | ./config_modules/list_to_map | n/a |
| <a name="module_encryption_key_map"></a> [encryption\_key\_map](#module\_encryption\_key\_map) | ./config_modules/list_to_map | n/a |

## Resources

| Name | Type |
|------|------|
| [ibm_cos_bucket.bucket](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/cos_bucket) | resource |
| [ibm_iam_authorization_policy.policy](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/iam_authorization_policy) | resource |
| [ibm_resource_instance.cos](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/resource_instance) | resource |
| [ibm_resource_key.key](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/resource_key) | resource |
| [random_string.random_cos_suffix](https://registry.terraform.io/providers/hashicorp/random/3.4.3/docs/resources/string) | resource |
| [ibm_resource_instance.cos](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/data-sources/resource_instance) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cos"></a> [cos](#input\_cos) | Object describing the cloud object storage instance, buckets, and keys. Set `use_data` to false to create instance | <pre>list(<br>    object({<br>      name              = string<br>      use_data          = optional(bool)<br>      resource_group_id = optional(string)<br>      plan              = optional(string)<br>      buckets = list(object({<br>        name                  = string<br>        storage_class         = string<br>        endpoint_type         = string<br>        force_delete          = bool<br>        single_site_location  = optional(string)<br>        region_location       = optional(string)<br>        cross_region_location = optional(string)<br>        kms_key               = optional(string)<br>        allowed_ip            = optional(list(string))<br>        hard_quota            = optional(number)<br>        archive_rule = optional(object({<br>          days    = number<br>          enable  = bool<br>          rule_id = optional(string)<br>          type    = string<br>        }))<br>        activity_tracking = optional(object({<br>          activity_tracker_crn = string<br>          read_data_events     = bool<br>          write_data_events    = bool<br>        }))<br>        metrics_monitoring = optional(object({<br>          metrics_monitoring_crn  = string<br>          request_metrics_enabled = optional(bool)<br>          usage_metrics_enabled   = optional(bool)<br>        }))<br>      }))<br>      keys = optional(<br>        list(object({<br>          name        = string<br>          role        = string<br>          enable_HMAC = bool<br>        }))<br>      )<br><br>    })<br>  )</pre> | <pre>[<br>  {<br>    "buckets": [<br>      {<br>        "endpoint_type": "public",<br>        "force_delete": true,<br>        "kms_key": "at-test-atracker-key",<br>        "name": "atracker-bucket",<br>        "storage_class": "standard"<br>      }<br>    ],<br>    "keys": [<br>      {<br>        "enable_HMAC": false,<br>        "name": "cos-bind-key",<br>        "role": "Writer"<br>      }<br>    ],<br>    "name": "atracker-cos",<br>    "plan": "standard",<br>    "random_suffix": true,<br>    "resource_group": "at-test-service-rg",<br>    "use_data": false<br>  },<br>  {<br>    "buckets": [<br>      {<br>        "endpoint_type": "public",<br>        "force_delete": true,<br>        "kms_key": "at-test-slz-key",<br>        "name": "management-bucket",<br>        "storage_class": "standard"<br>      },<br>      {<br>        "endpoint_type": "public",<br>        "force_delete": true,<br>        "kms_key": "at-test-slz-key",<br>        "name": "workload-bucket",<br>        "storage_class": "standard"<br>      },<br>      {<br>        "endpoint_type": "public",<br>        "force_delete": true,<br>        "kms_key": "at-test-slz-key",<br>        "name": "bastion-bucket",<br>        "storage_class": "standard"<br>      }<br>    ],<br>    "keys": [<br>      {<br>        "enable_HMAC": true,<br>        "name": "bastion-key",<br>        "role": "Writer"<br>      }<br>    ],<br>    "name": "cos",<br>    "plan": "standard",<br>    "random_suffix": true,<br>    "resource_group": "at-test-service-rg",<br>    "use_data": false<br>  }<br>]</pre> | no |
| <a name="input_key_management_keys"></a> [key\_management\_keys](#input\_key\_management\_keys) | List of key management keys from key\_management module | <pre>list(<br>    object({<br>      shortname = string<br>      name      = string<br>      id        = string<br>      crn       = string<br>      key_id    = string<br>    })<br>  )</pre> | `[]` | no |
| <a name="input_key_management_service_guid"></a> [key\_management\_service\_guid](#input\_key\_management\_service\_guid) | OPTIONAL - GUID of the Key Management Service to use for COS bucket encryption. | `string` | `null` | no |
| <a name="input_key_management_service_name"></a> [key\_management\_service\_name](#input\_key\_management\_service\_name) | OPTIONAL - Type of key management service to use for COS bucket encryption. Service authorizations will be added only if the GUID is not null. | `string` | `null` | no |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | The prefix that you would like to append to your resources | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | The region to which to deploy the VPC | `string` | n/a | yes |
| <a name="input_service_endpoints"></a> [service\_endpoints](#input\_service\_endpoints) | Service endpoints. Can be `public`, `private`, or `public-and-private` | `string` | `"private"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | List of Tags for the resource created | `list(string)` | `null` | no |
| <a name="input_use_random_suffix"></a> [use\_random\_suffix](#input\_use\_random\_suffix) | Add a randomize suffix to the end of each resource created in this module. | `bool` | `true` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cos_buckets"></a> [cos\_buckets](#output\_cos\_buckets) | List of COS bucket instances with shortname, instance\_shortname, name, id, crn, and instance id. |
| <a name="output_cos_instances"></a> [cos\_instances](#output\_cos\_instances) | List of COS resource instances with shortname, name, id, and crn. |
| <a name="output_cos_keys"></a> [cos\_keys](#output\_cos\_keys) | List of COS bucket instances with shortname, instance\_shortname, name, id, crn, and instance id. |
| <a name="output_cos_suffix"></a> [cos\_suffix](#output\_cos\_suffix) | Random suffix appended to the end of COS resources |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
<!-- BEGIN CONTRIBUTING HOOK -->

<!-- Leave this section as is so that your module has a link to local development environment set up steps for contributors to follow -->
## Contributing

You can report issues and request features for this module in GitHub issues in the module repo. See [Report an issue or request a feature](https://github.com/terraform-ibm-modules/.github/blob/main/.github/SUPPORT.md).

To set up your local development environment, see [Local development setup](https://terraform-ibm-modules.github.io/documentation/#/local-dev-setup) in the project documentation.
<!-- END CONTRIBUTING HOOK -->
