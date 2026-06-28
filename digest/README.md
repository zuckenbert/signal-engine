# Digest

O digest é onde o dado bruto vira contexto pro time.

Cada eixo (e cada mercado) gera, na sua pasta `weeks/<week>/`, um relatório da semana. Solto, isso é vários arquivos espalhados. O digest concatena os relatórios JÁ PRONTOS numa única leitura: um markdown só, costurando o mercado de cima a baixo.

Em vez de pedir que comercial, produto ou liderança abram várias pastas, você entrega um documento. É onde a máquina deixa de ser "vários monitoramentos" e passa a ser "a semana do mercado".

> A camada de ativação (`activation/proposals.md`) roda SEPARADO e NÃO entra no digest. O digest é a foto do mercado (o que aconteceu). A ativação é a recomendação de ação (quem acionar). São documentos com públicos e momentos diferentes.

O digest é gerado por `digest/build_digest.sh`.

## Como gerar

```bash
WEEK_ID=AAAA-WXX ./digest/build_digest.sh
```

Se `WEEK_ID` for omitido, o script usa a ISO week de hoje (UTC). A saída vai pra `digest/weeks/<WEEK_ID>/full.md`.

## O que o script faz

O script descobre as seções DINAMICAMENTE (não tem lista fixa de eixos):

1. **Mercados (descoberta)**: varre `markets/*/weeks/$WEEK_ID/consolidated.md`, PULANDO a pasta `_TEMPLATE_MARKET` (que é só molde). Cada mercado vira uma seção.
2. **Eixos de fonte de eixo único**: adiciona os que existirem, `competitors/weeks/$WEEK_ID/competitors.md` e `official-records/weeks/$WEEK_ID/official-records.md`.

Para cada seção:
- Abre uma seção `H1` com nome e descrição, precedida de um pagebreak (útil se você exportar pra PDF depois).
- Insere o relatório, com três ajustes (função `prep_axis`):
  1. Remove o `H1` próprio do relatório (o digest já põe o título da seção).
  2. Troca qualquer travessão (em dash ou en dash) por vírgula, por garantia de estilo.
  3. Insere uma linha em branco antes de tabelas, pra elas renderizarem como GFM (GitHub Flavored Markdown).
- Se uma seção não tem relatório naquela semana (rotina não rodou ou não houve sinais), escreve um aviso no lugar e segue.
- No fim, reporta no stderr quantas seções das esperadas estavam presentes.

## Adicionar um mercado ou eixo ao digest

- **Mercado novo**: nada a fazer. Basta criar a pasta dentro de `markets/` (clonando `_TEMPLATE_MARKET/`). O digest a descobre sozinho assim que houver um `consolidated.md` na semana.
- **Eixo de fonte novo** (de eixo único, como `competitors/`): adicione uma linha no array `SECTIONS` em `build_digest.sh`, no bloco "Eixos de fonte de eixo unico", no formato:
  ```
  SECTIONS+=("<eixo>/weeks/$WEEK_ID/<eixo>.md|Nome Exibido|Descricao curta")
  ```
