# Guia de Pre-commit Hooks

## Instalação

### 1. Instalar pre-commit

```bash
# Via pip
pip install pre-commit

# Via homebrew (macOS)
brew install pre-commit

# Via apt (Debian/Ubuntu)
sudo apt install pre-commit
```

### 2. Instalar hooks no repositório

```bash
cd /workspaces/grc-blog
pre-commit install
```

Isso configura os hooks para rodar automaticamente em cada `git commit`.

---

## Hooks Configurados

### 🔍 1. **Markdown Linting**

- **Tool**: markdownlint-cli
- **Propósito**: Garante formatação consistente de Markdown
- **Arquivos**: `content/**/*.md`
- **Config**: `.markdownlint.json`

**Regras principais:**

- Linhas máximo 120 caracteres (exceto código/tabelas)
- Headers incrementais (H1 → H2 → H3)
- Listas com formatação consistente
- Permite HTML específico (img, figure, etc)

### ✅ 2. **Spell Checking (CSpell)**

- **Tool**: cspell
- **Propósito**: Verifica ortografia em Markdown
- **Config**: `cspell.config.yaml`
- **Dicionários**: Software terms, companies, fullstack, pt-br

**Adicionar palavras customizadas:**

```yaml
# cspell.config.yaml
words:
  - Obsidian
  - DevOps
```

### 🔧 3. **General File Checks**

- **Tool**: pre-commit-hooks (oficial)
- **Propósito**: Validações básicas de qualidade de código

**Checks incluídos:**

- ✂️ **Trailing whitespace**: Remove espaços no fim das linhas
- 📄 **End of file fixer**: Garante newline no final
- 📦 **YAML syntax**: Valida arquivos .yaml/.yml
- 📏 **Large files**: Bloqueia arquivos > 2MB
- 🔀 **Line endings**: Normaliza para LF (Unix)
- ⚔️ **Merge conflicts**: Detecta marcadores `<<<<<<<`
- 🔑 **Private keys**: Detecta chaves privadas acidentais

### 🏗️ 4. **Hugo Build Test**

- **Propósito**: Testa se o site compila sem erros
- **Comando**: `hugo --buildDrafts --buildFuture`
- **Roda**: Sempre (não depende de arquivos específicos)

**Detecta:**

- Erros de sintaxe no Hugo
- Templates quebrados
- Shortcodes inválidos
- Problemas de configuração

### 📋 5. **Front Matter Validation**

- **Propósito**: Valida estrutura YAML do front matter
- **Verifica**:
  - Front matter existe (`---` delimitadores)
  - YAML é válido (parseable)
  - Campos obrigatórios presentes

**Campos obrigatórios em posts:**

- `title`
- `date`
- `description`

### 📝 6. **Required Front Matter Fields**

- **Propósito**: Garante campos obrigatórios em posts
- **Arquivos**: `content/posts/**/*.md`
- **Campos verificados**: title, date, description

---

## Uso

### Commit normal (automático)

```bash
git add .
git commit -m "feat: novo post sobre Docker"
# Hooks rodam automaticamente
```

### Rodar manualmente em todos os arquivos

```bash
pre-commit run --all-files
```

### Rodar hook específico

```bash
pre-commit run markdownlint
pre-commit run cspell
pre-commit run hugo-build
pre-commit run validate-frontmatter
pre-commit run required-frontmatter-fields
```

### Rodar apenas em arquivos staged

```bash
pre-commit run
```

### Pular hooks (não recomendado)

```bash
git commit -m "wip" --no-verify
```

---

## Troubleshooting

### Hook falha: "markdownlint not found" ou "cspell not found"

Essas ferramentas devem estar instaladas no devcontainer. Se não estiverem:

```bash
# Rebuildar o devcontainer
# Ou instalar manualmente (temporário)
npm install -g markdownlint-cli cspell
```

### Hugo build falha com "module not found"

```bash
# Atualizar módulos Hugo
hugo mod get -u
```

### Front matter validation falha

**Problema comum**: YAML inválido

```yaml
# ❌ Errado
tags: Backend, DevOps

# ✅ Correto
tags:
  - Backend
  - DevOps
```

### CSpell reporta palavras válidas

Adicione ao `cspell.config.yaml`:

```yaml
words:
  - kubernetes
  - microservices
```

### Muitos erros de Markdown

**Opção 1**: Corrigir manualmente
**Opção 2**: Auto-fix (quando disponível)

```bash
markdownlint --fix content/**/*.md
```

### Trailing whitespace sendo adicionado por editor

Configure seu editor para não adicionar whitespace:

```json
// VSCode settings.json
"files.trimTrailingWhitespace": true
```

---

## Desabilitar Hooks Temporariamente

### Para todo o repositório

```bash
pre-commit uninstall
```

### Re-habilitar

```bash
pre-commit install
```

---

## CI/CD Integration

Os mesmos checks rodam no GitHub Actions:

```yaml
# .github/workflows/pre-commit.yml
- name: Run pre-commit
  uses: pre-commit/action@v3.0.1
```

---

## Boas Práticas

### ✅ DO

- Rode `pre-commit run --all-files` após mudanças na config
- Adicione palavras ao dicionário CSpell quando apropriado
- Mantenha descrições de commit claras
- Corrija erros ao invés de usar `--no-verify`

### ❌ DON'T

- Não commite com `--no-verify` sem motivo forte
- Não adicione arquivos grandes (use Git LFS)
- Não ignore erros de validação de front matter
- Não desabilite hooks permanentemente

---

## Atualizando Hooks

```bash
# Atualizar versões das dependências
pre-commit autoupdate

# Rodar após atualização
pre-commit run --all-files
```

---

## Debugging

### Ver saída detalhada

```bash
pre-commit run --verbose --all-files
```

### Testar hook específico em arquivo

```bash
pre-commit run hugo-build --files content/posts/exemplo.md
```

### Listar hooks instalados

```bash
pre-commit run --all-files --show-diff-on-failure
```

---

## Contribuindo

Se adicionar novos hooks:

1. Documente neste guia
2. Adicione exemplos de uso
3. Teste com `pre-commit run --all-files`
4. Atualize CI/CD se necessário
