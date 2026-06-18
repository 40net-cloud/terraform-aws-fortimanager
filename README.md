# FortiManager Terraform modules for AWS

## Introduction

This repository contains Terraform modules for deploying Fortinet FortiManager on AWS. Multiple examples for the different deployment methods in AWS can be found in the examples directory.

### Prerequisites

- AWS CLI configured with appropriate permissions
- Terraform >= 1.0
- AWS key pair for SSH access
- For BYOL: Valid FortiManager license file

## Module Structure

```
terraform-aws-fortimanager/
├── modules/
│   ├── single/          # Single FortiManager deployment
│   └── ha/              # HA FortiManager deployment
├── examples/
│   ├── single-byol/         # BYOL deployment example
│   └── single-payg/         # PAYG deployment example
└── README.md
```

## Deployment

More documentation on [HA](examples/ha/README.md)

Before deploying the example, users should review the `examples/[single,ha]/terraform.tfvars.example` file to ensure all required values are provided and to adjust any settings to fit their specific project needs.

1. Navigate to the example folder (e.g., `examples/ha`).
2. Review the variables in the file and provide all the required values in it.
3. Rename the file `terraform.tfvars.example` to `terraform.tfvars`.
4. Run the following commands:

   ```sh
   terraform init
   terraform plan
   terraform apply
   ```

## Support

Fortinet-provided scripts in this and other GitHub projects do not fall under the regular Fortinet technical support scope and are not supported by FortiCare Support Services.
For direct issues, please refer to the [Issues](https://github.com/40net-cloud/terraform-aws-fortimanager/issues) tab of this GitHub project.

## License

[License](/../../blob/main/LICENSE) © Fortinet Technologies. All rights reserved.
