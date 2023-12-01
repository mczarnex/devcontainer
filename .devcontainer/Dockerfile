ARG VARIANT="jammy"
FROM ubuntu:${VARIANT}

ENV LC_ALL="en_US.UTF-8"
# exa jless gh
RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install --no-install-recommends curl wget ca-certificates git tmux zsh ssh vim bind9-dnsutils gnupg2 dirmngr coreutils unzip locales python3 python3-pip\
    && locale-gen en_US.UTF-8 && update-locale LANG=en_US.UTF-8 \
    && rm -rf /var/lib/apt/lists/*

#ARG USER=vscode
ARG USER=vscode
ARG UID=1000
ARG GID=${UID}
ARG USER_HOME=/home/${USER}

RUN groupadd -g ${GID} ${USER} \
    && useradd -d ${USER_HOME} -u ${UID} -g ${GID} -l -m -s /usr/bin/zsh ${USER}

RUN chgrp -R 0 ${USER_HOME} && \
    chmod -R g=u ${USER_HOME}

ARG TOOLS_TMP=/tmp/tools
ARG TFSEC_VER=1.28.1
ARG TFDOC_VER=0.16.0
ARG TFLINT_VER=0.49.0
#ARG LSD_VER=1.0.0
ARG LSD_VER=0.23.1
RUN mkdir -m a=rwx -p ${TOOLS_TMP} && cd ${TOOLS_TMP} \
    && curl -sSL https://github.com/aquasecurity/tfsec/releases/download/v${TFSEC_VER}/tfsec_${TFSEC_VER}_linux_amd64.tar.gz -o tfsec.tar.gz \
    && curl -sSL https://github.com/terraform-docs/terraform-docs/releases/download/v${TFDOC_VER}/terraform-docs-v${TFDOC_VER}-linux-amd64.tar.gz -o tfdocs.tar.gz \
    && curl -sSL https://github.com/terraform-linters/tflint/releases/download/v${TFLINT_VER}/tflint_linux_amd64.zip -o tflint.zip \
    && curl -sSL https://github.com/lsd-rs/lsd/releases/download/v${LSD_VER}/lsd_${LSD_VER}_amd64.deb -o lsd.deb \
    && mkdir ./tfsec && tar vxzf tfsec.tar.gz -C tfsec && chmod a+x ./tfsec/tfsec && mv -f ./tfsec/tfsec /usr/local/bin/tfsec \
    && mkdir ./tfdocs && tar vxzf tfdocs.tar.gz -C tfdocs && chmod a+x ./tfdocs/terraform-docs && mv -f ./tfdocs/terraform-docs /usr/local/bin/terraform-docs \
    && unzip tflint.zip -d tflint && chmod a+x ./tflint/tflint && mv -f ./tflint/tflint /usr/local/bin/tflint \
    && dpkg -i lsd.deb

USER ${UID}

#RUN echo "export PATH=\$PATH:${USER_HOME}/.local/bin:${USER_HOME}/.tfenv/bin" >> ${USER_HOME}/.zshenv
RUN echo "export PATH=\$PATH:${USER_HOME}/.local/bin:${USER_HOME}/.tfenv/bin" >> ${USER_HOME}/.zshrc

ARG TFENV_VER=3.0.0
RUN curl -sSL https://github.com/tfutils/tfenv/archive/refs/tags/v${TFENV_VER}.zip -o ${TOOLS_TMP}/tfenv.zip \
    && unzip ${TOOLS_TMP}/tfenv.zip -d ${USER_HOME} \
    && mv ${USER_HOME}/tfenv-${TFENV_VER} ${USER_HOME}/.tfenv

ARG TF_VER="1.6.4"
RUN ${USER_HOME}/.tfenv/bin/tfenv install ${TF_VER} \
    && ${USER_HOME}/.tfenv/bin/tfenv use ${TF_VER}

RUN pip install --upgrade pip ansible ansible-lint pre-commit --user

RUN git clone https://github.com/zsh-users/antigen.git ${USER_HOME}/antigen \
    && git clone --depth 1 https://github.com/junegunn/fzf.git ${USER_HOME}/.fzf \
    && ${USER_HOME}/.fzf/install --all

COPY --chown=${UID}:${GID} --chmod=644 .zshrc ${USER_HOME}/.zshrc
COPY --chown=${UID}:${GID} --chmod=644 p10k-lean.zsh ${USER_HOME}/.p10k.zsh
#COPY --chown=${UID}:${GID} --chmod=644 p10k-classic.zsh ${USER_HOME}/.p10k.zsh

WORKDIR ${USER_HOME}

SHELL ["/usr/bin/zsh", "-c"]

RUN source ${USER_HOME}/.zshrc
#RUN ["/usr/bin/zsh", "-c", "source ${USER_HOME}/.zshrc"]
