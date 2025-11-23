FROM mcr.microsoft.com/devcontainers/go:1-1.24-bookworm AS base

RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install --no-install-recommends build-essential pipx wget curl \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Install Hugo via apt
RUN wget -q https://github.com/gohugoio/hugo/releases/download/v0.152.2/hugo_extended_0.152.2_linux-amd64.deb \
    && dpkg -i hugo_extended_0.152.2_linux-amd64.deb \
    && rm hugo_extended_0.152.2_linux-amd64.deb

# Install Node.js LTS
RUN curl -fsSL https://deb.nodesource.com/setup_lts.x | bash - \
    && apt-get install -y nodejs \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Stage 2: Ferramentas auxiliares (pode mudar sem rebuild do base)
FROM base AS dev

# Install Node.js tools for linting and spell checking (as root)
RUN npm install -g \
    cspell@latest \
    markdownlint-cli@latest \
    @cspell/dict-software-terms \
    @cspell/dict-companies \
    @cspell/dict-fullstack \
    @cspell/dict-public-licenses \
    @cspell/dict-pt-br

USER vscode

# Install pre-commit
RUN pipx install pre-commit
RUN pipx ensurepath

USER root
