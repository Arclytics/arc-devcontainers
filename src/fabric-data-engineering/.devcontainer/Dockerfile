FROM mcr.microsoft.com/vscode/devcontainers/python:${templateOption:pythonVersion}

ARG FABRIC_CLI_VERSION=${templateOption:fabricCLIVersion}
ARG INSTALL_SPARK_LOCALLY=${templateOption:installSparkLocally}
ARG USERNAME=vscode

USER ${USERNAME}

# Install and configure zsh
RUN sudo apt-get update && sudo apt-get install -y zsh openjdk-21-jdk-headless \
    && sudo rm -rf /var/lib/apt/lists/*

ENV SHELL=/bin/zsh
ENV JAVA_HOME=/usr/lib/jvm/java-21-openjdk-amd64

# Install oh-my-zsh
RUN wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh || true

# Configure .zshrc
RUN echo 'export ZSH="$HOME/.oh-my-zsh"' > /home/${USERNAME}/.zshrc \
    && echo '' >> /home/${USERNAME}/.zshrc \
    && echo 'ZSH_THEME="robbyrussell"' >> /home/${USERNAME}/.zshrc \
    && echo '' >> /home/${USERNAME}/.zshrc \
    && echo 'plugins=(git python pip docker)' >> /home/${USERNAME}/.zshrc \
    && echo '' >> /home/${USERNAME}/.zshrc \
    && echo '# Set the zsh history file location' >> /home/${USERNAME}/.zshrc \
    && echo 'export HISTFILE=/workspaces/$(ls /workspaces/ 2>/dev/null | head -n 1)/.devcontainer/.zsh_history 2>/dev/null || export HISTFILE=$HOME/.zsh_history' >> /home/${USERNAME}/.zshrc \
    && echo '' >> /home/${USERNAME}/.zshrc \
    && echo 'source $ZSH/oh-my-zsh.sh' >> /home/${USERNAME}/.zshrc \
    && echo '' >> /home/${USERNAME}/.zshrc \
    && echo 'autoload -U +X bashcompinit && bashcompinit' >> /home/${USERNAME}/.zshrc

# Install Microsoft Fabric CLI
RUN if [ "${FABRIC_CLI_VERSION}" = "latest" ]; then \
        pip install --user --trusted-host pypi.org --trusted-host files.pythonhosted.org ms-fabric-cli; \
    else \
        pip install --user --trusted-host pypi.org --trusted-host files.pythonhosted.org ms-fabric-cli==${FABRIC_CLI_VERSION}; \
    fi

# Install PySpark and common data science libraries
RUN pip install --user --trusted-host pypi.org --trusted-host files.pythonhosted.org pyspark pandas numpy pyarrow polars duckdb

# Install Fabric Data Agent SDK and other Fabric-related packages
RUN pip install --user --trusted-host pypi.org --trusted-host files.pythonhosted.org fabric-data-agent-sdk azure-identity

# Optionally install Apache Spark locally
RUN if [ "${INSTALL_SPARK_LOCALLY}" = "true" ]; then \
        SPARK_VERSION=3.5.0 && \
        HADOOP_VERSION=3 && \
        cd /tmp && \
        wget -q https://archive.apache.org/dist/spark/spark-${SPARK_VERSION}/spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz && \
        sudo tar -xzf spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz -C /opt && \
        sudo mv /opt/spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION} /opt/spark && \
        rm spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz && \
        echo 'export SPARK_HOME=/opt/spark' >> /home/${USERNAME}/.zshrc && \
        echo 'export PATH=$PATH:$SPARK_HOME/bin' >> /home/${USERNAME}/.zshrc; \
    fi

# Add user bin to PATH
ENV PATH=$PATH:/home/${USERNAME}/.local/bin
