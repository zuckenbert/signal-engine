# Digest

O digest e onde o dado bruto vira contexto pro time.

Cada eixo gera, na sua pasta `weeks/<week>/`, um relatorio da semana. Solto, isso e tres ou quatro arquivos espalhados. O digest concatena o relatorio de cada eixo numa unica leitura: um markdown so, costurando o mercado de cima a baixo, na ordem dos eixos.

Em vez de pedir que comercial, produto ou lideranca abram quatro pastas, voce entrega um documento. E onde a maquina deixa de ser "varios monitoramentos" e passa a ser "a semana do mercado".

## Como gerar

```bash
WEEK_ID=AAAA-WXX ./digest/build_digest.sh
```

Se `WEEK_ID` for omitido, o script usa a ISO week de hoje (UTC). A saida vai pra `digest/weeks/<WEEK_ID>/full.md`.

## O que o script faz

- Percorre a lista de eixos (`AXES` dentro do script).
- Pra cada eixo, abre uma secao `H1` com nome e descricao, precedida de um pagebreak (util se voce exportar pra PDF depois).
- Insere o relatorio daquele eixo, com tres ajustes (funcao `prep_axis`):
  1. Remove o `H1` proprio do relatorio (o digest ja poe o titulo da secao).
  2. Troca qualquer travessao (em dash ou en dash) por virgula, por garantia de estilo.
  3. Insere uma linha em branco antes de tabelas, pra elas renderizarem como GFM (GitHub Flavored Markdown).
- Se um eixo nao tem relatorio naquela semana (rotina nao rodou ou nao houve sinais), escreve um aviso no lugar e segue.
- No fim, reporta no stderr quantos eixos dos esperados estavam presentes.

## Adicionar um eixo ao digest

Edite o array `AXES` em `build_digest.sh`, adicionando uma linha no formato:

```
"<eixo>/weeks/$WEEK_ID/<eixo>.md|Nome Exibido|Descricao curta da secao"
```
