# Rotina semanal: _TEMPLATE_AXIS (esqueleto)

<!-- COMO ADAPTAR ESTE EIXO:
     Este e o arquivo MAIS IMPORTANTE do eixo. Ele tem que ser self-contained: assuma que o agente
     clonou o repo e tem ZERO contexto. A espinha (passos 1, 2, 4, 5, 6, 7) e identica em todos os eixos:
     copie de competitors/, community/ ou social/ (o que for mais parecido). So o passo 3 (DESCOBERTA)
     muda de eixo pra eixo: e ali que voce descreve COMO buscar a sua fonte. Troque <seu-eixo> pelo nome real. -->

> Prompt self-contained. Idioma de toda saida: PT-BR. NUNCA use travessao.

Voce e um agente que roda o eixo `<seu-eixo>` por uma semana e produz um relatorio versionado.

## Passo 1: Resolva a semana

- ISO week atual no formato `AAAA-WXX`.
- Janela: segunda a domingo (fuso da secao 9 do `MARKET.md`).
- Guarde `WEEK_ID` e a janela.

## Passo 2: Carregue o contexto

1. `MARKET.md` (raiz): ICP, personas, concorrentes e mapa sinal -> produto.
2. `<seu-eixo>/_targets.md`: os alvos/fontes e o que conta como sinal.
3. `<seu-eixo>/_state.json`: a MEMORIA. `startDate = last_run_date` (null = 1o run).
4. `<seu-eixo>/_status.md`: ultimo run.

## Passo 3: Descoberta

<!-- COMO ADAPTAR ESTE EIXO: descreva aqui, de forma agnostica de ferramenta, COMO coletar a sua fonte
     desde startDate. Mencione as opcoes que se aplicam:
     - sua ferramenta de busca web (ex: um MCP de web search) com filtro de data;
     - sua ferramenta de leitura/scrape de paginas (com deteccao de mudanca/diff vs evidence_urls antigos);
     - a API da fonte, se houver.
     NAO cite nenhuma ferramenta proprietaria pelo nome. Junte os achados crus: alvo, categoria, o que
     aconteceu, data, URL(s) de evidencia. Aplique o filtro de ruido do _targets.md. -->

## Passo 4: Reconciliacao contra `_state.json`

Para cada achado, case semanticamente contra `themes[]`:
- Casou sem novidade = ONGOING (atualiza `last_seen_week`, append em `weeks_seen`, junta `evidence_urls`). Nao reporte no resumo.
- Casou com desdobramento = ESCALATING (atualiza campos + `summary`, `status = ESCALATING`). Reporte no resumo.
- Nao casou = NEW (cria tema, `first_seen_week = WEEK_ID`, `weeks_seen = [WEEK_ID]`). Reporte no resumo.
- Nao visto 2 ou mais semanas = DORMANT; 4 ou mais = RESOLVED.

**Regra de ouro: NUNCA reporte ONGOING como novidade. So NEW e ESCALATING entram no resumo executivo.**

## Passo 5: Gere o relatorio

Escreva `<seu-eixo>/weeks/<WEEK_ID>/<seu-eixo>.md`:
1. Header (titulo, `WEEK_ID`, janela, data do run).
2. Resumo executivo (SO NEW e ESCALATING, o que mudou vs a semana passada).
3. Corpo por alvo (marcador de status: 🆕 NEW, ⬆️ ESCALATING, ➡️ ONGOING compacto com contagem de semanas).
4. "E dai? / So what" (uma linha de implicacao por movimento, qual produto puxar).
5. Apendice de fontes (URLs clicaveis).

## Passo 6: Atualize a memoria

- `<seu-eixo>/_state.json`: `last_run_week`, `last_run_date`, `themes[]`.
- `<seu-eixo>/_themes.md`: tabela legivel (apague a linha de exemplo).
- `<seu-eixo>/_status.md`: Dashboard + nova linha no Weekly Run Log.

## Passo 7: Commit e push

```
feat(<seu-eixo>): weekly watch <WEEK_ID>
```

Lembrete final: idioma PT-BR, nunca usar travessao.
