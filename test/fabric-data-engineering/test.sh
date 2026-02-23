#!/bin/bash
cd $(dirname "$0")
source test-utils.sh

# Template specific tests
check "python-installed" command -v python
check "python-version" python --version
check "pip-installed" command -v pip
check "fabric-cli-installed" command -v fab
check "fabric-cli-version" fab --version
check "pyspark-installed" python -c "import pyspark; print(pyspark.__version__)"
check "pandas-installed" python -c "import pandas; print(pandas.__version__)"
check "numpy-installed" python -c "import numpy; print(numpy.__version__)"
check "pyarrow-installed" python -c "import pyarrow; print(pyarrow.__version__)"
check "polars-installed" python -c "import polars; print(polars.__version__)"
check "duckdb-installed" python -c "import duckdb; print(duckdb.__version__)"
check "fabric-data-agent-sdk-installed" python -c "from fabric.dataagent.client import create_data_agent; print('installed')"
check "azure-identity-installed" python -c "import azure.identity; print('installed')"
check "zsh-installed" command -v zsh
check "oh-my-zsh-installed" [ -d "$HOME/.oh-my-zsh" ]
check "azure-cli-installed" command -v az
check "pre-commit-installed" command -v pre-commit
check "ruff-installed" command -v ruff
check "pytest-installed" command -v pytest
check "java-installed" command -v java
check "java-version" java -version

# Report result
reportResults
