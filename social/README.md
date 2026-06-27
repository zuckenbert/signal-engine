# Eixo: Social (`social/`)

Antena apontada para intent marketing-led: quem do seu ICP reage ou comenta no seu conteudo social.

## O que este eixo monitora

- Engajamento nos seus posts: quem curte, reage, comenta ou compartilha.
- Quem volta a engajar (engajamento repetido = intent crescente).
- O fit de cada engajador contra o ICP (a maioria do engajamento e ruido, o sinal e quem tem fit).

A logica: alguem do seu ICP que para pra reagir ou comentar no seu conteudo esta levantando a mao, de forma sutil. Esse e o intent marketing-led.

## Como funciona

1. **Descoberta**: coleta os engajadores dos seus posts na janela da semana (via busca/scrape da plataforma ou API), filtra insiders e classifica fit contra o ICP do `MARKET.md`.
2. **Reconciliacao**: cada engajador/sinal e casado contra a memoria de continuidade (`_state.json`). So NEW e ESCALATING entram no resumo executivo.

## A maquina de continuidade (5 estados)

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
  "theme_id":       "string, slug estavel (ex: engajador + handle)",
  "target":         "pessoa/empresa engajadora",
  "category":       "reacao | comentario | compartilhamento | engajamento-repetido | outro",
  "title":          "titulo curto do tema",
  "summary":        "resumo de 1 a 2 linhas",
  "since":          "AAAA-MM-DD, data real do engajamento",
  "first_seen_week":"AAAA-WXX, 1a semana em que NOS rastreamos",
  "last_seen_week": "AAAA-WXX, ultima semana em que reapareceu",
  "weeks_seen":     ["AAAA-WXX", "..."],
  "status":         "NEW | ESCALATING | ONGOING | DORMANT | RESOLVED",
  "evidence_urls":  ["https://post-ou-perfil", "..."]
}
```

## Arquivos do eixo

| Arquivo | Papel |
| --- | --- |
| `README.md` | Este arquivo |
| `_targets.md` | Config: quais perfis/posts monitorar, filtro de insider, mapa pro produto |
| `_state.json` | Memoria maquina-legivel (fonte de verdade NEW vs ONGOING) |
| `_themes.md` | Memoria humana-legivel (registro rolante de temas) |
| `_status.md` | Dashboard + Weekly Run Log |
| `_routine_prompt.md` | Prompt self-contained que o agente executa pra rodar o eixo na semana |
| `weeks/<week>/social.md` | Relatorio gerado de cada semana |

## Custo

Roda barato: coleta de engajamento via uma ferramenta de busca/scrape (free tier) ou API da plataforma, e a reconciliacao e escrita dentro da sua assinatura de IA. Custo marginal por semana tende a zero.
