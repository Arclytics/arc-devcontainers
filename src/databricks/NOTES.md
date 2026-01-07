## Overview

This template provides a production-ready Azure Databricks and PySpark development environment optimized for building, testing, and deploying Databricks projects using Asset Bundles. It includes all necessary tools for modern Python development, Databricks workflow management, and infrastructure as code practices.

## What's Included

### Development Tools

- **Python** (configurable version, default: 3.11)
- **Databricks CLI** (default: 0.250.0) - For Asset Bundles and workspace management
- **PySpark** - Apache Spark Python API
- **Azure CLI** - Azure cloud operations and authentication
- **Zsh with Oh-My-Zsh** - Enhanced shell environment
- **Java 11** - Required for Spark operations
- **Git** and standard utilities

### Python Libraries

Core libraries included:
- **pyspark** - Apache Spark for Python
- **pandas** - Data manipulation and analysis
- **numpy** - Numerical computing
- **pyarrow** - In-memory columnar data format

### Code Quality Tools

- **Pre-commit hooks** - Automated validation before commits
- **Ruff** - Fast Python linter and formatter (replaces Black, isort, flake8, and more)
- **MyPy** - Static type checking for Python
- **Pytest** - Python testing framework
- **EditorConfig** - Consistent code formatting across editors

### VS Code Extensions

- **Python** - Python language support
- **Pylance** - Fast, feature-rich language server
- **Jupyter** - Interactive notebook support
- **Databricks** - Databricks workspace integration
- **Ruff** - Python linter and formatter
- **EditorConfig** - Editor configuration enforcement
- **Makefile Tools** - Makefile support
- **Azure Account** - Azure subscription integration
- **Prettier** - Code formatting
- **GitLens** - Git integration and history
- **Docker** - Dockerfile and docker-compose support

### Included Configuration Files

- `Makefile` - Common Databricks Asset Bundle workflow automation
- `.pre-commit-config.yaml` - Pre-commit hook definitions for Python best practices
- `.editorconfig` - Editor behavior configuration
- `pyproject.toml` - Python project configuration with Ruff, MyPy, and Pytest settings
- `databricks.yml` - Example Databricks Asset Bundle configuration

## Features

### Databricks Asset Bundles

This template is optimized for [Databricks Asset Bundles](https://docs.databricks.com/dev-tools/bundles/), which provide:

- Infrastructure as Code for Databricks resources
- Version-controlled job and pipeline definitions
- Multi-environment deployments (dev, staging, prod)
- Reproducible deployments across workspaces

### Environment Variables

The template automatically passes through Databricks credentials from your local environment:

- `DATABRICKS_HOST` - Your Databricks workspace URL
- `DATABRICKS_TOKEN` - Your personal access token or service principal credentials

Set these in your local environment before starting the dev container.

### Local Spark Development

Optionally install Apache Spark locally by setting `installSparkLocally: true` when configuring the template. This enables:

- Offline PySpark development
- Local testing without Databricks workspace access
- Faster iteration for Spark application development

## Example Configuration

After adding this template, your `.devcontainer/devcontainer.json` will look similar to:

```jsonc
{
  "name": "Databricks with PySpark",
  "build": {
    "dockerfile": "Dockerfile",
    "args": {
      "DATABRICKS_CLI_VERSION": "0.250.0",
      "INSTALL_SPARK_LOCALLY": "false"
    }
  },
  "customizations": {
    "vscode": {
      "extensions": [
        "ms-python.python",
        "ms-toolsai.jupyter",
        "databricks.databricks"
      ]
    }
  }
}
```

## Usage

### Adding to Your Project

Follow the main repository's [usage instructions](../../README.md#usage) to add this template to your project using VS Code's Dev Container configuration workflow.

Reference this template using:
```
ghcr.io/arclytics/arc-devcontainers/databricks
```

### Authentication Setup

Before starting the dev container, set up your Databricks credentials:

#### Using Personal Access Token

```bash
export DATABRICKS_HOST="https://adb-1234567890123456.7.azuredatabricks.net"
export DATABRICKS_TOKEN="your-databricks-token-here"
```

#### Using Azure Service Principal

```bash
export DATABRICKS_HOST="https://adb-1234567890123456.7.azuredatabricks.net"
export ARM_TENANT_ID="your-tenant-id"
export ARM_CLIENT_ID="your-client-id"
export ARM_CLIENT_SECRET="your-client-secret"
```

Add these to your shell profile (`.bashrc`, `.zshrc`) or use a `.env` file for persistent configuration.

### Working with Databricks Asset Bundles

Once your container is running, use the included Makefile commands for common workflows:

```bash
# Initialize a new Databricks bundle
make init

# Validate bundle configuration
make validate

# Deploy to development environment
make deploy TARGET=dev

# Run a specific job
make run TARGET=dev JOB_KEY=my_job

# Deploy to production
make deploy TARGET=prod

# Destroy/cleanup deployment
make destroy TARGET=dev
```

### Asset Bundle Structure

A typical Databricks Asset Bundle project structure:

```
.
├── databricks.yml              # Bundle configuration
├── resources/                  # Resource definitions
│   ├── dev.yml                # Development environment config
│   └── prod.yml               # Production environment config
├── src/                       # Source code
│   ├── notebooks/             # Databricks notebooks
│   ├── pipelines/             # Delta Live Tables pipelines
│   └── libraries/             # Reusable Python modules
└── tests/                     # Unit and integration tests
```

### Pre-commit Hooks

Pre-commit hooks are automatically installed and will run the following checks before each commit:

- Code formatting with Ruff
- Linting with Ruff
- Type checking with MyPy (optional)
- YAML validation
- Trailing whitespace and EOF fixes
- Large file detection
- Private key detection

Run manually with:
```bash
pre-commit run --all-files
```

### Python Development

#### Code Formatting and Linting

```bash
# Format code
make format

# Run linter
make lint
```

#### Testing

```bash
# Run tests
make test

# Run tests with coverage
pytest --cov=src --cov-report=html
```

#### Type Checking

```bash
# Run MyPy type checker
mypy src/
```

### Working with PySpark Locally

If you enabled local Spark installation:

```python
from pyspark.sql import SparkSession

# Create local Spark session
spark = SparkSession.builder \
    .appName("LocalDevelopment") \
    .master("local[*]") \
    .getOrCreate()

# Read data
df = spark.read.csv("data.csv", header=True, inferSchema=True)

# Process data
result = df.filter(df.age > 25).groupBy("city").count()

# Show results
result.show()
```

### Databricks CLI Commands

```bash
# List workspace files
databricks workspace list /Users/your.email@company.com

# Upload a file
databricks workspace import notebook.py /Users/your.email@company.com/notebook.py

# Run a job
databricks jobs run-now --job-id 123

# List clusters
databricks clusters list

# Create a cluster
databricks clusters create --json-file cluster-config.json
```

## Best Practices

### Asset Bundle Development

1. **Use version control** - Commit your `databricks.yml` and resource definitions
2. **Separate environments** - Define distinct targets for dev, staging, and prod
3. **Use variables** - Parameterize configurations for reusability
4. **Test locally** - Validate bundle configuration before deployment
5. **Incremental deployments** - Deploy to dev first, then promote to production

### Python Code Quality

1. **Enable pre-commit hooks** - Run `make git-hooks` to install
2. **Use type hints** - Add type annotations for better code clarity
3. **Write tests** - Maintain high test coverage with pytest
4. **Follow PEP 8** - Let Ruff handle formatting automatically
5. **Document code** - Use docstrings for modules, classes, and functions

### PySpark Development

1. **Use DataFrame API** - Prefer DataFrame operations over RDDs
2. **Partition data** - Optimize data layout for query performance
3. **Cache wisely** - Use `.cache()` for frequently accessed data
4. **Monitor resources** - Check Spark UI for job performance
5. **Write idempotent code** - Ensure reruns produce the same results

## Troubleshooting

### Databricks CLI Authentication Issues

If you encounter authentication errors:

1. Verify environment variables are set:
   ```bash
   echo $DATABRICKS_HOST
   echo $DATABRICKS_TOKEN
   ```

2. Test CLI connectivity:
   ```bash
   databricks workspace list /
   ```

3. Check token expiration and regenerate if needed

### Spark Memory Issues

If Spark jobs run out of memory:

1. Adjust Spark configuration in `databricks.yml`
2. Increase cluster size or node types
3. Partition data more efficiently
4. Use selective column reading

### Pre-commit Hook Failures

If pre-commit hooks fail:

1. Run manually to see detailed errors:
   ```bash
   pre-commit run --all-files
   ```

2. Fix reported issues
3. Stage and commit again

## Additional Resources

- [Databricks Asset Bundles Documentation](https://docs.databricks.com/dev-tools/bundles/)
- [Databricks CLI Reference](https://docs.databricks.com/dev-tools/cli/)
- [PySpark Documentation](https://spark.apache.org/docs/latest/api/python/)
- [Ruff Documentation](https://docs.astral.sh/ruff/)
- [Azure Databricks Best Practices](https://learn.microsoft.com/en-us/azure/databricks/best-practices/)

## Support

For issues specific to this template, check the [main repository issues](https://github.com/Arclytics/arc-devcontainers/issues) or contact the Arclytics DevOps team.
