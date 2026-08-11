# metron-hotsite

Hotsite estático da Metron Showrunners, publicado em
[`metron.hybris.world`](https://metron.hybris.world) via Cloudflare Pages
(projeto `metron-hotsite`).

Este é o repositório de **produção**. O conteúdo não se edita aqui: ele chega
por Pull Request, promovido a partir do repositório de beta
([`thluiz/metron-hotsite-beta`](https://github.com/thluiz/metron-hotsite-beta)
→ `metron-beta.hybris.world`).

## O site

Uma página só: a key art do Hybris ocupando a tela inteira, com `contain` para
que o poster apareça inteiro em qualquer viewport, letterboxed no creme da
própria arte.

A barra creme do rodapé é um link para
[`files.hybris.world`](https://files.hybris.world) — o índice dos materiais da
série, onde o acesso é por código. Esse índice vive noutro repositório
([`thluiz/files-hybris-world`](https://github.com/thluiz/files-hybris-world)),
com infraestrutura própria (R2 + D1).

Não há slides, scroll, navegação por teclado nem nav dots. Isso existiu até
julho de 2026 e foi removido; se você encontrar código ou documentação falando
disso, está desatualizado.

## Como o conteúdo chega aqui

1. Edita-se no repositório de beta e confere-se em `metron-beta.hybris.world`.
2. Lá, **Actions → Promote to production → Run workflow**.
3. Abre-se um PR neste repositório com o conteúdo do beta por cima.
4. **O merge do PR é que dispara o deploy de produção.**

O promote copia tudo (`src/`, `public/`, configs, `AGENTS.md`, `CHANGELOG.md`)
**exceto** `.github/` e este `README.md`, que são específicos de ambiente. Por
isso este arquivo precisa ser mantido à mão — ele não vem no promote.

Se houver PRs do Dependabot abertos, faça o merge do PR de promote **primeiro**:
os dois tocam o `package-lock.json` e o promote precisaria ser regerado.

## Trabalhando no código

Leia o [`AGENTS.md`](AGENTS.md) — ele traz a estrutura, as boas práticas e as
armadilhas conhecidas. Vale para os dois repositórios.

```bash
npm install
npm run build     # SEMPRE antes de qualquer push
npm run preview   # serve o dist/, igual à produção

npm run preview            # num terminal
npx playwright test        # noutro: 9 testes em iPhone 12/SE/14 Pro Max
```

Os testes rodam em **WebKit**. Se aparecer `Executable doesn't exist`, rode
`npx playwright install webkit`.

## Stack

- [Astro](https://astro.build/) 4, output estático
- Cloudflare Pages (projeto `metron-hotsite`)

## Deploy

Push na `main` dispara `.github/workflows/deploy.yml`, que builda o Astro e
publica no Cloudflare Pages. Secrets necessários: `CLOUDFLARE_API_TOKEN` e
`CLOUDFLARE_ACCOUNT_ID`.
