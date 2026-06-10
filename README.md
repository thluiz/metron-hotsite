# metron-hotsite

Hotsite estático da Metron Showrunners, publicado em
[`metron.hybris.world`](https://metron.hybris.world) via Cloudflare Pages.

A página única exibe a logo Metron + barra vertical centrada no viewport,
com as logos das IPs (Hybris, Laya, Intersessões) fazendo crossfade à direita
conforme o usuário rola.

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
  layouts/   Layout.astro — html + head + scroll observers (crossfade + nav dots)
  pages/     index.astro — composição Metron|bar|IP + slides + nav dots
  styles/    global.css — background fixo (gradiente + grain), slides, nav dots
public/
  images/    metron-logo.png + {hybris,laya,intersessoes}-logo.png
  favicon.svg
```

## Deploy

Push em `main` dispara `.github/workflows/deploy.yml`, que faz build do Astro
e publica em Cloudflare Pages via `wrangler-action`. Secrets necessários no
repo: `CLOUDFLARE_API_TOKEN`, `CLOUDFLARE_ACCOUNT_ID`.

O workflow também tem um job AWS (S3 + CloudFront `E3DJ3AFXNDSS29` →
`metron-hotsite.thluiz.com`) desativado com `if: false`. Para reativar,
remover essa linha — secrets `AWS_ACCESS_KEY_ID` e `AWS_SECRET_ACCESS_KEY`
já estão no repo.
