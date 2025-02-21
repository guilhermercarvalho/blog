---
title: "Sistema de Templates"
weight: 30
---

### **3. Templating (`content/features/templating.md`)**

### Go Template
```go-html-template
{{ range .Pages }}
  <h2>{{ .Title }}</h2>
  {{ .Content }}
{{ end }}
```
