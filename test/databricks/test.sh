#!/bin/bash
cd $(dirname "$0")
source test-utils.sh

# Template specific tests
check "python-installed" command -v python
check "python-version" python --version
check "pip-installed" command -v pip
check "databricks-cli-installed" command -v databricks
check "databricks-cli-version" databricks --version
check "pyspark-installed" python -c "import pyspark; print(pyspark.__version__)"
check "pandas-installed" python -c "import pandas; print(pandas.__version__)"
check "numpy-installed" python -c "import numpy; print(numpy.__version__)"
check "pyarrow-installed" python -c "import pyarrow; print(pyarrow.__version__)"
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
