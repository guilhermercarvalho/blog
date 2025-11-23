# Guilherme Carvalho Blog

[![Hugo](https://img.shields.io/badge/Hugo-0.140.0+-FF4088?style=flat&logo=hugo)](https://gohugo.io/)
[![Theme](https://img.shields.io/badge/Theme-Ananke-blue)](https://github.com/theNewDynamic/gohugo-theme-ananke)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

Blog técnico pessoal focado em desenvolvimento backend, boas práticas de engenharia de software, produtividade e compartilhamento de experiências profissionais.

🌐 **Site:** [https://guilhermercarvalho.github.io/blog/](https://guilhermercarvalho.github.io/blog/)

## 📋 Visão Geral

Este projeto é um blog estático construído com **Hugo**, utilizando o tema **Ananke**. O conteúdo é focado em:

- 🔧 **Desenvolvimento Backend**: Node.js, TypeScript, APIs RESTful
- 🏗️ **Arquitetura de Software**: SOLID, design patterns, microsserviços
- 🚀 **DevOps & CI/CD**: GitHub Actions, automação, deploy
- 📊 **Produtividade**: Ferramentas, metodologias e gestão de tempo
- 🔄 **Refatoração**: Melhoria contínua de código legado
- 📚 **Documentação Técnica**: Boas práticas e ferramentas

### Características

- ✅ Geração de site estático com Hugo
- ✅ Deploy automático via GitHub Actions
- ✅ Suporte bilíngue (Português/Inglês)
- ✅ Otimização de imagens automática
- ✅ SEO-friendly com sitemap e robots.txt
- ✅ Verificação ortográfica com CSpell
- ✅ Pre-commit hooks para qualidade de código

## 🚀 Setup Local

### Pré-requisitos

- **Hugo Extended** >= 0.152.2
- **Git** >= 2.30
- **Node.js** >= 18.x (para ferramentas de desenvolvimento)
- **Python** >= 3.8 (para pre-commit hooks)
- **Go** >= 1.21 (opcional, para módulos Hugo)

#### Instalação do Hugo

```bash
# macOS
brew install hugo

# Linux (Debian/Ubuntu)
sudo apt install hugo

# Ou via snap
sudo snap install hugo

# Windows (via Chocolatey)
choco install hugo-extended

# Verificar instalação
hugo version
```

#### Instalação do Pre-commit

```bash
# Via pip
pip install pre-commit

# Via homebrew
brew install pre-commit

# Via apt
sudo apt install pre-commit
```

### Instalação do Projeto

```bash
# 1. Clonar o repositório
git clone https://github.com/guilhermercarvalho/blog.git
cd blog

# 2. Inicializar submódulos (tema)
git submodule update --init --recursive

# 3. Instalar pre-commit hooks
pre-commit install

# 4. (Opcional) Instalar dependências Node.js para ferramentas
npm install -g markdownlint-cli cspell
```

## 🛠️ Comandos de Desenvolvimento

### Servidor Local

```bash
# Iniciar servidor de desenvolvimento
hugo server

# Com rascunhos e conteúdo futuro
hugo server --buildDrafts --buildFuture

# Com live reload e navegação rápida
hugo server -D -F --navigateToChanged

# Servidor acessível na rede local
hugo server --bind 0.0.0.0 --baseURL http://192.168.1.x
```

Acesse: [http://localhost:1313/blog/](http://localhost:1313/blog/)

### Build

```bash
# Build de produção
hugo

# Build com limpeza do diretório de destino
hugo --cleanDestinationDir

# Build incluindo rascunhos
hugo --buildDrafts

# Build com minificação
hugo --minify
```

### Criação de Conteúdo

```bash
# Criar novo post
hugo new posts/nome-do-post.md

# Criar página
hugo new about.md

# Usar archetype customizado
hugo new --kind post posts/meu-post.md
```

### Qualidade de Código

```bash
# Rodar pre-commit em todos os arquivos
pre-commit run --all-files

# Rodar hook específico
pre-commit run markdownlint --all-files
pre-commit run cspell --all-files
pre-commit run hugo-build

# Verificar ortografia manualmente
cspell "content/**/*.md"

# Lint de Markdown
markdownlint content/**/*.md
```

### Git Workflow

```bash
# Os hooks rodam automaticamente no commit
git add .
git commit -m "feat: adiciona novo post sobre TypeScript"

# Push aciona deploy automático
git push origin main
```

## 📁 Estrutura de Arquivos

```
.
├── .github/
│   └── workflows/
│       └── deploy.yml           # CI/CD para GitHub Pages
├── .devcontainer/               # Dev container configuration
├── archetypes/
│   └── default.md               # Template para novos posts
├── assets/
│   └── images/                  # Imagens originais (processadas pelo Hugo)
│       ├── covers/              # Capas de posts
│       ├── icons/               # Ícones e logos
│       └── posts/               # Imagens específicas de posts
├── content/
│   ├── _index.md                # Página inicial
│   ├── about.md                 # Sobre mim
│   └── posts/                   # Posts do blog
│       ├── post-1.md
│       └── post-2.md
├── data/                        # Dados estruturados (JSON/YAML/TOML)
├── i18n/                        # Traduções
├── layouts/
│   ├── _default/                # Layouts padrão
│   ├── partials/                # Componentes reutilizáveis
│   ├── shortcodes/              # Shortcodes customizados
│   │   ├── figure.html
│   │   └── img.html
│   └── post/                    # Layout específico de posts
├── public/                      # Site gerado (ignorado no Git)
├── resources/                   # Cache de recursos processados
├── static/
│   └── images/                  # Imagens estáticas (copiadas sem processamento)
├── themes/
│   └── ananke/                  # Tema Hugo (submódulo)
├── .markdownlint.json           # Config do Markdownlint
├── .pre-commit-config.yaml      # Hooks de pre-commit
├── cspell.config.yaml           # Config do spell checker
├── hugo.toml                    # Configuração do Hugo
├── IMAGES-GUIDE.md              # Guia de imagens
├── PRE-COMMIT-GUIDE.md          # Guia de pre-commit
└── README.md                    # Este arquivo
```

### Diretórios Principais

- **`content/`**: Todo o conteúdo Markdown do blog
- **`assets/`**: Assets processados pelo Hugo (imagens, SCSS)
- **`static/`**: Arquivos estáticos copiados diretamente para `public/`
- **`layouts/`**: Templates HTML personalizados
- **`themes/`**: Tema Hugo (gerenciado como Git submodule)
- **`public/`**: Site compilado (gerado automaticamente)

## 📝 Guidelines de Conteúdo

### Estrutura de um Post

Todo post deve ter front matter obrigatório:

```yaml
---
title: "Título do Post"
date: 2025-02-24T09:30:00-03:00
author: Guilherme Carvalho
description: "Descrição curta (150-160 caracteres) para SEO"
featured_image: /images/covers/nome-da-imagem.jpg
categories:
  - Categoria Principal
tags:
  - Tag 1
  - Tag 2
  - Tag 3
excerpt: "Resumo do post (2-3 frases)"
draft: false
keywords:
  - palavra-chave 1
  - palavra-chave 2
---

Conteúdo do post em Markdown...
```

### Campos Obrigatórios

- ✅ `title`: Título claro e descritivo
- ✅ `date`: Data no formato ISO 8601
- ✅ `description`: 150-160 caracteres para SEO
- ✅ `categories`: Pelo menos uma categoria
- ✅ `tags`: 3-5 tags relevantes
- ✅ `draft`: `false` para publicar, `true` para rascunho

### Boas Práticas de Escrita

1. **Títulos**: Use H3 (`###`) para seções principais dentro do post
2. **Imagens**: Sempre adicione texto alternativo para acessibilidade
3. **Links**: Use links relativos para conteúdo interno
4. **Código**: Use blocos de código com syntax highlighting
5. **Listas**: Prefira listas numeradas para passos sequenciais
6. **Ortografia**: Execute `cspell` antes de commitar

### Exemplo de Código

````markdown
```typescript
interface User {
  id: string;
  name: string;
  email: string;
}

const createUser = (data: User): void => {
  console.log(`Creating user: ${data.name}`);
};
```
````

### Shortcodes Disponíveis

```markdown
<!-- Imagem com legenda -->
{{< figure src="/images/posts/exemplo.jpg" alt="Descrição" caption="Legenda" >}}

<!-- Imagem responsiva customizada -->
{{< img src="/images/posts/exemplo.jpg" alt="Descrição" width="800" >}}
```

### Categorias Principais

- **Carreira**: Crescimento profissional, experiências
- **Desenvolvimento Backend**: Node.js, APIs, arquitetura
- **DevOps**: CI/CD, automação, infraestrutura
- **Produtividade**: Ferramentas, metodologias
- **Tutoriais**: Guias passo a passo

### Tags Sugeridas

Use tags específicas e relevantes:

- Tecnologias: `TypeScript`, `Node.js`, `Docker`
- Conceitos: `SOLID`, `Clean Code`, `Refatoração`
- Ferramentas: `GitHub Actions`, `Hugo`, `Obsidian`
- Soft Skills: `Gestão de Tempo`, `Produtividade`

## 🔍 Verificações Automáticas

Os pre-commit hooks garantem qualidade antes do commit:

1. **Markdown Linting**: Formatação consistente
2. **Spell Checking**: Ortografia em PT-BR e EN
3. **Hugo Build**: Build sem erros
4. **Front Matter**: Validação de campos obrigatórios
5. **File Checks**: Trailing whitespace, EOF, YAML syntax

Para mais detalhes, veja [PRE-COMMIT-GUIDE.md](PRE-COMMIT-GUIDE.md).

## 🖼️ Gestão de Imagens

- **Formato**: Prefira WebP ou JPEG otimizado
- **Resolução**: 1200x630px para featured images
- **Tamanho**: Máximo 500KB por imagem
- **Localização**: `assets/images/` para processamento automático

Para guia completo, veja [IMAGES-GUIDE.md](IMAGES-GUIDE.md).

## 🚢 Deploy

O site é automaticamente deployado para GitHub Pages quando há push na branch `main`:

1. GitHub Actions executa o workflow
2. Hugo build é executado
3. Arquivos são publicados em `gh-pages`
4. Site disponível em poucos minutos

Veja o workflow em [`.github/workflows/deploy.yml`](.github/workflows/deploy.yml).

## 📄 Licença

Este projeto está sob a licença MIT. Veja o arquivo [LICENSE](LICENSE) para mais detalhes.

## 👤 Autor

**Guilherme Carvalho**

- GitHub: [@guilhermercarvalho](https://github.com/guilhermercarvalho)
- Blog: [guilhermercarvalho.github.io/blog](https://guilhermercarvalho.github.io/blog/)

---

⭐ Se este projeto foi útil, considere dar uma estrela no repositório!
