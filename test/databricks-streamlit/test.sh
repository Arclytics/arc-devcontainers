#!/bin/bash
cd $(dirname "$0")
source test-utils.sh

# Template specific tests
check "python-installed" command -v python
check "python-version" python --version
check "pip-installed" command -v pip
check "databricks-cli-installed" command -v databricks
check "databricks-cli-version" databricks --version
check "streamlit-installed" command -v streamlit
check "streamlit-version" streamlit --version
check "pandas-installed" python -c "import pandas; print(pandas.__version__)"
check "numpy-installed" python -c "import numpy; print(numpy.__version__)"
check "plotly-installed" python -c "import plotly; print(plotly.__version__)"
check "altair-installed" python -c "import altair; print(altair.__version__)"
check "matplotlib-installed" python -c "import matplotlib; print(matplotlib.__version__)"
check "seaborn-installed" python -c "import seaborn; print(seaborn.__version__)"
check "pyarrow-installed" python -c "import pyarrow; print(pyarrow.__version__)"
check "zsh-installed" command -v zsh
check "oh-my-zsh-installed" [ -d "$HOME/.oh-my-zsh" ]
check "azure-cli-installed" command -v az
check "pre-commit-installed" command -v pre-commit
check "ruff-installed" command -v ruff
check "pytest-installed" command -v pytest

# Report result
reportResults
