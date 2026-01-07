
# Azure Container Apps - Java (azure-container-apps-java)

Java development environment for Azure Container Apps with Maven, Azure CLI, and containerization tools

## Options

| Options Id | Description | Type | Default Value |
|-----|-----|-----|-----|
| javaVersion | Java version to install | string | 21 |
| mavenVersion | Maven version to install | string | 3.9 |
| installGradle | Install Gradle build tool | boolean | false |

## Overview

This template provides a production-ready Java development environment optimized for Azure Container Apps development, including Java application development, containerization, and Azure cloud deployment.

## What's Included

### Development Tools

- **Java Development Kit (JDK)** - default: OpenJDK 21
- **Maven** - Build automation tool - default: 3.9
- **Gradle** (optional) - Alternative build tool
- **Azure CLI** - Azure cloud operations
- **Azure Container Apps CLI extension** - Container Apps management
- **Azure Developer CLI (azd)** - Streamlined Azure development workflow
- **Docker** - Container runtime for building and testing
- **kubectl** - Kubernetes command-line tool
- **Helm** - Kubernetes package manager
- **Zsh with Oh-My-Zsh** - Enhanced shell environment
- **Git** and standard utilities

### VS Code Extensions

- **Java Extension Pack** - Complete Java development experience
  - Language Support for Java by Red Hat
  - Debugger for Java
  - Test Runner for Java
  - Maven for Java
  - Project Manager for Java
  - IntelliCode
- **Maven for Java** - Maven project management
- **Spring Initializr** - Spring Boot project generation
- **Spring Boot Dashboard** - Spring Boot application management
- **Spring Boot Extension Pack** - Complete Spring Boot development
- **Azure Container Apps** - Container Apps management and deployment
- **Docker** - Dockerfile and docker-compose support
- **Kubernetes Tools** - Kubernetes resource management
- **Azure Account** - Azure subscription integration
- **EditorConfig** - Editor configuration enforcement
- **GitLens** - Git integration and history

### Included Configuration Files

- `Makefile` - Common workflow automation (optional)
- `.editorconfig` - Editor behavior configuration (optional)

## Example Configuration

After adding this template, your `.devcontainer/devcontainer.json` will look similar to:

```jsonc
{
  "name": "Azure Container Apps - Java",
  "build": {
    "dockerfile": "Dockerfile",
    "args": {
      "JAVA_VERSION": "21",
      "MAVEN_VERSION": "3.9"
    }
  },
  "customizations": {
    "vscode": {
      "extensions": [
        "vscjava.vscode-java-pack",
        "ms-azuretools.vscode-azurecontainerapps",
        "ms-azuretools.vscode-docker"
      ]
    }
  },
  "postCreateCommand": "az extension add --name containerapp"
}
```

## Usage

### Adding to Your Project

Follow the main repository's [usage instructions](../../README.md#usage) to add this template to your project using VS Code's Dev Container configuration workflow.

Reference this template using:
```
ghcr.io/arclytics/arc-devcontainers/azure-container-apps-java
```

### Working with Java and Maven

Once your container is running, you can use Maven commands for common workflows:

```bash
# Build the project
mvn clean install

# Run the application
mvn spring-boot:run

# Run tests
mvn test

# Package the application
mvn package
```

### Building and Deploying to Azure Container Apps

#### Build Container Image

```bash
# Build Docker image locally
docker build -t myapp:latest .

# Or use Maven with jib plugin
mvn compile jib:dockerBuild
```

#### Deploy to Azure Container Apps

```bash
# Login to Azure
az login

# Create resource group (if needed)
az group create --name myapp-rg --location eastus

# Create Container Apps environment (if needed)
az containerapp env create \
  --name myapp-env \
  --resource-group myapp-rg \
  --location eastus

# Create and deploy container app
az containerapp create \
  --name myapp \
  --resource-group myapp-rg \
  --environment myapp-env \
  --image myapp:latest \
  --target-port 8080 \
  --ingress external

# Or use Azure Developer CLI for streamlined deployment
azd init
azd up
```

### Using the Makefile (Optional)

If you include the optional Makefile, you can use these commands:

```bash
make build      # Build the application
make test       # Run tests
make run        # Run the application locally
make package    # Package the application
make docker     # Build Docker image
```

## Container Apps Specific Features

### Environment Variables

Configure environment variables in your Container App:

```bash
az containerapp update \
  --name myapp \
  --resource-group myapp-rg \
  --set-env-vars "KEY=value" "ANOTHER_KEY=another_value"
```

### Scaling

Configure auto-scaling for your Container App:

```bash
az containerapp update \
  --name myapp \
  --resource-group myapp-rg \
  --min-replicas 1 \
  --max-replicas 10
```

### Continuous Deployment

Set up continuous deployment from GitHub:

```bash
az containerapp github-action add \
  --name myapp \
  --resource-group myapp-rg \
  --repo-url https://github.com/yourorg/yourrepo \
  --branch main
```

## Support

For issues specific to this template, check the [main repository issues](https://github.com/Arclytics/arc-devcontainers/issues) or contact the Arclytics DevOps team.


---

_Note: This file was auto-generated from the [devcontainer-template.json](https://github.com/Arclytics/arc-devcontainers/blob/main/src/azure-container-apps-java/devcontainer-template.json).  Add additional notes to a `NOTES.md`._
