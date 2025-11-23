# Guia de Monitoramento do Blog

Este guia documenta todas as ferramentas de monitoramento configuradas para o blog, incluindo analytics, SEO, broken links e performance.

## 📊 Visão Geral

O blog possui as seguintes ferramentas de monitoramento configuradas:

- 🔍 **Google Search Console**: Monitoramento de indexação e SEO
- 📈 **Google Analytics 4**: Análise de tráfego e comportamento dos usuários
- 🔗 **Broken Links Monitor**: Verificação automática de links quebrados
- ⚡ **Performance Auditing**: Lighthouse CI e PageSpeed Insights

---

## 🔍 Google Search Console

### Configuração Inicial

1. **Acesse o Google Search Console**
   - URL: [https://search.google.com/search-console](https://search.google.com/search-console)
   - Faça login com sua conta Google

2. **Adicione a propriedade**
   - Clique em "Adicionar propriedade"
   - Escolha "Prefixo de URL": `https://guilhermercarvalho.github.io/blog/`

3. **Verificação via meta tag**
   - Escolha o método "Tag HTML"
   - Copie o código de verificação (formato: `google-site-verification: XXXXXXXX`)
   - Adicione ao `hugo.toml`:

   ```toml
   [params]
   google_site_verification = "XXXXXXXX"  # Cole aqui o código
   ```

4. **Deploy e verifique**
   - Faça push das alterações
   - Aguarde o deploy no GitHub Pages
   - Clique em "Verificar" no Google Search Console

### Recursos Disponíveis

- **Desempenho**: Cliques, impressões, CTR, posição média
- **Cobertura**: Páginas indexadas, erros de rastreamento
- **Melhorias**: Core Web Vitals, usabilidade móvel
- **Sitemap**: `https://guilhermercarvalho.github.io/blog/sitemap.xml`

### Configurações Recomendadas

```bash
# Enviar sitemap manualmente (opcional)
# O sitemap já é enviado automaticamente via robots.txt
```

**Robots.txt location**: `/static/robots.txt` (gerado automaticamente pelo Hugo)

---

## 📈 Google Analytics 4

### Configuração Inicial

1. **Criar conta e propriedade**
   - Acesse: [https://analytics.google.com](https://analytics.google.com)
   - Crie uma nova propriedade GA4
   - Nome: "Guilherme Carvalho Blog"
   - Fuso horário: America/Sao_Paulo
   - Moeda: BRL

2. **Obter o Measurement ID**
   - Vá em "Admin" → "Fluxos de dados"
   - Clique em "Adicionar fluxo" → "Web"
   - URL: `https://guilhermercarvalho.github.io/blog/`
   - Nome do fluxo: "Blog Production"
   - Copie o **Measurement ID** (formato: `G-XXXXXXXXXX`)

3. **Adicionar ao hugo.toml**

   ```toml
   [params]
   googleAnalytics = "G-XXXXXXXXXX"  # Cole aqui seu Measurement ID
   ```

4. **Deploy**
   - Faça push das alterações
   - Aguarde o deploy
   - Verifique em GA4 → Relatórios → Tempo real (pode levar alguns minutos)

### Eventos Rastreados

O blog rastreia automaticamente:

✅ **Eventos Padrão (GA4)**

- `page_view`: Visualizações de página
- `scroll`: Rolagem de página (90%)
- `click`: Cliques em links externos
- `file_download`: Downloads de arquivos

✅ **Core Web Vitals (Customizado)**

- `CLS`: Cumulative Layout Shift
- `FID`: First Input Delay
- `LCP`: Largest Contentful Paint
- `FCP`: First Contentful Paint
- `TTFB`: Time to First Byte

### Configurações de Privacidade

O código implementa:

- ✅ Anonimização de IP (`anonymize_ip: true`)
- ✅ Cookies seguros (`SameSite=None;Secure`)
- ✅ Apenas em produção (não em localhost)
- ✅ GDPR-compliant (com configuração manual de consent se necessário)

### Relatórios Recomendados

1. **Aquisição**: De onde vêm os visitantes
2. **Engajamento**: Páginas mais visitadas, tempo no site
3. **Eventos**: Core Web Vitals, interações
4. **Conversões**: Configure metas customizadas

---

## 🔗 Monitor de Broken Links

### Como Funciona

O workflow `.github/workflows/check-links.yaml` verifica automaticamente links quebrados:

**Quando roda:**

- ⏰ Agendado: Todo domingo às 00:00 UTC
- 📝 Push: Quando arquivos `.md` em `content/` são modificados
- 🔧 Manual: Via GitHub Actions UI

**O que faz:**

1. Faz build do site com Hugo
2. Escaneia todos os arquivos HTML em `public/`
3. Verifica cada link (HTTP status, redirects, timeouts)
4. Gera relatório de links quebrados
5. Cria issue automaticamente se encontrar problemas

### Configuração

Links excluídos da verificação (configurados no workflow):

- Redes sociais (LinkedIn, Twitter, Facebook)
- Localhost e 127.0.0.1
- E-mails (mailto:)

### Como Verificar Resultados

**Via GitHub Actions:**

```bash
# Acesse: https://github.com/guilhermercarvalho/blog/actions
# Procure por "Check Broken Links"
# Clique no run mais recente
```

**Baixar Relatório:**

```bash
# Vá em: Actions → Check Broken Links → Run específico
# Scroll até "Artifacts"
# Baixe "broken-links-report"
```

**Issues Automáticas:**

- Issues são criadas automaticamente quando quebras são detectadas no agendamento semanal
- Labels: `bug`, `automated`, `broken-links`

### Executar Manualmente

```bash
# Via GitHub Actions
# 1. Vá em: Actions → Check Broken Links
# 2. Clique em "Run workflow"
# 3. Selecione branch "main"
# 4. Clique em "Run workflow"

# Localmente (com Docker)
docker run --rm -it -v $(pwd):/app lycheeverse/lychee \
  --verbose \
  --no-progress \
  --exclude linkedin.com \
  --exclude twitter.com \
  './public/**/*.html'
```

---

## ⚡ Performance Auditing

### Lighthouse CI

**Configuração**: `.lighthouserc.json`

**Quando roda:**

- ⏰ Agendado: Segunda-feira às 06:00 UTC
- 📝 Push: Em toda alteração na branch `main`
- 🔀 Pull Request: Em todos os PRs
- 🔧 Manual: Via GitHub Actions UI

**Métricas Avaliadas:**

| Métrica | Threshold | Descrição |
|---------|-----------|-----------|
| Performance | ≥ 85 | Score geral de performance |
| Accessibility | ≥ 90 | Acessibilidade e a11y |
| Best Practices | ≥ 90 | Boas práticas web |
| SEO | ≥ 90 | Otimização para motores de busca |
| FCP | < 2.0s | First Contentful Paint |
| LCP | < 2.5s | Largest Contentful Paint |
| CLS | < 0.1 | Cumulative Layout Shift |
| TBT | < 300ms | Total Blocking Time |
| Speed Index | < 3.0s | Índice de velocidade |

### PageSpeed Insights

**Auditoria automática** para mobile e desktop:

- URL: `https://guilhermercarvalho.github.io/blog/`
- Threshold mínimo: 70/100
- Estratégia: Both (mobile + desktop)

### Core Web Vitals

Métricas rastreadas via Google Analytics 4:

- **LCP** (Largest Contentful Paint): < 2.5s
- **FID** (First Input Delay): < 100ms
- **CLS** (Cumulative Layout Shift): < 0.1

### Como Interpretar Resultados

**Acessar Relatórios:**

```bash
# Via GitHub Actions
Actions → Performance Audit → Run específico → Artifacts

# Download dos relatórios
# - lighthouse-reports.zip
```

**Visualizar Lighthouse Report:**

```bash
# Após download do artifact
unzip lighthouse-reports.zip
open lighthouse-report.html  # macOS
xdg-open lighthouse-report.html  # Linux
start lighthouse-report.html  # Windows
```

### Executar Localmente

```bash
# Instalar Lighthouse CI
npm install -g @lhci/cli

# Build do site
hugo --minify

# Rodar servidor temporário
hugo server --port 1313 &

# Executar Lighthouse CI
lhci autorun --config=.lighthouserc.json

# Ver relatório
lhci open
```

### Melhorias de Performance

**Otimizações já implementadas:**

- ✅ Minificação de HTML/CSS/JS
- ✅ Lazy loading de imagens
- ✅ Compressão de imagens (WebP)
- ✅ Preconnect para serviços externos
- ✅ Cache de recursos
- ✅ CDN via GitHub Pages

**Recomendações adicionais:**

1. Usar imagens WebP sempre que possível
2. Manter posts com < 2MB de conteúdo
3. Limitar número de recursos externos
4. Usar font-display: swap para fontes
5. Implementar service worker para PWA (futuro)

---

## 📋 Checklist de Configuração

### Setup Inicial

- [ ] Configurar Google Search Console
  - [ ] Adicionar `google_site_verification` ao `hugo.toml`
  - [ ] Verificar propriedade
  - [ ] Enviar sitemap

- [ ] Configurar Google Analytics 4
  - [ ] Criar conta/propriedade GA4
  - [ ] Adicionar `googleAnalytics` ao `hugo.toml`
  - [ ] Verificar tracking em Tempo Real

- [ ] Testar Broken Links Monitor
  - [ ] Executar workflow manualmente
  - [ ] Verificar relatório gerado

- [ ] Testar Performance Audit
  - [ ] Executar workflow manualmente
  - [ ] Revisar scores do Lighthouse
  - [ ] Analisar Core Web Vitals

### Manutenção Regular

**Diário:**

- ✅ Monitorar erros de build no GitHub Actions

**Semanal:**

- ✅ Revisar broken links report (automático aos domingos)
- ✅ Verificar métricas de performance

**Mensal:**

- ✅ Analisar relatórios do Google Analytics
- ✅ Revisar Search Console para oportunidades de SEO
- ✅ Comparar métricas de performance mês a mês

**Trimestral:**

- ✅ Auditoria completa de performance
- ✅ Revisar e atualizar keywords/SEO
- ✅ Analisar taxa de conversão e engajamento

---

## 🔧 Troubleshooting

### Google Analytics não está rastreando

**Possíveis causas:**

1. `googleAnalytics` não configurado em `hugo.toml`
2. Site em desenvolvimento (não em produção)
3. Ad blockers bloqueando scripts
4. Measurement ID incorreto

**Solução:**

```bash
# 1. Verificar configuração
cat hugo.toml | grep googleAnalytics

# 2. Verificar se está em produção
hugo env | grep HUGO_ENVIRONMENT

# 3. Testar localmente (simular produção)
HUGO_ENV=production hugo server

# 4. Verificar no browser
# Abra DevTools → Network → Filtrar "google-analytics"
```

### Links quebrados falsos positivos

**Possíveis causas:**

1. Sites com rate limiting
2. Sites que bloqueiam bots
3. Timeouts temporários

**Solução:**

```yaml
# Ajustar configuração no check-links.yaml
args: |
  --max-retries 5
  --timeout 60
  --exclude 'site-problematico.com'
```

### Lighthouse scores baixos

**Possíveis causas:**

1. Imagens muito grandes
2. Muitos recursos externos
3. Bloqueio de renderização

**Solução:**

```bash
# 1. Otimizar imagens
hugo gen chromalink --source assets/images

# 2. Analisar bundle size
hugo --gc --minify --templateMetrics

# 3. Revisar recursos carregados
# Ver relatório detalhado do Lighthouse
```

---

## 📚 Recursos Adicionais

### Documentação Oficial

- [Google Search Console Help](https://support.google.com/webmasters)
- [Google Analytics 4 Documentation](https://support.google.com/analytics)
- [Web Vitals](https://web.dev/vitals/)
- [Lighthouse CI](https://github.com/GoogleChrome/lighthouse-ci)
- [Hugo Performance](https://gohugo.io/troubleshooting/build-performance/)

### Ferramentas Online

- [PageSpeed Insights](https://pagespeed.web.dev/)
- [GTmetrix](https://gtmetrix.com/)
- [WebPageTest](https://www.webpagetest.org/)
- [Broken Link Checker](https://www.brokenlinkcheck.com/)

### Dashboards Recomendados

1. **Google Analytics 4**
   - Importar template: [GA4 Blog Template](https://analytics.google.com/analytics/web/template)

2. **Looker Studio**
   - Criar dashboard customizado conectando GA4 e Search Console

3. **GitHub Actions Dashboard**
   - Visualizar todos os workflows em: `Actions` tab

---

## 🎯 Metas de Performance

### Targets Atuais

| Métrica | Target | Atual | Status |
|---------|--------|-------|--------|
| Lighthouse Performance | 85+ | - | 🔍 Medir |
| Lighthouse Accessibility | 90+ | - | 🔍 Medir |
| Lighthouse SEO | 90+ | - | 🔍 Medir |
| LCP | < 2.5s | - | 🔍 Medir |
| FID | < 100ms | - | 🔍 Medir |
| CLS | < 0.1 | - | 🔍 Medir |
| Zero broken links | 0 | - | 🔍 Medir |

### Como Atualizar Este Documento

Após executar as primeiras auditorias, atualize a coluna "Atual" com os valores reais:

```bash
# Execute os workflows
# Anote os resultados
# Atualize a tabela acima
git add MONITORING.md
git commit -m "docs: atualiza métricas de baseline"
```

---

**Última atualização:** 2025-11-22
**Versão:** 1.0.0
**Mantenedor:** Guilherme Carvalho
