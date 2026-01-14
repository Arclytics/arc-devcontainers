## Overview

This template provides a production-ready Microsoft Fabric data engineering environment optimized for building, testing, and deploying Lakehouse projects, data pipelines, and Spark applications. It includes all necessary tools for modern Python development, Microsoft Fabric CLI, Azure integration, and best practices for data engineering workflows.

## What's Included

### Development Tools

- **Python** (configurable version, default: 3.11)
- **Microsoft Fabric CLI** (default: latest) - For workspace management, data operations, and automation
- **PySpark** - Apache Spark Python API for distributed data processing
- **Azure CLI** - Azure cloud operations and authentication
- **Zsh with Oh-My-Zsh** - Enhanced shell environment
- **Java 21** - Required for Spark operations
- **Git** and standard utilities

### Python Libraries

Core libraries included:
- **pyspark** - Apache Spark for Python
- **pandas** - Data manipulation and analysis
- **numpy** - Numerical computing
- **pyarrow** - In-memory columnar data format
- **polars** - Lightning-fast DataFrame library
- **duckdb** - In-process SQL OLAP database
- **fabric-data-agent-sdk** - Microsoft Fabric Data Agent SDK
- **azure-identity** - Azure authentication library

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
- **Ruff** - Python linter and formatter
- **EditorConfig** - Editor configuration enforcement
- **Makefile Tools** - Makefile support
- **Azure Account** - Azure subscription integration
- **Azure Functions** - Azure Functions development
- **Prettier** - Code formatting
- **GitLens** - Git integration and history
- **Docker** - Dockerfile and docker-compose support

### Included Configuration Files

- `Makefile` - Common Fabric and data engineering workflow automation
- `.pre-commit-config.yaml` - Pre-commit hook definitions for Python best practices
- `.editorconfig` - Editor behavior configuration
- `pyproject.toml` - Python project configuration with Ruff, MyPy, and Pytest settings

## Features

### Microsoft Fabric Integration

This template is optimized for [Microsoft Fabric](https://learn.microsoft.com/en-us/fabric/), which provides:

- **Lakehouse Architecture** - Unified data lake and data warehouse capabilities
- **Data Pipelines** - Orchestration and data movement with Data Factory
- **Apache Spark** - Distributed data processing and analytics
- **Delta Lake** - ACID transactions, schema evolution, and time travel
- **Notebooks** - Interactive development and documentation
- **Data Science** - ML model training and deployment

### Medallion Architecture

Follow best practices with the Medallion Architecture for organizing your Lakehouse:

- **Bronze Layer** - Raw data ingestion, minimal transformations
- **Silver Layer** - Cleansed, conformed, and enriched data
- **Gold Layer** - Business-level aggregations and curated datasets

### Environment Variables

The template automatically passes through Azure and Fabric credentials from your local environment:

- `FABRIC_WORKSPACE_ID` - Your Fabric workspace identifier
- `FABRIC_TENANT_ID` - Your Microsoft Fabric tenant ID
- `AZURE_CLIENT_ID` - Service principal client ID
- `AZURE_CLIENT_SECRET` - Service principal secret
- `AZURE_TENANT_ID` - Azure tenant ID

Set these in your local environment before starting the dev container.

### Local Spark Development

Optionally install Apache Spark locally by setting `installSparkLocally: true` when configuring the template. This enables:

- Offline PySpark development
- Local testing without Fabric workspace access
- Faster iteration for Spark application development

## Example Configuration

After adding this template, your `.devcontainer/devcontainer.json` will look similar to:

```jsonc
{
  "name": "Microsoft Fabric Data Engineering",
  "build": {
    "dockerfile": "Dockerfile",
    "args": {
      "FABRIC_CLI_VERSION": "latest",
      "INSTALL_SPARK_LOCALLY": "false"
    }
  },
  "customizations": {
    "vscode": {
      "extensions": [
        "ms-python.python",
        "ms-toolsai.jupyter",
        "ms-vscode.azure-account"
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
ghcr.io/arclytics/arc-devcontainers/fabric-data-engineering
```

### Authentication Setup

Before starting the dev container, set up your Azure and Fabric credentials:

#### Using Service Principal (Recommended for CI/CD)

```bash
export AZURE_TENANT_ID="your-tenant-id"
export AZURE_CLIENT_ID="your-client-id"
export AZURE_CLIENT_SECRET="your-client-secret"
export FABRIC_WORKSPACE_ID="your-workspace-id"
```

#### Using Azure CLI Authentication

```bash
# Login to Azure
az login

# Set Fabric workspace
export FABRIC_WORKSPACE_ID="your-workspace-id"
```

Add these to your shell profile (`.bashrc`, `.zshrc`) or use a `.env` file for persistent configuration.

### Working with Microsoft Fabric CLI

Once your container is running, use the Fabric CLI for common workflows:

```bash
# Login to Fabric (if not using service principal)
fab login

# List workspaces
fab workspace list

# Set active workspace
fab workspace use <workspace-id>

# List items in workspace
fab item list

# Create a lakehouse
fab lakehouse create --name my-lakehouse

# Upload files to lakehouse
fab lakehouse upload --path ./data --lakehouse my-lakehouse

# List notebooks
fab notebook list

# Run a notebook
fab notebook run --name my-notebook
```

### Lakehouse Development

#### Project Structure

A typical Microsoft Fabric Lakehouse project structure:

```
.
├── data/                       # Local data for development
├── notebooks/                  # Fabric notebooks
│   ├── bronze/                # Bronze layer transformations
│   ├── silver/                # Silver layer transformations
│   └── gold/                  # Gold layer aggregations
├── pipelines/                 # Data pipeline definitions
├── src/                       # Reusable Python modules
│   ├── ingestion/             # Data ingestion utilities
│   ├── transformations/       # Data transformation logic
│   └── utils/                 # Helper functions
└── tests/                     # Unit and integration tests
```

### PySpark Development

#### Working with DataFrames

```python
from pyspark.sql import SparkSession
from pyspark.sql.functions import col, sum, avg

# Create Spark session for Fabric
spark = SparkSession.builder \
    .appName("FabricLakehouse") \
    .getOrCreate()

# Read from Lakehouse table
df = spark.read.format("delta").load("Tables/my_table")

# Transform data
transformed_df = df.filter(col("status") == "active") \
    .groupBy("category") \
    .agg(
        sum("amount").alias("total_amount"),
        avg("price").alias("avg_price")
    )

# Write to Lakehouse
transformed_df.write \
    .format("delta") \
    .mode("overwrite") \
    .saveAsTable("silver.category_summary")
```

#### Best Practices for PySpark

1. **Use DataFrame API** - Prefer DataFrame operations over RDDs
2. **Leverage Catalyst Optimizer** - Use built-in functions instead of UDFs when possible
3. **Partition Data** - Optimize data layout for query performance
4. **Cache Wisely** - Use `.cache()` for frequently accessed data
5. **Monitor Performance** - Check Spark UI for job metrics

### Data Pipeline Development

#### Using Makefile Commands

The included Makefile provides common workflow automation:

```bash
# Format code
make format

# Run linter
make lint

# Run tests
make test

# Clean up generated files
make clean

# Install pre-commit hooks
make git-hooks
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

### Working with Delta Lake

Microsoft Fabric uses Delta Lake format for all Lakehouse tables:

```python
# Read Delta table
df = spark.read.format("delta").table("my_table")

# Time travel - read historical version
df_historical = spark.read \
    .format("delta") \
    .option("versionAsOf", "10") \
    .table("my_table")

# Merge operation (upsert)
from delta.tables import DeltaTable

delta_table = DeltaTable.forName(spark, "target_table")

delta_table.alias("target").merge(
    source_df.alias("source"),
    "target.id = source.id"
).whenMatchedUpdateAll() \
 .whenNotMatchedInsertAll() \
 .execute()

# Optimize table
spark.sql("OPTIMIZE my_table")

# Vacuum old versions
spark.sql("VACUUM my_table RETAIN 168 HOURS")
```

### Testing

```bash
# Run all tests
pytest

# Run tests with coverage
pytest --cov=src --cov-report=html

# Run specific test file
pytest tests/test_transformations.py

# Run with verbose output
pytest -v
```

### Type Checking

```bash
# Run MyPy type checker
mypy src/
```

## Best Practices

### Lakehouse Development

1. **Implement Medallion Architecture** - Organize data into Bronze, Silver, and Gold layers
2. **Use Delta Lake** - Leverage ACID transactions and time travel capabilities
3. **Partition Strategically** - Partition large tables by commonly filtered columns
4. **Schema Evolution** - Design for schema changes with Delta Lake merge schema
5. **Data Quality** - Implement validation at each layer transition

### Data Engineering

1. **Idempotent Pipelines** - Ensure reruns produce consistent results
2. **Incremental Processing** - Process only new or changed data when possible
3. **Error Handling** - Implement robust error handling and logging
4. **Monitoring** - Track pipeline execution metrics and data quality
5. **Documentation** - Document data lineage and transformation logic

### Python Code Quality

1. **Enable pre-commit hooks** - Run `make git-hooks` to install
2. **Use type hints** - Add type annotations for better code clarity
3. **Write tests** - Maintain high test coverage with pytest
4. **Follow PEP 8** - Let Ruff handle formatting automatically
5. **Document code** - Use docstrings for modules, classes, and functions

### Performance Optimization

1. **Broadcast Joins** - Use broadcast for small lookup tables
2. **Predicate Pushdown** - Filter early in the transformation pipeline
3. **Column Pruning** - Select only needed columns
4. **Partition Pruning** - Filter on partition columns when possible
5. **Adaptive Query Execution** - Enable AQE for dynamic optimization

## Troubleshooting

### Fabric CLI Authentication Issues

If you encounter authentication errors:

1. Verify environment variables are set:
   ```bash
   echo $AZURE_TENANT_ID
   echo $AZURE_CLIENT_ID
   echo $FABRIC_WORKSPACE_ID
   ```

2. Test CLI connectivity:
   ```bash
   fab workspace list
   ```

3. Re-authenticate if needed:
   ```bash
   fab login
   ```

### Spark Memory Issues

If Spark jobs run out of memory:

1. Adjust Spark configuration in your notebook or code
2. Increase executor memory and cores
3. Partition data more efficiently
4. Use selective column reading and filtering

### Pre-commit Hook Failures

If pre-commit hooks fail:

1. Run manually to see detailed errors:
   ```bash
   pre-commit run --all-files
   ```

2. Fix reported issues
3. Stage and commit again

### Package Installation Issues

If Python packages fail to install:

1. Upgrade pip:
   ```bash
   pip install --upgrade pip
   ```

2. Clear cache:
   ```bash
   pip cache purge
   ```

3. Install with verbose output:
   ```bash
   pip install -v <package-name>
   ```

## Additional Resources

- [Microsoft Fabric Documentation](https://learn.microsoft.com/en-us/fabric/)
- [Fabric CLI Reference](https://microsoft.github.io/fabric-cli/)
- [PySpark Documentation](https://spark.apache.org/docs/latest/api/python/)
- [Delta Lake Documentation](https://docs.delta.io/latest/index.html)
- [Fabric Data Engineering Best Practices](https://learn.microsoft.com/en-us/fabric/data-engineering/spark-best-practices-overview)
- [Ruff Documentation](https://docs.astral.sh/ruff/)
- [Azure Authentication](https://learn.microsoft.com/en-us/python/api/overview/azure/identity-readme)

## Support

For issues specific to this template, check the [main repository issues](https://github.com/Arclytics/arc-devcontainers/issues) or contact the Arclytics DevOps team.
