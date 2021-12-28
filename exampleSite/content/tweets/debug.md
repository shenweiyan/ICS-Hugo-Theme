---
title: "测试"
date: '2019-05-30'
lastmod: "`r Sys.Date()`"
output:
  pdf_document:
    includes:
      in_header: cv-cn-header.tex
    latex_engine: xelatex
    md_extensions: -autolink_bare_uris+hard_line_breaks
    template: cv-cn-template.latex
  html_document:
    df_print: paged
geometry: margin=1in
pdf: ../xxx.pdf
type: cv
urlcolor: blue
fontsize: 10pt
---

# 沈维燕

---

## 测试问题记录

如果 config.toml 中 url 的名称与 `content/*/index.md`、`content/*.md` 中的 title 名称不一致，则会触发 menu 中的 item 在 active 时候的 `aria-current="page"` 发生，样式正常。
