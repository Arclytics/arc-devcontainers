## Overview

This template provides a production-ready Terraform development environment optimized for Azure infrastructure projects, including Terraform module development and Azure resource management.

## What's Included

### Development Tools

- **Terraform version manager** (`tfswitch`) - default: 1.2.4
- **Terraform linter** (`tflint`) - default: v0.54.0
- **Azure CLI** - Azure cloud operations
- **Zsh with Oh-My-Zsh** - Enhanced shell environment
- **Git** and standard utilities

### Code Quality Tools

- **Pre-commit hooks** - Automated validation before commits
- **Terraform-docs** - Module documentation generation
- **EditorConfig** - Consistent code formatting

### VS Code Extensions

- **HashiCorp Terraform** - Syntax highlighting and language server
- **HashiCorp HCL** - HCL language support
- **EditorConfig** - Editor configuration enforcement
- **Makefile Tools** - Makefile support
- **Azure Account** - Azure subscription integration
- **Prettier** - Code formatting
- **GitLens** - Git integration and history
- **Docker** - Dockerfile and docker-compose support

### Included Configuration Files

- `Makefile` - Common Terraform workflow automation
- `.tflint.hcl` - TFLint configuration
- `.pre-commit-config.yaml` - Pre-commit hook definitions
- `.terraform-docs-root.yml` - Terraform documentation generator configuration
- `.editorconfig` - Editor behavior configuration

## Example Configuration

After adding this template, your `.devcontainer/devcontainer.json` will look similar to:

```jsonc
{
  "name": "Terraform",
  "build": {
    "dockerfile": "Dockerfile",
    "args": {
      "TFSWITCH_VERSION": "latest",
      "TFLINT_VERSION": "v0.54.0"
    }
  },
  "customizations": {
    "vscode": {
      "extensions": [
        "hashicorp.terraform",
        "hashicorp.hcl",
        "editorconfig.editorconfig",
        "ms-azuretools.vscode-azureresourcegroups",
        "esbenp.prettier-vscode",
        "eamodio.gitlens",
        "ms-azuretools.vscode-docker"
      ]
    }
  },
  "postCreateCommand": "pre-commit install"
}
```

## Usage

### Adding to Your Project

Follow the main repository's [usage instructions](../../README.md#usage) to add this template to your project using VS Code's Dev Container configuration workflow.

Reference this template using:
```
ghcr.io/arclytics/arc-devcontainers/terraform
```

### Working with Terraform

Once your container is running, use the included Makefile commands for common workflows:

```bash
make init      # Initialize Terraform
make plan      # Run terraform plan
make apply     # Run terraform apply
make fmt       # Format Terraform files
make validate  # Validate configuration
make docs      # Generate documentation
```

### Pre-commit Hooks

Pre-commit hooks are automatically installed and will run the following checks before each commit:

- Terraform formatting (`terraform fmt`)
- Terraform validation (`terraform validate`)
- TFLint checks
- Terraform documentation generation

## Support

For issues specific to this template, check the [main repository issues](https://github.com/Arclytics/arc-devcontainers/issues) or contact the Arclytics DevOps team.
