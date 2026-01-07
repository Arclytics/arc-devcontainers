FROM mcr.microsoft.com/vscode/devcontainers/python:${templateOption:pythonVersion}

ARG DATABRICKS_CLI_VERSION=${templateOption:databricksCLIVersion}
ARG STREAMLIT_VERSION=${templateOption:streamlitVersion}
ARG USERNAME=vscode

USER ${USERNAME}

# Install and configure zsh
RUN sudo apt-get update && sudo apt-get install -y zsh \
    && sudo rm -rf /var/lib/apt/lists/*

ENV SHELL /bin/zsh

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

# Install Databricks CLI
RUN pip install --user databricks-cli==${DATABRICKS_CLI_VERSION}

# Install Streamlit and common data science libraries
RUN pip install --user streamlit==${STREAMLIT_VERSION} \
    pandas \
    numpy \
    plotly \
    altair \
    matplotlib \
    seaborn \
    pyarrow

# Add user bin to PATH
ENV PATH=$PATH:/home/${USERNAME}/.local/bin
