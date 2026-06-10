# metron-hotsite

Hotsite estático da Metron Showrunners, publicado em
[`metron.hybris.world`](https://metron.hybris.world) via Cloudflare Pages.

A página única exibe a logo Metron centrada no viewport ao lado das logos
das IPs (Hybris, Laya, Intersessões), que fazem crossfade conforme o usuário
navega entre os slides.

### Navegação

- Scroll vertical (mouse, trackpad, touch): muda de slide via `scroll-snap`.
- Scroll lateral (`wheel.deltaX`): avança/retrocede slide.
- Teclado: `Space`, `→`, `↓` avançam; `←`, `↑` retrocedem.
- Navegação faz loop — do último slide volta ao primeiro e vice-versa.
- Dots fixos no rodapé linkam direto para cada slide.

## Stack

- [Astro](https://astro.build/) 4 (output estático)
- Tailwind CSS 3 (`@astrojs/tailwind`)
- Tipografia do sistema (sem fontes customizadas em uso)
- Hospedagem: Cloudflare Pages (projeto `metron-hotsite`)

## Comandos

```bash
npm install     # primeira vez
npm run dev     # dev server (Astro)
npm run build   # gera dist/
npm run preview # serve dist/ localmente
```

## Estrutura

```
src/
  layouts/   Layout.astro — html + head
  pages/     index.astro — composição Metron+IP + slides + nav dots + input handlers
  styles/    global.css — background fixo (gradiente + grain), slides, nav dots
public/
  images/    metron-logo.png + {hybris,laya,intersessoes}-logo.png
  favicon.svg
tests/
  seed.spec.ts — Playwright seed para iteração visual com MCP
playwright.config.ts — projetos iPhone 12 / SE / 14 Pro Max
```

## Deploy

Push em `main` dispara `.github/workflows/deploy.yml`, que faz build do Astro
e publica em Cloudflare Pages via `wrangler-action`. Secrets necessários no
repo: `CLOUDFLARE_API_TOKEN`, `CLOUDFLARE_ACCOUNT_ID`.

O workflow também tem um job AWS (S3 + CloudFront `E3DJ3AFXNDSS29` →
`metron-hotsite.thluiz.com`) desativado com `if: false`. Para reativar,
remover essa linha — secrets `AWS_ACCESS_KEY_ID` e `AWS_SECRET_ACCESS_KEY`
já estão no repo.
