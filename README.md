# metron-hotsite

Static hotsite da Metron Showrunners, publicado em
[`metron-hotsite.thluiz.com`](https://metron-hotsite.thluiz.com).

## Stack

- [Astro](https://astro.build/) 4 (output estático)
- Tailwind CSS 3 (`@astrojs/tailwind`)
- Cinzel + Cinzel Decorative (OFL, self-hosted em `public/fonts/`)
- Hospedagem: S3 + CloudFront (us-east-1)

## Comandos

```bash
npm install        # primeira vez
npm run dev        # dev server (Astro)
npm run build      # gera dist/
npm run preview    # serve dist/ localmente
```

## Estrutura

```
src/
  components/   componentes Astro reutilizáveis (Lightning, Polaroid, SlideHeader)
  layouts/      Layout.astro — html + head + scroll observer
  pages/        index.astro — página única (cover)
  styles/       global.css — @font-face, slides, vinheta/grain
public/
  fonts/        Cinzel*.otf + OFL.txt
  favicon.svg
```

## Deploy

Os deploys vão para o bucket `s3://metron-hotsite-thluiz-com/` e invalidam a
distribuição CloudFront `E3DJ3AFXNDSS29`.

### Manual (Windows / pwsh)

```powershell
./deploy.ps1            # build + sync + invalidate
./deploy.ps1 -BuildOnly # apenas build
```

Requer perfil AWS `scholion-admin` configurado localmente.

### CI (GitHub Actions)

`.github/workflows/deploy.yml` faz build + sync + invalidate em todo push para
`main`. Requer secrets `AWS_ACCESS_KEY_ID` e `AWS_SECRET_ACCESS_KEY` no repo.

## Infra

| Recurso             | ID / Valor                                         |
| ------------------- | -------------------------------------------------- |
| S3 bucket           | `metron-hotsite-thluiz-com` (us-east-1, PAB ON)    |
| CloudFront dist     | `E3DJ3AFXNDSS29`                                   |
| CloudFront domain   | `d3piirez52lsxv.cloudfront.net`                    |
| Alias               | `metron-hotsite.thluiz.com`                        |
| Cert (ACM us-east-1)| wildcard `*.thluiz.com`                            |
| Origin Access       | OAC `E3BSA34VHJSKOR` (compartilhado com hybris)    |

Bucket é privado; só CloudFront lê via OAC, com bucket policy travada em
`AWS:SourceArn` da distribuição.

## Fontes

Cinzel e Cinzel Decorative (Natanael Gama, [SIL OFL 1.1](public/fonts/OFL.txt))
são servidas localmente de `public/fonts/`, carregadas via `@font-face` em
`src/styles/global.css` e preloaded no `<head>` do Layout.
