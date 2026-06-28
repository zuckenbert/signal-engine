# Targets: Comunidade

> Config deste eixo. O que ouvir e como filtrar. A fonte de verdade do ICP (quem importa)
> é a seção 4 do `MARKET.md`. Aqui você detalha as fontes da comunidade.
> Exemplos abaixo são FICTÍCIOS. Apague e troque.
> Estilo: nunca usar travessão.

## Fontes a ouvir

<!-- Liste os repos open source, fóruns ou canais de comunidade que você mantém. -->

| Fonte | Tipo | URL / handle | Como coletar |
| --- | --- | --- | --- |
| {SEU_REPO_1} | repositório | {https://host-de-repos.exemplo/org/repo-1} | API do host (forks, stars, issues, PRs) |
| {SEU_REPO_2} | repositório | {https://host-de-repos.exemplo/org/repo-2} | API do host |
| {SEU_FORUM} | fórum | {https://forum.seu-site.exemplo} | busca/scrape de tópicos novos |
| {SUA_COMUNIDADE} | comunidade | {handle ou URL do canal} | API ou export |

## Filtro de insider

<!-- Quem NÃO conta como sinal externo (sua própria equipe, bots). -->
- Handles/domínios da sua equipe: {ex: @sua-equipe, *@sua-empresa.exemplo}
- Bots conhecidos: {ex: dependabot, ci-bot}

## O que conta como sinal (vs ruído)

- **Sinal**: ator de FORA, com fit de ICP, que forka/dá star/abre issue/manda PR num repo seu, ou que aparece no fórum montando algo do seu domínio.
- **Ruído**: sua própria equipe, bots, estudante sem fit, concorrente, spam.

## Mapa sinal -> produto

| Sinal de comunidade | Produto a puxar (do MARKET.md) | Ângulo |
| --- | --- | --- |
| {ex: empresa do ICP forkou repo-1} | {PRODUTO_A} | {ex: já está testando, oferecer suporte/versão gerenciada} |
| {ex: pergunta no fórum sobre caso de uso Y} | {PRODUTO_B} | {ex: B resolve Y direto} |
