FROM mcr.microsoft.com/devcontainers/base:jammy

ARG HUGO_VERSION=0.159.2
ARG HUGO_ARCH=linux-amd64
ARG HUGO_FILENAME=hugo_extended_${HUGO_VERSION}_${HUGO_ARCH}.deb

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        wget \
        curl \
        ca-certificates \
        python3-pip \
        python3-venv \
        python3-setuptools \
        python3-wheel && \
    # Instala o Hugo Extended
    wget -q "https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/${HUGO_FILENAME}" && \
    dpkg -i ${HUGO_FILENAME} && \
    rm ${HUGO_FILENAME} && \
    # Instala o pipx
    python3 -m pip install --no-cache-dir pipx && \
    # Limpa o cache do apt
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
