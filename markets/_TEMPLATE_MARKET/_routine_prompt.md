# Rotina semanal: Mercado {NOME_DO_MERCADO} (modo DESCOBERTA)

> Prompt self-contained. Assuma que você (agente de IA) acabou de clonar este repo e tem ZERO contexto.
> Execute os passos na ordem. Idioma de toda saída: PT-BR. NUNCA use travessão (use vírgula, ponto, parênteses ou dois-pontos).
> Ao clonar este mercado, troque `{NOME_DO_MERCADO}` e `<mercado>` pelo nome real da pasta.

Você é um agente que roda o motor de DESCOBERTA para um mercado por uma semana. Diferente de um eixo de lista conhecida, aqui você NÃO recebe uma lista de empresas. Você recebe uma SUITE DE SINAIS e, para cada sinal ligado, descobre empresas desconhecidas que disparam aquele sinal, valida o fit contra o ICP e produz um relatório versionado por sinal mais um consolidado do mercado.

## Passo 1: Resolva a semana

- Determine a ISO week atual no formato `AAAA-WXX` (ex: 2026-W24).
- Determine a janela: segunda a domingo (use o fuso do `_targets.md` deste mercado, ou da seção 9 do `MARKET.md`).
- Guarde `WEEK_ID` e a janela. Alguns sinais podem ter janela própria (ex: 2 a 4 semanas): respeite o que estiver no `_targets.md` do sinal.

## Passo 2: Carregue o contexto

Leia, nesta ordem:
1. `MARKET.md` (raiz): ICP (seção 4), personas (seção 5), mapa sinal -> produto (seção 8) e, se houver, regulador (seção 7) e mercados (seção 10).
2. `markets/<mercado>/_targets.md`: a SUITE DE SINAIS. Liste quais sinais estão LIGADOS (`[x]`). Só rode os ligados. Para cada um, anote queries-semente, termos/cargos que contam, janela e o filtro de ICP.
3. `markets/<mercado>/_state.json`: a MEMÓRIA. Anote `last_run_date` e `themes[]`. Defina `startDate = last_run_date` (se null, é o 1o run: trate a janela só como a semana atual).
4. `markets/<mercado>/_status.md`: confira o último run no Weekly Run Log.

## Passo 3: Descoberta por sinal (modo JULGAMENTO / DESCOBERTA: você coleta)

Este mercado é de DESCOBERTA. Não há `collect.sh` nem Actions de coleta. Não existe lista de empresas: o alvo é a DEFINIÇÃO de cada sinal. Você é quem pesca os candidatos, lê e avalia. Use as ferramentas que o seu agente tiver conectadas (como conectores / MCP), de forma agnóstica:

**PARA CADA SINAL LIGADO `[x]` no `_targets.md`, faça:**

1. **Monte as buscas**: a partir das queries-semente do sinal, expanda em variações concretas usando os termos/cargos que contam. Não rode só a query crua: gere combinações que aumentem o recall (sinônimos, variações de cargo, com e sem a geografia).
2. **Busque na web**: use sua ferramenta de busca web (ex: um MCP de busca) com filtro de data >= `startDate` (ou a janela própria do sinal). Pesque candidatos.
3. **Leia os resultados**: use sua ferramenta de leitura/scrape pra abrir as páginas e confirmar que o evento existe de verdade e está NA JANELA. Descarte resultado antigo, duplicado ou que só menciona o tema sem um ator concreto.
4. **Enriqueça o ator** (a empresa que disparou o sinal): setor, tamanho, e, quando o sinal pede, investidores (em fundraising) ou status regulatório (em regulatory). Identifique também o decisor/persona (cruze com a seção 5 do MARKET.md).
5. **Classifique o FIT contra o ICP** (seção 4 do MARKET.md): marque fit alto, médio ou baixo. DESCARTE quem não tem fit (concorrente, fornecedor, fora da geografia, fora do tamanho). Este é o filtro de ruído do modo descoberta: sem ele, descoberta vira lixo.

**Nota sobre sinais de baixa frequência**: sinais de baixa frequência (lançamento, rodada, troca de liderança) podem não acontecer toda semana. Se um sinal vier vazio com janela de 1 semana, use uma janela efetiva maior (ex: 4 a 6 semanas) pra esse sinal, pegando o que é novo desde o último run. O importante é a continuidade (não reportar de novo o que já foi visto), não a janela rígida de 7 dias.

Junte os achados de cada sinal numa lista, cada um com: empresa, sinal, setor, tamanho, investidores/status regulatório (se aplicável), decisor/persona, fit, o detalhe do evento (o que e quando), e a(s) URL(s) de evidência.

## Passo 4: Reconciliação contra `_state.json`

Para cada achado (chave normalmente é empresa + sinal), case semanticamente contra `themes[]`:

- **Casou, sem novidade**: ONGOING. Atualize `last_seen_week = WEEK_ID`, append `WEEK_ID` em `weeks_seen`, junte URLs novas em `evidence_urls`. NÃO reporte no resumo executivo.
- **Casou, com desdobramento novo** (ex: a empresa que só tinha aberto vaga agora também captou rodada, ou a rodada cresceu): ESCALATING. Atualize os campos, ajuste `summary` e `status = ESCALATING`. Reporte no resumo executivo, destacando o que mudou.
- **Não casou**: NEW. Crie tema novo (shape no README do eixo), `first_seen_week = WEEK_ID`, `weeks_seen = [WEEK_ID]`, `status = NEW`, registre `signal` e `fit`. Reporte no resumo executivo.

Temas que não reapareceram: não visto 2 ou mais semanas = DORMANT; 4 ou mais = RESOLVED.

**Regra de ouro: NUNCA reporte ONGOING como novidade. Só NEW e ESCALATING entram no resumo executivo.**

## Passo 5: Escreva um arquivo por sinal

Para cada sinal ligado, escreva `markets/<mercado>/weeks/<WEEK_ID>/<sinal>.md` (siga o espírito do `SIGNAL_TEMPLATE.md` da raiz):

1. **Header**: título do sinal, `WEEK_ID`, janela usada, totais (quantos candidatos pescados, quantos com fit, quantos NEW/ESCALATING) e uma nota de método (queries usadas, ferramenta de busca usada de forma genérica).
2. **Um bloco por empresa** (só as com fit), contendo: setor, status regulatório (se aplicável), tamanho, investidores (se aplicável), FIT e produto a puxar (do mapa do MARKET.md), o detalhe do sinal in-window (o que aconteceu e quando), cluster de contexto (outros sinais ou fatos que reforçam), e a tese de dor (por que essa empresa provavelmente sente a dor que você resolve). Marcador de status: 🆕 NEW, ⬆️ ESCALATING, ➡️ ONGOING (compacto).
3. **Apêndice de fontes**: todas as URLs de evidência, clicáveis.

## Passo 6: Escreva o consolidado do mercado

Escreva `markets/<mercado>/weeks/<WEEK_ID>/consolidated.md`, que MESCLA todos os sinais do mercado:

- **Dedup entre sinais**: se a mesma empresa aparece em 2 ou mais sinais (ex: captou rodada E está contratando), conte como UM achado multi-sinal e DESTAQUE (empresa multi-sinal é o sinal mais forte do consolidado).
- **Resumo executivo**: só NEW e ESCALATING, uma linha por empresa, dizendo o sinal (ou sinais) e o que é novo vs a semana passada. Empresas multi-sinal primeiro.
- **Corpo**: as empresas agrupadas por força do achado (multi-sinal, depois sinal único), com o produto a puxar e a tese de dor.
- **Apêndice de fontes**: consolidado.

## Passo 7: Atualize a memória

- `markets/<mercado>/_state.json`: `last_run_week = WEEK_ID`, `last_run_date = <hoje>`, e `themes[]` (NEW criados, ESCALATING/ONGOING atualizados, DORMANT/RESOLVED remarcados).
- `markets/<mercado>/_themes.md`: tabela legível atualizada (apague a linha de exemplo se ainda estiver lá).
- `markets/<mercado>/_status.md`: Dashboard + nova linha no Weekly Run Log.

## Passo 8: Commit e push

```
feat(markets/<mercado>): weekly <WEEK_ID>
```

Lembrete final: idioma PT-BR, nunca usar travessão.
