# Digest

O digest é onde o dado bruto vira contexto pro time.

Cada eixo gera, na sua pasta `weeks/<week>/`, um relatório da semana. Solto, isso é três ou quatro arquivos espalhados. O digest concatena o relatório de cada eixo numa única leitura: um markdown só, costurando o mercado de cima a baixo, na ordem dos eixos.

Em vez de pedir que comercial, produto ou liderança abram quatro pastas, você entrega um documento. É onde a máquina deixa de ser "vários monitoramentos" e passa a ser "a semana do mercado".

## Como gerar

```bash
WEEK_ID=AAAA-WXX ./digest/build_digest.sh
```

Se `WEEK_ID` for omitido, o script usa a ISO week de hoje (UTC). A saída vai pra `digest/weeks/<WEEK_ID>/full.md`.

## O que o script faz

- Percorre a lista de eixos (`AXES` dentro do script).
- Pra cada eixo, abre uma seção `H1` com nome e descrição, precedida de um pagebreak (útil se você exportar pra PDF depois).
- Insere o relatório daquele eixo, com três ajustes (função `prep_axis`):
  1. Remove o `H1` próprio do relatório (o digest já põe o título da seção).
  2. Troca qualquer travessão (em dash ou en dash) por vírgula, por garantia de estilo.
  3. Insere uma linha em branco antes de tabelas, pra elas renderizarem como GFM (GitHub Flavored Markdown).
- Se um eixo não tem relatório naquela semana (rotina não rodou ou não houve sinais), escreve um aviso no lugar e segue.
- No fim, reporta no stderr quantos eixos dos esperados estavam presentes.

## Adicionar um eixo ao digest

Edite o array `AXES` em `build_digest.sh`, adicionando uma linha no formato:

```
"<eixo>/weeks/$WEEK_ID/<eixo>.md|Nome Exibido|Descricao curta da secao"
```
