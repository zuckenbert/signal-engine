# Targets: Comunidade

> Config deste eixo. O que ouvir e como filtrar. A fonte de verdade do ICP (quem importa)
> e a secao 4 do `MARKET.md`. Aqui voce detalha as fontes da comunidade.
> Exemplos abaixo sao FICTICIOS. Apague e troque.
> Estilo: nunca usar travessao.

## Fontes a ouvir

<!-- Liste os repos open source, foruns ou canais de comunidade que voce mantem. -->

| Fonte | Tipo | URL / handle | Como coletar |
| --- | --- | --- | --- |
| {SEU_REPO_1} | repositorio | {https://host-de-repos.exemplo/org/repo-1} | API do host (forks, stars, issues, PRs) |
| {SEU_REPO_2} | repositorio | {https://host-de-repos.exemplo/org/repo-2} | API do host |
| {SEU_FORUM} | forum | {https://forum.seu-site.exemplo} | busca/scrape de topicos novos |
| {SUA_COMUNIDADE} | comunidade | {handle ou URL do canal} | API ou export |

## Filtro de insider

<!-- Quem NAO conta como sinal externo (sua propria equipe, bots). -->
- Handles/dominios da sua equipe: {ex: @sua-equipe, *@sua-empresa.exemplo}
- Bots conhecidos: {ex: dependabot, ci-bot}

## O que conta como sinal (vs ruido)

- **Sinal**: ator de FORA, com fit de ICP, que forka/da star/abre issue/manda PR num repo seu, ou que aparece no forum montando algo do seu dominio.
- **Ruido**: sua propria equipe, bots, estudante sem fit, concorrente, spam.

## Mapa sinal -> produto

| Sinal de comunidade | Produto a puxar (do MARKET.md) | Angulo |
| --- | --- | --- |
| {ex: empresa do ICP forkou repo-1} | {PRODUTO_A} | {ex: ja esta testando, oferecer suporte/versao gerenciada} |
| {ex: pergunta no forum sobre caso de uso Y} | {PRODUTO_B} | {ex: B resolve Y direto} |
