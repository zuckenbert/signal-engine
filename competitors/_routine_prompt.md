# Rotina semanal: Eixo Concorrentes

> Prompt self-contained. Assuma que voce (agente de IA) acabou de clonar este repo e tem ZERO contexto.
> Execute os passos na ordem. Idioma de toda saida: PT-BR. NUNCA use travessao (use virgula, ponto, parenteses ou dois-pontos).

Voce e um agente que roda o eixo de monitoramento de Concorrentes por uma semana e produz um relatorio versionado.

## Passo 1: Resolva a semana

- Determine a ISO week atual no formato `AAAA-WXX` (ex: 2026-W24).
- Determine a janela da semana: segunda-feira a domingo (use o fuso definido na secao 9 do `MARKET.md`).
- Guarde `WEEK_ID` e a janela. Vai usar nos nomes de arquivo e no header do relatorio.

## Passo 2: Carregue o contexto

Leia, nesta ordem:
1. `MARKET.md` (raiz): quem voce e, produtos, ICP, personas, concorrentes (secao 6) e mapa sinal -> produto (secao 8).
2. `competitors/_targets.md`: as URLs e termos de busca de cada concorrente, e o que conta como sinal vs ruido.
3. `competitors/_state.json`: a MEMORIA. Anote `last_run_date` e a lista `themes[]`. Defina `startDate = last_run_date` (se for null, e o 1o run: trate a janela so como a semana atual).
4. `competitors/_status.md`: confira o ultimo run no Weekly Run Log.

## Passo 3: Descoberta

Para cada concorrente em `_targets.md`, colete o que e novo desde `startDate`. Use as ferramentas que o seu agente tiver conectadas (como conectores / MCP). De forma agnostica de ferramenta:

- **Busca web / noticias data-filtrada**: use sua ferramenta de busca web (ex: um MCP de web search) com os termos de busca do `_targets.md`, filtrando por data >= `startDate`. Procure lancamentos, parcerias, rodadas, contratacoes-chave, falas de porta-vozes.
- **Leitura das paginas proprias do concorrente (deteccao de mudanca)**: use sua ferramenta de leitura/scrape de paginas pra abrir home, blog, sala de imprensa e pricing de cada concorrente. Compare com o que ja estava registrado nos temas (`evidence_urls` e `summary` no `_state.json`) pra detectar o que mudou (diff): pagina nova, pricing alterado, mensagem institucional diferente.
- **API da fonte (se houver)**: se algum concorrente expoe feed/RSS ou API publica, prefira isso.

Junte todos os achados crus numa lista, cada um com: concorrente, categoria, o que aconteceu, data, URL(s) de evidencia.

## Passo 4: Reconciliacao contra `_state.json`

Para cada achado cru, case semanticamente contra os temas existentes em `themes[]`:

- **Casou com um tema existente, sem novidade**: e ONGOING. Atualize `last_seen_week = WEEK_ID`, faca append de `WEEK_ID` em `weeks_seen`, e junte qualquer URL nova em `evidence_urls`. NAO reporte no resumo executivo.
- **Casou com um tema existente, mas tem desdobramento novo** (ex: a parceria que era so anuncio agora virou produto): e ESCALATING. Atualize os campos acima e ajuste `summary` e `status = ESCALATING`. Reporte no resumo executivo, destacando o que mudou.
- **Nao casou com nenhum tema**: e NEW. Crie um tema novo (use o shape descrito no README do eixo), com `first_seen_week = WEEK_ID`, `weeks_seen = [WEEK_ID]`, `status = NEW`. Reporte no resumo executivo.

Para os temas que existiam mas NAO reapareceram nesta semana:
- Nao visto ha 2 ou mais semanas (compare `last_seen_week` com `WEEK_ID`): marque `DORMANT`.
- Nao visto ha 4 ou mais semanas: marque `RESOLVED`.

**Regra de ouro: NUNCA reporte ONGOING como novidade. So NEW e ESCALATING entram no resumo executivo.**

## Passo 5: Gere o relatorio

Escreva `competitors/weeks/<WEEK_ID>/competitors.md` com esta estrutura (siga o espirito do `SIGNAL_TEMPLATE.md` da raiz):

1. **Header**: titulo, `WEEK_ID`, janela (segunda a domingo) e data do run.
2. **Resumo executivo**: SO os NEW e ESCALATING. Uma linha por movimento, dizendo o que e novo vs a semana passada.
3. **Corpo por alvo**: uma subsecao por concorrente que teve movimento, com marcador de status por item. Sugestao de marcador: 🆕 NEW, ⬆️ ESCALATING, ➡️ ONGOING (compacto, com contagem de semanas).
4. **"E dai? / So what"**: uma linha de implicacao pratica por movimento (por que isso importa pra voce, qual produto puxar do mapa do `MARKET.md`).
5. **Apendice de fontes**: todas as URLs de evidencia, clicaveis.

## Passo 6: Atualize a memoria

- `competitors/_state.json`: atualize `last_run_week = WEEK_ID`, `last_run_date = <hoje>`, e a lista `themes[]` (com os NEW criados, os ESCALATING/ONGOING atualizados, e os DORMANT/RESOLVED remarcados).
- `competitors/_themes.md`: reflita os temas em formato de tabela legivel (apague a linha de exemplo se ainda estiver la).
- `competitors/_status.md`: atualize o Dashboard e adicione uma linha no Weekly Run Log (Semana, Data do run, # sinais, # NEW, # ESCALATING, Notas).

## Passo 7: Commit e push

Faca commit com mensagem convencional e de push:

```
feat(competitors): weekly watch <WEEK_ID>
```

Lembrete final: idioma PT-BR, nunca usar travessao.
