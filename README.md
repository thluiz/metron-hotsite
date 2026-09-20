# metron-hotsite

Hotsite of Metron Showrunners at [`hybris.world`](https://hybris.world) and
[`metron.hybris.world`](https://metron.hybris.world), via Cloudflare Pages.

**Production repository — content isn't edited here.** It arrives via PR,
promoted from beta
([`thluiz/metron-hotsite-beta`](https://github.com/thluiz/metron-hotsite-beta)
→ `metron-beta.hybris.world`).

Working rules and known pitfalls: [`AGENTS.md`](AGENTS.md).

## The site

The Hybris key art full-screen, with `contain` so the poster appears whole
at any viewport. The cream footer bar links
[`files.hybris.world`](https://files.hybris.world) — the index of the
series' materials, with access-code gating, hosted at
[`thluiz/files-hybris-world`](https://github.com/thluiz/files-hybris-world).

There are no slides or keyboard navigation. That existed until July 2026;
documentation mentioning it is stale.

## How content gets here

In the beta repo: **Actions → Promote to production → Run workflow**. This
opens a PR here, and **the merge triggers the deploy**.

Promote copies everything except `.github/` and this `README.md` — that's
why this file is maintained by hand. If there are open Dependabot PRs, merge
the promote one first: both touch `package-lock.json`.

## Running

```bash
npm install
npm run build
npm run preview        # in one terminal
npx playwright test    # in another — 9 tests on iPhone 12/SE/14 Pro Max
```

Tests use WebKit. If you get `Executable doesn't exist`:
`npx playwright install webkit`.

## Deploy

Push to `main` triggers `.github/workflows/deploy.yml`. Secrets:
`CLOUDFLARE_API_TOKEN` and `CLOUDFLARE_ACCOUNT_ID`.

## Domains

Five hostnames serve this same project (`metron-hotsite` on Cloudflare Pages):

- `hybris.world` — canonical. `CNAME` to `metron-hotsite.pages.dev` on the
  apex, proxied; works via CNAME flattening, no ALIAS needed.
- `metron.hybris.world` — same `CNAME`.
- `www.hybris.world` — 301 Redirect Rule to the apex.
- `metronshowrunners.com` — separate own domain, separate zone on the same
  Cloudflare account. Same scheme: `CNAME` to `metron-hotsite.pages.dev` on
  the apex, proxied.
- `www.metronshowrunners.com` — 301 Redirect Rule to the apex.

**Pitfall:** the DNS record alone isn't enough. Every hostname also needs to
be listed under **Workers & Pages → `metron-hotsite` → Custom domains**.
Without that, Cloudflare responds **522**, because the proxy doesn't know
which project serves that `Host:` — and the symptom is misleading, since the
DNS looks correct. That's what blocked the apex cutover in August 2026.
