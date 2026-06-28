# Rotina semanal: Eixo Registros Oficiais

> Prompt self-contained. Assuma que você (agente de IA) acabou de clonar este repo e tem ZERO contexto.
> Execute os passos na ordem. Idioma de toda saída: PT-BR. NUNCA use travessão (use vírgula, ponto, parênteses ou dois-pontos).

Você é um agente que roda o eixo de Registros Oficiais (modo determinístico) por uma semana e produz um relatório versionado.

## Passo 1: Resolva a semana

- Determine a ISO week atual no formato `AAAA-WXX` (ex: 2026-W24).
- Determine a janela: segunda a domingo (use o fuso da seção 9 do `MARKET.md`).
- Guarde `WEEK_ID` e a janela.

## Passo 2: Carregue o contexto

Leia, nesta ordem:
1. `MARKET.md` (raiz): ICP (seção 4), personas (seção 5), regulador/fonte oficial (seção 7) e mapa sinal -> produto (seção 8).
2. `official-records/_targets.md`: qual fonte coletar, o que conta como sinal vs ruído, como de-anonimizar e o filtro de fit.
3. `official-records/_state.json`: a MEMÓRIA. Anote `last_run_date` e `themes[]`. Defina `startDate = last_run_date` (se null, é o 1o run).
4. `official-records/_status.md`: último run no Weekly Run Log.

## Passo 3: Descoberta (eixo DETERMINÍSTICO: leia o `_raw`)

Este eixo é DETERMINÍSTICO. O coletor (`official-records/collect.sh`) já rodou no CI (GitHub Actions) e deixou os arquivos `official-records/_raw/<data>.json` da janela versionados no Git. O braço já coletou: você só precisa LER o dado cru, não decidir o que buscar.

- **Leia o `_raw` da janela**: abra todos os `official-records/_raw/<data>.json` cujas datas caem entre `startDate` e o fim da janela.
- **Se faltar algum dia** (um arquivo `_raw/<data>.json` esperado não existe, ex: o Actions não rodou): você mesmo pode rodar `bash official-records/collect.sh` (ou `DATE=AAAA-MM-DD bash official-records/collect.sh` pra um dia específico) pra preencher a lacuna antes de continuar.
- **Classifique cada registro**: separe sinal de ruído conforme o `_targets.md` (republicação, retificação sem conteúdo, fora de escopo = ruído).
- **De-anonimize e classifique fit** (quando o registro tiver atores): para cada novo ator (empresa/pessoa), descubra quem é (pode usar busca web pra cruzar nome/identificador) e classifique fit contra o ICP (seção 4 do MARKET.md). DESCARTE quem não tem fit. É aqui que entra o seu julgamento, não na coleta.

Junte os achados já classificados: ator/objeto, categoria, o que foi publicado, data, fit, URL(s).

## Passo 4: Reconciliação contra `_state.json`

Para cada achado, case semanticamente contra `themes[]`:

- **Casou, sem novidade**: ONGOING. Atualize `last_seen_week`, append em `weeks_seen`, junte URLs novas. Não reporte no resumo executivo.
- **Casou, com desdobramento novo**: ESCALATING. Atualize os campos e `summary`, `status = ESCALATING`. Reporte no resumo executivo.
- **Não casou**: NEW. Crie tema novo (shape no README do eixo), `first_seen_week = WEEK_ID`, `weeks_seen = [WEEK_ID]`, `status = NEW`, registre `fit`. Reporte no resumo executivo.

Temas que não reapareceram: não visto 2 ou mais semanas = DORMANT; 4 ou mais = RESOLVED.

**Regra de ouro: NUNCA reporte ONGOING como novidade. Só NEW e ESCALATING entram no resumo executivo.**

## Passo 5: Gere o relatório

Escreva `official-records/weeks/<WEEK_ID>/official-records.md` (siga o espírito do `SIGNAL_TEMPLATE.md` da raiz):

1. **Header**: título, `WEEK_ID`, janela e data do run.
2. **Resumo executivo**: SÓ NEW e ESCALATING, uma linha por registro, o que é novo vs a semana passada.
3. **Corpo**: um bloco por registro/ator com fit, marcador de status (🆕 NEW, ⬆️ ESCALATING, ➡️ ONGOING compacto com contagem de semanas), categoria, o produto a puxar (do mapa do MARKET.md) e, quando houver ator, a tese de dor.
4. **Apêndice de fontes**: URLs clicáveis.

## Passo 6: Atualize a memória

- `official-records/_state.json`: `last_run_week`, `last_run_date`, e `themes[]` (NEW criados, ESCALATING/ONGOING atualizados, DORMANT/RESOLVED remarcados).
- `official-records/_themes.md`: tabela legível atualizada (apague a linha de exemplo).
- `official-records/_status.md`: Dashboard + nova linha no Weekly Run Log.

## Passo 7: Commit e push

```
feat(official-records): weekly watch <WEEK_ID>
```

Lembrete final: idioma PT-BR, nunca usar travessão.
