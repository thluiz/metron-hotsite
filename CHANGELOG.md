# Changelog

## Unreleased

### Added
- Scroll lateral (`wheel.deltaX`) navega entre slides.
- Atalhos de teclado: `Space`/`→`/`↓` avançam, `←`/`↑` retrocedem.
- Navegação faz loop entre o primeiro e o último slide.
- Layout mobile (≤640px) com Metron e IP lado-a-lado, espelhando o desktop.
- Cenário Playwright (`tests/seed.spec.ts` + `playwright.config.ts`) para
  iteração visual em viewports iPhone 12 / SE / 14 Pro Max.

### Changed
- Composição Metron+IP centrada no viewport (sem barra vertical).
- README atualizado para refletir interações e estrutura atual.

## Histórico

Commits anteriores documentam:
- Cloudflare Pages como hospedagem ativa (job AWS desativado).
- Background fixo (gradiente + grain) movido para `body::before/::after`
  para corrigir scroll no iOS Safari.
- Crossfade das logos de IP dirigido por scroll.
- Scaffold inicial Astro 4 + Tailwind 3.
