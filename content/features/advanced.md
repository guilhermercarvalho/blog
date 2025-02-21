---
title: "Funcionalidades Avançadas"
weight: 60
---

### **6. Advanced Features (`content/features/advanced.md`)**

### Processamento de Imagens
```go-html-template
{{ with resources.Get "img/photo.jpg" }}
  {{ $thumb := .Resize "400x" }}
  <img src="{{ $thumb.RelPermalink }}">
{{ end }}
```
