# training-azure-terraform-demo

A comprehensive training project demonstrating Infrastructure as Code (IaC) practices using Terraform on Microsoft Azure.

## Overview

This repository contains practical examples and demonstrations for deploying and managing Azure resources using Terraform. It serves as a learning resource for DevOps engineers and cloud architects looking to master Terraform on the Azure platform.

## Project Structure

```
training-azure-terraform-demo/
├── README.md
├── main.tf
├── variables.tf
├── outputs.tf
├── terraform.tfvars
└── [additional configuration files]
```

## Technologies Used

- **Terraform** - Infrastructure as Code tool for provisioning and managing cloud infrastructure
- **Azure** - Cloud platform for deploying and managing resources
- **HCL** (HashiCorp Configuration Language) - Language for Terraform configurations

## Language Composition

- **HCL**: 51.7% - Terraform configuration files
- **HTML**: 48.3% - Documentation and web resources

## Getting Started

### Prerequisites

Before you begin, ensure you have the following installed:

- [Terraform](https://www.terraform.io/downloads.html) (version 1.0+)
- [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli)
- An active [Azure subscription](https://azure.microsoft.com/)

### Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/damimati/training-azure-terraform-demo.git
   cd training-azure-terraform-demo
   ```

2. Initialize Terraform:
   ```bash
   terraform init
   ```

3. Review the plan:
   ```bash
   terraform plan
   ```

4. Apply the configuration:
   ```bash
   terraform apply
   ```

## Configuration

### Variables

Key variables are defined in `variables.tf`. Customize these values in `terraform.tfvars` or via command-line:

```bash
terraform apply -var="variable_name=value"
```

### Outputs

Outputs are defined in `outputs.tf` and display important resource information after deployment.

## Usage Examples

```bash
# Initialize Terraform
terraform init

# Validate configuration
terraform validate

# Format code
terraform fmt

# Plan changes
terraform plan -out=tfplan

# Apply changes
terraform apply tfplan

# Destroy resources
terraform destroy
```

## Best Practices

- Always run `terraform plan` before `terraform apply`
- Use `terraform fmt` to maintain consistent code formatting
- Store sensitive data in environment variables or Azure Key Vault
- Use remote state backends for team collaboration
- Implement proper versioning for Terraform and providers
- Document your infrastructure changes in commits

## Azure Resources

This project typically covers:

- Resource Groups
- Virtual Networks
- Subnets
- Network Interfaces
- Virtual Machines
- Storage Accounts
- And more (based on specific configuration)

## Contributing

Contributions are welcome! Please feel free to submit pull requests or open issues for suggestions and improvements.

## License

This project is provided as-is for educational purposes.

## Support

For issues, questions, or suggestions, please open an issue on GitHub.

## Resources

- [Terraform Documentation](https://www.terraform.io/docs)
- [Azure Provider for Terraform](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs)
- [Azure Documentation](https://docs.microsoft.com/en-us/azure/)
- [Terraform Best Practices](https://www.terraform.io/docs/cloud/best-practices.html)

---

**Last Updated**: 2026-08-27
