# Eixo: _TEMPLATE_AXIS (esqueleto)

> Este e o esqueleto pra criar um eixo novo. NAO rode este eixo. Clone-o.
> Estilo: nunca usar travessao.

## Como criar um eixo novo a partir deste esqueleto

1. **Copie esta pasta** e renomeie pro nome do seu eixo (ex: `events/`, `jobs/`, `news/`).
2. **Preencha `_targets.md`**: diga quais alvos/fontes esse eixo monitora e o mapa sinal -> produto, sempre apontando de volta pro `MARKET.md` como fonte de verdade.
3. **Preencha `_routine_prompt.md`**: e o arquivo mais importante. Adapte a parte de DESCOBERTA ao tipo de fonte do seu eixo (a espinha de reconciliacao + continuidade + relatorio e a mesma dos outros eixos, pode copiar de `competitors/_routine_prompt.md`, `community/_routine_prompt.md` ou `social/_routine_prompt.md`, o que for mais parecido).
4. **Deixe `_state.json` como esta** (memoria vazia: `themes` vazio, `last_run_*` em null). Ele se preenche no 1o run.
5. **Mantenha `_themes.md` e `_status.md`** com header + linha de exemplo (apague a de exemplo no 1o run real).
6. **Plugue no digest**: edite o array `AXES` em `digest/build_digest.sh` e adicione uma linha:
   ```
   "<seu-eixo>/weeks/$WEEK_ID/<seu-eixo>.md|Nome Exibido|Descricao curta"
   ```
7. **Mantenha `weeks/.gitkeep`** pra versionar a pasta vazia.

## O que este eixo monitora

<!-- COMO ADAPTAR ESTE EIXO: descreva em uma frase a fonte de sinal que este eixo escuta
     (ex: "novos editais publicados no portal X", "vagas abertas no ICP", "novas licencas no registro oficial"). -->

## A maquina de continuidade (5 estados)

Todos os eixos compartilham a mesma maquina. Nao altere os estados.

| Estado | Significado | Como reportar |
| --- | --- | --- |
| **NEW** | 1a vez rastreado nesta semana | Entra no resumo executivo |
| **ESCALATING** | Ja rastreado antes + desdobramento novo nesta semana | Entra no resumo executivo (destaque o que mudou) |
| **ONGOING** | Continua visivel, sem novidade | Compacto, com contagem de semanas. NUNCA no resumo executivo |
| **DORMANT** | Nao visto ha 2 ou mais semanas | Fora do relatorio ativo |
| **RESOLVED** | Concluido ou nao visto ha 4 ou mais semanas | Arquivado |

**Regra de ouro: NUNCA reporte ONGOING como novidade.**

### Shape de um tema individual (dentro de `themes[]` no `_state.json`)

```
{
  "theme_id":       "string, slug estavel do tema",
  "target":         "alvo a que o tema pertence",
  "category":       "<adapte as categorias ao seu eixo>",
  "title":          "titulo curto do tema",
  "summary":        "resumo de 1 a 2 linhas",
  "since":          "AAAA-MM-DD, data real do evento no mundo",
  "first_seen_week":"AAAA-WXX, 1a semana em que NOS rastreamos",
  "last_seen_week": "AAAA-WXX, ultima semana em que reapareceu",
  "weeks_seen":     ["AAAA-WXX", "..."],
  "status":         "NEW | ESCALATING | ONGOING | DORMANT | RESOLVED",
  "evidence_urls":  ["https://fonte-1", "..."]
}
```

## Arquivos do eixo

| Arquivo | Papel |
| --- | --- |
| `README.md` | Este arquivo |
| `_targets.md` | Config: alvos/fontes do eixo, mapa pro produto |
| `_state.json` | Memoria maquina-legivel (fonte de verdade NEW vs ONGOING) |
| `_themes.md` | Memoria humana-legivel |
| `_status.md` | Dashboard + Weekly Run Log |
| `_routine_prompt.md` | Prompt self-contained do run semanal |
| `weeks/<week>/<seu-eixo>.md` | Relatorio gerado de cada semana |

## Custo

<!-- COMO ADAPTAR ESTE EIXO: estime o custo da fonte deste eixo (free tier de busca/scrape,
     custo de API, etc) + a geracao dentro da sua assinatura de IA. -->
