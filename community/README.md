# Eixo: Comunidade (`community/`)

Antena apontada para intent dev-led / community-led: quem do seu ICP interage com os seus projetos open source, o seu forum ou a sua comunidade.

## O que este eixo monitora

- Atividade nos seus repos open source: quem de FORA forka, da star, abre issue ou manda PR.
- Movimento no seu forum / canal de comunidade: quem pergunta, quem responde, quem volta.
- Sinais de adocao tecnica: alguem do ICP testando, integrando ou citando seu projeto.

A logica: um desenvolvedor ou time que mexe nos seus projetos sozinho ja esta a meio caminho de virar cliente. Esse e o intent dev-led.

## Como funciona

1. **Descoberta**: coleta a atividade da janela da semana (via API da fonte, como a API de um host de repositorios, ou via busca/leitura do forum), filtra insiders (sua propria equipe) e classifica fit contra o ICP do `MARKET.md`.
2. **Reconciliacao**: cada ator/sinal e casado contra a memoria de continuidade (`_state.json`). So NEW e ESCALATING entram no resumo executivo.

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
  "theme_id":       "string, slug estavel (ex: ator + projeto)",
  "target":         "ator (pessoa/empresa) ou projeto a que o tema pertence",
  "category":       "fork | star | issue | pr | forum | adocao | outro",
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
| `_targets.md` | Config: quais repos/forum/comunidade ouvir, filtro de insider, mapa pro produto |
| `_state.json` | Memoria maquina-legivel (fonte de verdade NEW vs ONGOING) |
| `_themes.md` | Memoria humana-legivel (registro rolante de temas) |
| `_status.md` | Dashboard + Weekly Run Log |
| `_routine_prompt.md` | Prompt self-contained que o agente executa pra rodar o eixo na semana |
| `weeks/<week>/community.md` | Relatorio gerado de cada semana |

## Custo

Roda barato: a API do host de repositorios costuma ter free tier generoso, e a leitura do forum cabe numa ferramenta de busca/scrape gratuita. Reconciliacao e escrita dentro da sua assinatura de IA. Custo marginal por semana tende a zero.
