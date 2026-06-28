# Eixo: Social (`social/`)

Antena apontada para intent marketing-led: quem do seu ICP reage ou comenta no seu conteúdo social.

## O que este eixo monitora

- Engajamento nos seus posts: quem curte, reage, comenta ou compartilha.
- Quem volta a engajar (engajamento repetido = intent crescente).
- O fit de cada engajador contra o ICP (a maioria do engajamento é ruído, o sinal é quem tem fit).

A lógica: alguém do seu ICP que para pra reagir ou comentar no seu conteúdo está levantando a mão, de forma sutil. Esse é o intent marketing-led.

## Como funciona

1. **Descoberta**: coleta os engajadores dos seus posts na janela da semana (via busca/scrape da plataforma ou API), filtra insiders e classifica fit contra o ICP do `MARKET.md`.
2. **Reconciliação**: cada engajador/sinal é casado contra a memória de continuidade (`_state.json`). Só NEW e ESCALATING entram no resumo executivo.

## A máquina de continuidade (5 estados)

| Estado | Significado | Como reportar |
| --- | --- | --- |
| **NEW** | 1a vez rastreado nesta semana | Entra no resumo executivo |
| **ESCALATING** | Já rastreado antes + desdobramento novo nesta semana | Entra no resumo executivo (destaque o que mudou) |
| **ONGOING** | Continua visível, sem novidade | Compacto, com contagem de semanas. NUNCA no resumo executivo |
| **DORMANT** | Não visto há 2 ou mais semanas | Fora do relatório ativo |
| **RESOLVED** | Concluído ou não visto há 4 ou mais semanas | Arquivado |

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
| `_state.json` | Memória máquina-legível (fonte de verdade NEW vs ONGOING) |
| `_themes.md` | Memória humana-legível (registro rolante de temas) |
| `_status.md` | Dashboard + Weekly Run Log |
| `_routine_prompt.md` | Prompt self-contained que o agente executa pra rodar o eixo na semana |
| `weeks/<week>/social.md` | Relatório gerado de cada semana |

## Custo

Roda barato: coleta de engajamento via uma ferramenta de busca/scrape (free tier) ou API da plataforma, e a reconciliação e escrita dentro da sua assinatura de IA. Custo marginal por semana tende a zero.
