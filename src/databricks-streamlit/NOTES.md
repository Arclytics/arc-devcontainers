## Overview

This template provides a production-ready Azure Databricks Streamlit development environment optimized for building and deploying interactive data applications. It includes all necessary tools for modern Python development, Streamlit app creation, Databricks integration, and infrastructure as code practices.

## What's Included

### Development Tools

- **Python** (configurable version, default: 3.11)
- **Databricks CLI** (default: 0.18.0) - For Asset Bundles and workspace management
- **Streamlit** (default: 1.32.0) - Interactive data app framework
- **Azure CLI** - Azure cloud operations and authentication
- **Zsh with Oh-My-Zsh** - Enhanced shell environment
- **Git** and standard utilities

### Python Libraries

Core libraries included:
- **streamlit** - Interactive data application framework
- **pandas** - Data manipulation and analysis
- **numpy** - Numerical computing
- **plotly** - Interactive visualizations
- **altair** - Declarative statistical visualizations
- **matplotlib** - Static plotting library
- **seaborn** - Statistical data visualization
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
- **Databricks** - Databricks workspace integration
- **Ruff** - Python linter and formatter
- **EditorConfig** - Editor configuration enforcement
- **Makefile Tools** - Makefile support
- **Azure Account** - Azure subscription integration
- **Prettier** - Code formatting
- **GitLens** - Git integration and history
- **Docker** - Dockerfile and docker-compose support

### Included Configuration Files

- `Makefile` - Common Databricks and Streamlit workflow automation
- `.pre-commit-config.yaml` - Pre-commit hook definitions for Python best practices
- `.editorconfig` - Editor behavior configuration
- `pyproject.toml` - Python project configuration with Ruff, MyPy, and Pytest settings
- `databricks.yml` - Example Databricks Asset Bundle configuration

## Features

### Databricks Streamlit Apps

This template is optimized for [Databricks Streamlit apps](https://docs.databricks.com/en/build-data-apps/streamlit.html), which provide:

- Interactive data applications running in Databricks
- Direct access to Databricks data sources
- Secure sharing within your organization
- Serverless deployment on Databricks infrastructure
- Integration with Databricks Asset Bundles for CI/CD

### Port Forwarding

The template automatically forwards port 8501 (Streamlit's default port) and notifies you when the app is running. This allows you to:

- Develop and test Streamlit apps locally
- Preview changes before deploying to Databricks
- Debug apps in a familiar environment

### Environment Variables

The template automatically passes through Databricks credentials from your local environment:

- `DATABRICKS_HOST` - Your Databricks workspace URL
- `DATABRICKS_TOKEN` - Your personal access token or service principal credentials

Set these in your local environment before starting the dev container.

## Example Configuration

After adding this template, your `.devcontainer/devcontainer.json` will look similar to:

```jsonc
{
  "name": "Databricks with Streamlit",
  "build": {
    "dockerfile": "Dockerfile",
    "args": {
      "DATABRICKS_CLI_VERSION": "0.18.0",
      "STREAMLIT_VERSION": "1.32.0"
    }
  },
  "customizations": {
    "vscode": {
      "extensions": [
        "ms-python.python",
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
ghcr.io/arclytics/arc-devcontainers/databricks-streamlit
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

### Creating a Streamlit App

Once your container is running, create a simple Streamlit app:

```python
# app.py
import streamlit as st
import pandas as pd
from databricks import sql

st.title("My Databricks Streamlit App")

# Connect to Databricks SQL Warehouse
with sql.connect(
    server_hostname=os.getenv("DATABRICKS_HOST"),
    http_path="/sql/1.0/warehouses/your-warehouse-id",
    access_token=os.getenv("DATABRICKS_TOKEN")
) as connection:
    
    with connection.cursor() as cursor:
        cursor.execute("SELECT * FROM my_table LIMIT 100")
        df = pd.DataFrame(cursor.fetchall(), columns=[desc[0] for desc in cursor.description])
        
st.dataframe(df)
st.line_chart(df)
```

Run the app locally:

```bash
streamlit run app.py
```

The app will be available at http://localhost:8501

### Deploying to Databricks

#### Option 1: Manual Deployment

1. Upload your Streamlit app to Databricks workspace
2. Create a Streamlit app in Databricks UI
3. Point it to your uploaded app file

#### Option 2: Using Databricks Asset Bundles

Define your Streamlit app in `databricks.yml`:

```yaml
resources:
  apps:
    my_streamlit_app:
      name: my-streamlit-app
      description: "My interactive data app"
      resources:
        - name: warehouse
          warehouse:
            id: "your-warehouse-id"
      source_code_path: ./src/app.py
```

Deploy using the CLI:

```bash
databricks bundle deploy -t prod
```

### Working with Databricks Asset Bundles

Use the included Makefile commands for common workflows:

```bash
# Initialize a new Databricks bundle
make init

# Validate bundle configuration
make validate

# Deploy to development environment
make deploy TARGET=dev

# Deploy to production
make deploy TARGET=prod

# Destroy/cleanup deployment
make destroy TARGET=dev
```

### Streamlit Development

#### Running Apps Locally

```bash
# Run your Streamlit app
streamlit run app.py

# Run with auto-reload on file changes
streamlit run app.py --server.runOnSave true

# Run on a different port
streamlit run app.py --server.port 8502
```

#### Streamlit Best Practices

1. **Use caching** - Leverage `@st.cache_data` and `@st.cache_resource` for expensive operations
2. **Session state** - Use `st.session_state` to maintain state across reruns
3. **Error handling** - Use try/except blocks and `st.error()` for user-friendly error messages
4. **Performance** - Limit data fetching, use pagination for large datasets
5. **Security** - Never hardcode credentials, use environment variables

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

## Example Streamlit Apps

### Simple Data Explorer

```python
import streamlit as st
import pandas as pd

st.title("Data Explorer")

uploaded_file = st.file_uploader("Choose a CSV file", type="csv")
if uploaded_file is not None:
    df = pd.read_csv(uploaded_file)
    
    st.subheader("Data Preview")
    st.dataframe(df.head())
    
    st.subheader("Statistics")
    st.write(df.describe())
    
    st.subheader("Visualizations")
    numeric_cols = df.select_dtypes(include=['number']).columns
    selected_col = st.selectbox("Select column to visualize", numeric_cols)
    st.line_chart(df[selected_col])
```

### Interactive Dashboard

```python
import streamlit as st
import plotly.express as px
import pandas as pd

st.set_page_config(page_title="Sales Dashboard", layout="wide")

st.title("📊 Sales Dashboard")

# Sidebar filters
st.sidebar.header("Filters")
date_range = st.sidebar.date_input("Date Range", [])
category = st.sidebar.multiselect("Category", ["A", "B", "C"])

# Metrics
col1, col2, col3 = st.columns(3)
col1.metric("Total Sales", "$1.2M", "+5.2%")
col2.metric("Orders", "1,234", "-2.1%")
col3.metric("Customers", "567", "+12.3%")

# Charts
tab1, tab2, tab3 = st.tabs(["Trends", "Distribution", "Details"])

with tab1:
    st.subheader("Sales Trends")
    # Add trend chart here
    
with tab2:
    st.subheader("Category Distribution")
    # Add pie chart here
    
with tab3:
    st.subheader("Detailed Data")
    # Add data table here
```

## Best Practices

### Streamlit App Development

1. **Structure your app** - Use pages for multi-page apps (`pages/` directory)
2. **Optimize performance** - Cache data loading and expensive computations
3. **User experience** - Add loading spinners, progress bars, and helpful messages
4. **Responsive design** - Use columns and containers for better layouts
5. **Testing** - Write unit tests for data processing functions

### Databricks Integration

1. **Use SQL Warehouses** - For interactive queries and dashboards
2. **Connection pooling** - Reuse connections for better performance
3. **Query optimization** - Use appropriate filters and limits
4. **Error handling** - Handle connection failures gracefully
5. **Monitoring** - Log usage and performance metrics

### Deployment

1. **Version control** - Commit your Streamlit apps to Git
2. **Environment management** - Use separate dev/staging/prod environments
3. **Dependencies** - Pin versions in requirements.txt or pyproject.toml
4. **Configuration** - Use Asset Bundles for reproducible deployments
5. **Documentation** - Document app functionality and usage

## Troubleshooting

### Streamlit Port Issues

If port 8501 is already in use:

1. Check for running Streamlit processes:
   ```bash
   ps aux | grep streamlit
   ```

2. Kill the process or use a different port:
   ```bash
   streamlit run app.py --server.port 8502
   ```

### Databricks Connection Issues

If you encounter connection errors:

1. Verify environment variables are set:
   ```bash
   echo $DATABRICKS_HOST
   echo $DATABRICKS_TOKEN
   ```

2. Test connectivity:
   ```bash
   databricks workspace list /
   ```

3. Check token expiration and regenerate if needed

### Streamlit App Not Loading

If the app doesn't load:

1. Check for Python errors in the terminal
2. Verify all dependencies are installed
3. Check file paths are correct
4. Look for syntax errors in your code

### Pre-commit Hook Failures

If pre-commit hooks fail:

1. Run manually to see detailed errors:
   ```bash
   pre-commit run --all-files
   ```

2. Fix reported issues
3. Stage and commit again

## Additional Resources

- [Streamlit Documentation](https://docs.streamlit.io/)
- [Databricks Streamlit Apps](https://docs.databricks.com/en/build-data-apps/streamlit.html)
- [Databricks Asset Bundles Documentation](https://docs.databricks.com/dev-tools/bundles/)
- [Databricks CLI Reference](https://docs.databricks.com/dev-tools/cli/)
- [Ruff Documentation](https://docs.astral.sh/ruff/)
- [Streamlit Gallery](https://streamlit.io/gallery)

## Support

For issues specific to this template, check the [main repository issues](https://github.com/Arclytics/arc-devcontainers/issues) or contact the Arclytics DevOps team.
