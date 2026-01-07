FROM mcr.microsoft.com/vscode/devcontainers/base:ubuntu-22.04

ARG JAVA_VERSION=21
ARG MAVEN_VERSION=3.9
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
    && echo 'plugins=(git azure mvn docker kubectl)' >> /home/${USERNAME}/.zshrc \
    && echo '' >> /home/${USERNAME}/.zshrc \
    && echo '# Set the zsh history file location' >> /home/${USERNAME}/.zshrc \
    && echo 'export HISTFILE=/workspaces/$(ls /workspaces/ 2>/dev/null | head -n 1)/.devcontainer/.zsh_history 2>/dev/null || export HISTFILE=$HOME/.zsh_history' >> /home/${USERNAME}/.zshrc \
    && echo '' >> /home/${USERNAME}/.zshrc \
    && echo 'source $ZSH/oh-my-zsh.sh' >> /home/${USERNAME}/.zshrc \
    && echo '' >> /home/${USERNAME}/.zshrc \
    && echo 'autoload -U +X bashcompinit && bashcompinit' >> /home/${USERNAME}/.zshrc

# Set environment for Java and Maven
ENV JAVA_HOME=/usr/lib/jvm/msopenjdk-${JAVA_VERSION}
ENV MAVEN_HOME=/usr/share/maven
ENV PATH="${JAVA_HOME}/bin:${MAVEN_HOME}/bin:${PATH}"
