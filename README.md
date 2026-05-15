# AWS FortiManager Terraform Module

This repository contains Terraform modules for deploying Fortinet FortiManager on AWS. The modules provide a comprehensive solution for centralized security logging and reporting in AWS environments.

## Features

- **Automated AMI Discovery**: Automatically finds the latest FortiManager AMI based on license type (BYOL/PAYG) and version
- **Flexible Licensing**: Support for both BYOL (Bring Your Own License) and PAYG (Pay As You Go) deployments
- **Security**: Pre-configured security groups with appropriate rules for management and log collection
- **Storage**: Configurable root and log storage volumes with encryption
- **Networking**: Support for existing VPC/subnet infrastructure or automatic configuration
- **IAM Integration**: Optional IAM roles for AWS service integration
- **Monitoring**: CloudWatch integration and detailed monitoring options

## Module Structure

```
terraform-aws-fortimanager/
├── modules/
│   └── single/              # Single FortiManager deployment
├── examples/
│   ├── single-byol/         # BYOL deployment example
│   └── single-payg/         # PAYG deployment example
└── README.md
```

## Quick Start

### Prerequisites

- AWS CLI configured with appropriate permissions
- Terraform >= 1.0
- AWS key pair for SSH access
- For BYOL: Valid FortiManager license file

### Basic PAYG Deployment

```hcl
module "fortimanager" {
  source = "./modules/single"

  # Basic configuration
  name                  = "my-fortimanager"
  fmg_license_type          = "payg"
  fortimanager_version = "7.4"
  
  # Instance configuration
  instance_type = "m5.large"
  key_name      = "my-key-pair"
  
  # Network configuration
  vpc_id    = "vpc-12345678"
  subnet_id = "subnet-12345678"
  
  # Security
  admin_cidr_blocks = ["203.0.113.0/24"]
}
```

### Basic BYOL Deployment

```hcl
module "fortimanager" {
  source = "./modules/single"

  # Basic configuration
  name                  = "my-fortimanager"
  fmg_license_type          = "byol"
  fortimanager_version = "7.4"
  license_file          = file("path/to/license.lic")
  
  # Instance configuration
  instance_type = "m5.large"
  key_name      = "my-key-pair"
  
  # Network configuration
  vpc_id    = "vpc-12345678"
  subnet_id = "subnet-12345678"
  
  # Security
  admin_cidr_blocks = ["203.0.113.0/24"]
}
```

## Examples

Detailed examples are available in the `examples/` directory:

- **[single-byol](examples/single-byol/)**: Complete BYOL deployment with all configuration options
- **[single-payg](examples/single-payg/)**: Complete PAYG deployment for quick testing

## Supported FortiManager Versions

The module supports FortiManager versions 7.0 and above. You can specify versions using:

- Exact version: `"7.4.5"`
- Major.minor: `"7.4"` (latest patch version)
- Major only: `"7"` (latest version in major release)

## AMI Search Logic

The module automatically searches for the appropriate AMI based on:

- **BYOL**: `FortiManager-VM64-AWS*{version}*`
- **PAYG**: `FortiManager-VM64-AWSONDEMAND*{version}*`

## Security Considerations

### Default Security Group Rules

The module creates security groups with the following rules:

**Management Access:**
- SSH (22/tcp) - from admin_cidr_blocks
- HTTPS (443/tcp) - from admin_cidr_blocks

**Log Collection:**
- Secure log transmission (541/tcp) - from fortigate_cidr_blocks
- Syslog (514/udp) - from fortigate_cidr_blocks

### Recommendations

1. **Restrict Management Access**: Always specify specific CIDR blocks for `admin_cidr_blocks`
2. **Use Private Subnets**: Deploy in private subnets when possible
3. **Enable Encryption**: Root and log volumes are encrypted by default
4. **Regular Updates**: Keep FortiManager version updated

## Storage Configuration

### Root Volume
- Default: 20 GB GP3
- Encrypted by default
- Configurable size and type

### Log Volume
- Default: 100 GB GP3 (optional)
- Encrypted by default
- Mounted as `/dev/sdf`
- Configurable size and type

## IAM Permissions

The module can create an IAM role with permissions for:
- EC2 instance metadata access
- CloudWatch logs integration
- Basic AWS service discovery

## Outputs

The module provides comprehensive outputs including:
- Instance information (ID, IPs, state)
- Network details (security groups, interfaces)
- Management URLs and SSH connection strings
- Storage and IAM resource information

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test with both BYOL and PAYG examples
5. Submit a pull request

## Support

For issues and questions:
1. Check the [examples](examples/) for common use cases
2. Review Fortinet documentation for FortiManager
3. Open an issue in this repository

## References

- [FortiManager AWS Administration Guide](https://docs.fortinet.com/document/fortimanager-public-cloud/7.6.0/aws-administration-guide/)
- [AWS Marketplace - FortiManager](https://aws.amazon.com/marketplace/seller-profile?id=7de3dd38-52b2-4c1a-9fc1-93e7dfca9d6b)
- [Terraform AWS Provider Documentation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
