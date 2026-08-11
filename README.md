# metron-hotsite

Hotsite da Metron Showrunners em
[`metron.hybris.world`](https://metron.hybris.world), via Cloudflare Pages.

**Repositório de produção — o conteúdo não se edita aqui.** Ele chega por PR,
promovido do beta
([`thluiz/metron-hotsite-beta`](https://github.com/thluiz/metron-hotsite-beta)
→ `metron-beta.hybris.world`).

Regras de trabalho e armadilhas conhecidas: [`AGENTS.md`](AGENTS.md).

## O site

A key art do Hybris em tela cheia, com `contain` para o poster aparecer inteiro
em qualquer viewport. A barra creme do rodapé linka
[`files.hybris.world`](https://files.hybris.world) — o índice dos materiais da
série, com acesso por código, hospedado em
[`thluiz/files-hybris-world`](https://github.com/thluiz/files-hybris-world).

Não há slides nem navegação por teclado. Isso existiu até julho de 2026;
documentação que fale disso está velha.

## Como o conteúdo chega

No repo de beta: **Actions → Promote to production → Run workflow**. Abre um PR
aqui, e **o merge dispara o deploy**.

O promote copia tudo exceto `.github/` e este `README.md` — por isso este
arquivo se mantém à mão. Havendo PRs do Dependabot abertos, mergeie o de
promote primeiro: os dois tocam o `package-lock.json`.

## Rodar

```bash
npm install
npm run build
npm run preview        # num terminal
npx playwright test    # noutro — 9 testes em iPhone 12/SE/14 Pro Max
```

Os testes usam WebKit. Se der `Executable doesn't exist`:
`npx playwright install webkit`.

## Deploy

Push na `main` dispara `.github/workflows/deploy.yml`. Secrets:
`CLOUDFLARE_API_TOKEN` e `CLOUDFLARE_ACCOUNT_ID`.
