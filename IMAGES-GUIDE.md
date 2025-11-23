# Guia de Uso: Imagens Otimizadas no Hugo

## Estrutura de Diretórios

```
assets/images/
├── covers/         # Imagens featured dos posts
├── posts/          # Imagens dentro do conteúdo dos posts
└── icons/          # Ícones e logos
```

## Shortcodes Disponíveis

### 1. `img` - Imagem Responsiva com WebP

Gera automaticamente múltiplos tamanhos e formato WebP com fallback.

**Uso:**

```markdown
{{</* img src="images/posts/exemplo.jpg" alt="Descrição da imagem" caption="Legenda opcional" */>}}
```

**Parâmetros:**

- `src`: Caminho relativo a `/assets/` (obrigatório)
- `alt`: Texto alternativo (padrão: "Image")
- `caption`: Legenda da imagem (opcional)
- `class`: Classes CSS customizadas (opcional)
- `loading`: eager|lazy (padrão: "lazy")

**Exemplo completo:**

```markdown
{{</* img
  src="images/posts/architecture-diagram.png"
  alt="Diagrama de arquitetura do sistema"
  caption="Arquitetura baseada em microsserviços"
  class="shadow rounded"
  loading="eager"
*/>}}
```

**Output gerado:**

- WebP em 3 tamanhos: 600px, 1200px, 1800px
- Fallback JPEG em 1200px
- Lazy loading nativo
- Atributos width/height para evitar layout shift

---

### 2. `figure` - Imagem com Dimensões Customizadas

Para casos onde você quer controle preciso sobre o tamanho.

**Uso:**

```markdown
{{</* figure src="images/icons/logo.png" alt="Logo" width="200" height="200" */>}}
```

**Parâmetros:**

- `src`: Caminho da imagem
- `alt`: Texto alternativo
- `width`: Largura em pixels (opcional)
- `height`: Altura em pixels (opcional)
- `caption`: Legenda (opcional)
- `class`: Classes CSS (opcional)
- `link`: URL para tornar a imagem clicável (opcional)

**Exemplo com link:**

```markdown
{{</* figure
  src="images/posts/graph.png"
  alt="Gráfico de performance"
  width="800"
  caption="Resultado dos testes de carga"
  link="https://example.com/full-report"
*/>}}
```

---

## Usando Imagens Externas

Ambos os shortcodes suportam URLs HTTP/HTTPS:

```markdown
{{</* img src="https://exemplo.com/imagem.jpg" alt="Imagem externa" */>}}
```

**Nota:** Imagens externas não são processadas pelo Hugo.

---

## Front Matter: Featured Images

Use caminhos relativos ao diretório `/assets/`:

```yaml
---
title: "Meu Post"
featured_image: /images/covers/post-hero.jpg
---
```

O Hugo automaticamente:

- Processa a imagem para WebP
- Gera múltiplos tamanhos
- Aplica configurações do `hugo.toml`

---

## Configurações de Processamento

Definidas em `hugo.toml`:

```toml
[imaging]
  resampleFilter = "Lanczos"  # Melhor qualidade
  quality = 85                # Balance qualidade/tamanho
  hint = "photo"              # Otimização para fotos
  anchor = "Smart"            # Crop inteligente
```

---

## Boas Práticas

### 1. Nomeação de Arquivos

```
✅ user-profile-dashboard.jpg
✅ api-flow-diagram.png
❌ IMG_1234.jpg
❌ Screenshot 2025-11-21.png
```

### 2. Tamanhos Recomendados

- **Featured images**: 1800x1200px ou maior
- **Imagens no conteúdo**: 1200px de largura
- **Ícones**: 512x512px ou vetorial (SVG)

### 3. Formatos

- **Fotos**: JPEG ou PNG → convertido para WebP
- **Gráficos com texto**: PNG (melhor compressão)
- **Logos/ícones**: SVG (quando possível)

### 4. Alt Text

```markdown
❌ alt="imagem"
✅ alt="Diagrama mostrando arquitetura de microsserviços com API Gateway"
```

---

## Troubleshooting

### Imagem não aparece em desenvolvimento

```markdown
<!-- Erro mostrado automaticamente no modo dev -->
<div style="background: red">
  Image not found: images/missing.jpg
</div>
```

**Solução:** Verifique o caminho relativo a `/assets/`

### Build falha: "image not found"

- Confirme que o arquivo existe em `/assets/images/`
- Use caminhos relativos sem `/assets/` no início

### Imagens muito grandes no build

- Reduza `quality` no `hugo.toml` (70-85)
- Use imagens fonte menores que 3000px

---

## Exemplo Completo de Post

```markdown
---
title: "Otimizando Performance de APIs"
featured_image: /images/covers/api-performance.jpg
---

Este post mostra técnicas de otimização.

## Arquitetura

{{</* img
  src="images/posts/cache-strategy.png"
  alt="Estratégia de cache multi-camada"
  caption="Redis + CDN + Browser Cache"
*/>}}

## Resultados

{{</* figure
  src="images/posts/benchmark-results.png"
  alt="Gráfico de benchmark"
  width="700"
  caption="Redução de 60% no tempo de resposta"
*/>}}
```

---

## CSS Customizado (Opcional)

Adicione em `/assets/css/custom.css`:

```css
/* Sombra em imagens */
.image-wrapper img {
  box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
  border-radius: 8px;
}

/* Zoom on hover */
.image-wrapper img:hover {
  transform: scale(1.02);
  transition: transform 0.3s ease;
}

/* Figcaption styling */
figcaption {
  font-size: 0.9rem;
  color: #666;
  text-align: center;
  margin-top: 0.5rem;
  font-style: italic;
}
```
