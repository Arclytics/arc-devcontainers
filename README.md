# Arclytics Dev Container Templates

[![Test PR](https://github.com/Arclytics/arc-devcontainers/actions/workflows/test-pr.yaml/badge.svg)](https://github.com/Arclytics/arc-devcontainers/actions/workflows/test-pr.yaml)
[![Release](https://github.com/Arclytics/arc-devcontainers/actions/workflows/release.yaml/badge.svg)](https://github.com/Arclytics/arc-devcontainers/actions/workflows/release.yaml)

> Standardized development container templates for consistent environments across Arclytics engineering teams

## Overview

This repository provides a curated collection of [Dev Container](https://containers.dev/) templates for Arclytics. These templates establish consistent, reproducible development environments across teams, eliminating environment configuration drift and reducing onboarding friction.

Each template includes pre-configured toolchains, IDE extensions, and development utilities specific to its technology stack. Templates are versioned independently and distributed via GitHub Container Registry for consumption in VS Code, GitHub Codespaces, and other Dev Container-compatible tools.

## Available Templates

| Template | Description | Version | Registry |
|----------|-------------|---------|----------|
| [Terraform](src/terraform/) | Production-ready Terraform environment with tfswitch, tflint, Azure CLI, and quality tools | 1.2.0 | `ghcr.io/arclytics/arc-devcontainers/terraform` |

Additional templates for other technology stacks and workflows will be added as standardized environments are defined across the organization.

## Usage

### Prerequisites

- [Visual Studio Code](https://code.visualstudio.com/)
- [Dev Containers extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers)
- [Docker Desktop](https://www.docker.com/products/docker-desktop)
- [GitHub CLI (gh)](https://cli.github.com/)

### Authentication

Templates are distributed via GitHub Container Registry and require authentication to access. This is a one-time setup per machine.

Authenticate using the GitHub CLI:

```bash
gh auth login
```

Follow the prompts to authenticate with your GitHub account. This grants Docker access to pull templates from `ghcr.io/arclytics/arc-devcontainers`.

To verify authentication status:

```bash
gh auth status
```

### Adding a Dev Container to Your Project

The recommended approach is to use VS Code's built-in Dev Container configuration workflow:

#### 1. Open Project

Open your project directory in VS Code.

#### 2. Access Command Palette

`Cmd+Shift+P` (macOS) or `Ctrl+Shift+P` (Windows/Linux)

#### 3. Add Dev Container Configuration

Select: **Dev Containers: Add Dev Container Configuration Files...**

![Command Palette](https://code.visualstudio.com/assets/docs/devcontainers/create-dev-container/dev-containers-command.png)

#### 4. Specify Template Source

When prompted for the template source, enter the GHCR reference for your desired template:

```
ghcr.io/arclytics/arc-devcontainers/terraform
```

Available template references:
- Terraform: `ghcr.io/arclytics/arc-devcontainers/terraform`

#### 5. Configure Template Options

VS Code will prompt for any configurable parameters defined in the template. Configure these based on your project requirements. Refer to each template's documentation for available options.

#### 6. Initialize Container

VS Code will prompt to reopen the workspace in the container.

Select **Reopen in Container** or manually execute **Dev Containers: Reopen in Container** from the Command Palette.

#### 7. Container Build

Initial container build may require several minutes depending on the template and network conditions. Subsequent launches will use cached layers and start significantly faster.

Once the build completes, your development environment is ready with all configured tools and extensions.

## Contributing

Contributions from Arclytics engineers are encouraged. To propose new templates or enhance existing ones:

### Adding a New Template

1. **Create template directory structure** in `src/<template-name>/`
2. **Define required files**:
   - `devcontainer-template.json` - Template metadata and configurable options
   - `.devcontainer/devcontainer.json` - Dev container configuration
   - `.devcontainer/Dockerfile` - (Optional) Custom image definition
   - `NOTES.md` - Detailed template documentation (what's included, usage, examples)
3. **Implement test coverage** in `test/<template-name>/test.sh`
4. **Validate locally**:
   ```bash
   ./.github/actions/smoke-test/build.sh <template-name>
   ./.github/actions/smoke-test/test.sh <template-name>
   ```
5. **Submit pull request** with template implementation and documentation

### Template Structure

Standard template organization:

```
src/
└── <template-name>/
    ├── devcontainer-template.json    # Template metadata
    ├── .devcontainer/
    │   ├── devcontainer.json         # Dev container configuration
    │   └── Dockerfile                # (Optional) Custom image
    ├── NOTES.md                      # Template usage documentation
    └── README.md                     # Auto-generated from template metadata + NOTES.md
```

Template README files are auto-generated during the release process. Add detailed documentation to `NOTES.md`, which will be merged with auto-generated content from `devcontainer-template.json`.

### Versioning

Templates use semantic versioning specified in `devcontainer-template.json`:

- **Patch** (1.0.x): Bug fixes, documentation updates
- **Minor** (1.x.0): New features, backward-compatible changes
- **Major** (x.0.0): Breaking changes

### Publishing

Templates are automatically published to GitHub Container Registry via CI/CD workflows on release creation or `main` branch updates. The automation handles:

- Template validation and testing
- Publishing to `ghcr.io/arclytics/arc-devcontainers/<template-name>`
- README generation from template metadata

## Reference Documentation

- [Dev Containers Documentation](https://containers.dev/)
- [VS Code Dev Containers Extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers)
- [Dev Container Specification](https://containers.dev/implementors/spec/)
- [Dev Container Templates Guide](https://containers.dev/implementors/templates)

## Support

For issues or questions:

- Review existing [Issues](https://github.com/Arclytics/arc-devcontainers/issues)
- Contact the Arclytics DevOps team
- Consult the [Dev Containers documentation](https://code.visualstudio.com/docs/devcontainers/containers)
