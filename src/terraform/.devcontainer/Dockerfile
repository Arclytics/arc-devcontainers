FROM mcr.microsoft.com/vscode/devcontainers/base:ubuntu-22.04

ARG TFSWITCH_VERSION=1.2.4
ARG TFLINT_VERSION=v0.54.0

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
    && echo 'plugins=(git azure terraform docker)' >> /home/${USERNAME}/.zshrc \
    && echo '' >> /home/${USERNAME}/.zshrc \
    && echo '# Set the zsh history file location' >> /home/${USERNAME}/.zshrc \
    && echo 'export HISTFILE=/workspaces/$(ls /workspaces/ 2>/dev/null | head -n 1)/.devcontainer/.zsh_history 2>/dev/null || export HISTFILE=$HOME/.zsh_history' >> /home/${USERNAME}/.zshrc \
    && echo '' >> /home/${USERNAME}/.zshrc \
    && echo 'source $ZSH/oh-my-zsh.sh' >> /home/${USERNAME}/.zshrc \
    && echo '' >> /home/${USERNAME}/.zshrc \
    && echo 'autoload -U +X bashcompinit && bashcompinit' >> /home/${USERNAME}/.zshrc

# Install tfswitch
ENV PATH=$PATH:/home/${USERNAME}/bin
RUN curl -L https://raw.githubusercontent.com/warrensbox/terraform-switcher/master/install.sh | bash -s -- -b /home/${USERNAME}/bin ${TFSWITCH_VERSION}

# Install tflint
RUN curl -s https://raw.githubusercontent.com/terraform-linters/tflint/${TFLINT_VERSION}/install_linux.sh | bash
