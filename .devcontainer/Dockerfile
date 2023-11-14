ARG VARIANT="focal"
FROM amr-registry.caas.intel.com/owr/abi_lnx:3.0.0

ENV LC_ALL="en_US.UTF-8"

RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install --no-install-recommends curl wget ca-certificates git zsh ssh vim bind9-dnsutils gnupg2 dirmngr coreutils unzip locales \
    && rm -rf /var/lib/apt/lists/*

ARG USER=vscode
ARG UID=1000
ARG GID=${UID}
ARG USER_HOME=/home/vscode

RUN groupadd -g ${GID} ${USER} \
    && useradd -d ${USER_HOME} -u ${UID} -g ${GID} -l -m -s /usr/bin/zsh ${USER}

RUN chgrp -R 0 ${USER_HOME} && \
    chmod -R g=s ${USER_HOME}

USER ${UID}

RUN echo "export PATH=\$PATH:$USER_HOME/.local/bin" >> ${USER_HOME}/.zshenv

RUN pip install --upgrade pip ansible ansible-lint pre-commit

RUN git clone https://github.com/zsh-users/antigen.git ${USER_HOME}/antigen \
    && git clone --depth 1 https://github.com/junegunn/fzf.git ${USER_HOME}/.fzf \
    && ${USER_HOME}/.fzf/install --all

COPY --chown=${UID}:${GID} --chmod=644 .zshrc ${USER_HOME}/.zshrc
COPY --chown=${UID}:${GID} --chmod=644 .p10k.zsh ${USER_HOME}/.p10k.zsh

WORKDIR ${USER_HOME}

SHELL ["/usr/bin/zsh", "-c"]

RUN source ${USER_HOME}/.zshrc