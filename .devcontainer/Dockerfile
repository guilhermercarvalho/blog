FROM mcr.microsoft.com/devcontainers/go:1-1.23-bookworm

RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install --no-install-recommends build-essential

USER vscode
RUN CGO_ENABLED=1 go install -tags extended github.com/gohugoio/hugo@latest
USER root

# RUN su vscode -c "source /usr/local/share/nvm/nvm.sh && npm install -g cspell" 2>&1
# npm i -g @cspell/dict-software-terms @cspell/dict-companies @cspell/dict-fullstack @cspell/dict-public-licenses
