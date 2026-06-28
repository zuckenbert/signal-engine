# Rotina semanal: Eixo Concorrentes

> Prompt self-contained. Assuma que você (agente de IA) acabou de clonar este repo e tem ZERO contexto.
> Execute os passos na ordem. Idioma de toda saída: PT-BR. NUNCA use travessão (use vírgula, ponto, parênteses ou dois-pontos).

Você é um agente que roda o eixo de monitoramento de Concorrentes por uma semana e produz um relatório versionado.

## Passo 1: Resolva a semana

- Determine a ISO week atual no formato `AAAA-WXX` (ex: 2026-W24).
- Determine a janela da semana: segunda-feira a domingo (use o fuso definido na seção 9 do `MARKET.md`).
- Guarde `WEEK_ID` e a janela. Vai usar nos nomes de arquivo e no header do relatório.

## Passo 2: Carregue o contexto

Leia, nesta ordem:
1. `MARKET.md` (raiz): quem você é, produtos, ICP, personas, concorrentes (seção 6) e mapa sinal -> produto (seção 8).
2. `competitors/_targets.md`: as URLs e termos de busca de cada concorrente, e o que conta como sinal vs ruído.
3. `competitors/_state.json`: a MEMÓRIA. Anote `last_run_date` e a lista `themes[]`. Defina `startDate = last_run_date` (se for null, é o 1o run: trate a janela só como a semana atual).
4. `competitors/_status.md`: confira o último run no Weekly Run Log.

## Passo 3: Descoberta

Para cada concorrente em `_targets.md`, colete o que é novo desde `startDate`. Use as ferramentas que o seu agente tiver conectadas (como conectores / MCP). De forma agnóstica de ferramenta:

- **Busca web / notícias data-filtrada**: use sua ferramenta de busca web (ex: um MCP de web search) com os termos de busca do `_targets.md`, filtrando por data >= `startDate`. Procure lançamentos, parcerias, rodadas, contratações-chave, falas de porta-vozes.
- **Leitura das páginas próprias do concorrente (detecção de mudança)**: use sua ferramenta de leitura/scrape de páginas pra abrir home, blog, sala de imprensa e pricing de cada concorrente. Compare com o que já estava registrado nos temas (`evidence_urls` e `summary` no `_state.json`) pra detectar o que mudou (diff): página nova, pricing alterado, mensagem institucional diferente.
- **API da fonte (se houver)**: se algum concorrente expõe feed/RSS ou API pública, prefira isso.

Junte todos os achados crus numa lista, cada um com: concorrente, categoria, o que aconteceu, data, URL(s) de evidência.

## Passo 4: Reconciliação contra `_state.json`

Para cada achado cru, case semanticamente contra os temas existentes em `themes[]`:

- **Casou com um tema existente, sem novidade**: é ONGOING. Atualize `last_seen_week = WEEK_ID`, faça append de `WEEK_ID` em `weeks_seen`, e junte qualquer URL nova em `evidence_urls`. NÃO reporte no resumo executivo.
- **Casou com um tema existente, mas tem desdobramento novo** (ex: a parceria que era só anúncio agora virou produto): é ESCALATING. Atualize os campos acima e ajuste `summary` e `status = ESCALATING`. Reporte no resumo executivo, destacando o que mudou.
- **Não casou com nenhum tema**: é NEW. Crie um tema novo (use o shape descrito no README do eixo), com `first_seen_week = WEEK_ID`, `weeks_seen = [WEEK_ID]`, `status = NEW`. Reporte no resumo executivo.

Para os temas que existiam mas NÃO reapareceram nesta semana:
- Não visto há 2 ou mais semanas (compare `last_seen_week` com `WEEK_ID`): marque `DORMANT`.
- Não visto há 4 ou mais semanas: marque `RESOLVED`.

**Regra de ouro: NUNCA reporte ONGOING como novidade. Só NEW e ESCALATING entram no resumo executivo.**

## Passo 5: Gere o relatório

Escreva `competitors/weeks/<WEEK_ID>/competitors.md` com esta estrutura (siga o espírito do `SIGNAL_TEMPLATE.md` da raiz):

1. **Header**: título, `WEEK_ID`, janela (segunda a domingo) e data do run.
2. **Resumo executivo**: SÓ os NEW e ESCALATING. Uma linha por movimento, dizendo o que é novo vs a semana passada.
3. **Corpo por alvo**: uma subseção por concorrente que teve movimento, com marcador de status por item. Sugestão de marcador: 🆕 NEW, ⬆️ ESCALATING, ➡️ ONGOING (compacto, com contagem de semanas).
4. **"E daí? / So what"**: uma linha de implicação prática por movimento (por que isso importa pra você, qual produto puxar do mapa do `MARKET.md`).
5. **Apêndice de fontes**: todas as URLs de evidência, clicáveis.

## Passo 6: Atualize a memória

- `competitors/_state.json`: atualize `last_run_week = WEEK_ID`, `last_run_date = <hoje>`, e a lista `themes[]` (com os NEW criados, os ESCALATING/ONGOING atualizados, e os DORMANT/RESOLVED remarcados).
- `competitors/_themes.md`: reflita os temas em formato de tabela legível (apague a linha de exemplo se ainda estiver lá).
- `competitors/_status.md`: atualize o Dashboard e adicione uma linha no Weekly Run Log (Semana, Data do run, # sinais, # NEW, # ESCALATING, Notas).

## Passo 7: Commit e push

Faça commit com mensagem convencional e dê push:

```
feat(competitors): weekly watch <WEEK_ID>
```

Lembrete final: idioma PT-BR, nunca usar travessão.
