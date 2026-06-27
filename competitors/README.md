# Eixo: Concorrentes (`competitors/`)

Antena apontada para o movimento dos seus concorrentes: o que eles publicam na web (noticias, lancamentos, parcerias) e o que muda nas paginas proprias deles (site, blog, sala de imprensa).

## O que este eixo monitora

- Anuncios institucionais: lancamentos, parcerias, rodadas, contratacoes-chave, expansao.
- Movimento de porta-vozes: o que executivos e times dos concorrentes dizem em entrevistas, posts e palestras.
- Mudanca nas paginas proprias do concorrente: nova pagina de produto, mudanca de pricing, nova mensagem na home.

## Como funciona

Toda semana o eixo faz dois passos:

1. **Descoberta**: busca noticias e le as paginas dos concorrentes listados em `_targets.md` (que apontam pro `MARKET.md`), detectando o que e novo na janela da semana.
2. **Reconciliacao**: cada achado e casado contra a memoria de continuidade (`_state.json`) pra decidir se e novo de verdade ou se ja foi visto. So NEW e ESCALATING entram no resumo executivo.

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
  "theme_id":       "string, slug estavel do tema",
  "target":         "concorrente a que o tema pertence",
  "category":       "lancamento | parceria | pricing | contratacao | porta-voz | outro",
  "title":          "titulo curto do tema",
  "summary":        "resumo de 1 a 2 linhas",
  "since":          "AAAA-MM-DD, data real do movimento no mundo",
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
| `_targets.md` | Config: quais concorrentes e URLs monitorar, mapa pro produto |
| `_state.json` | Memoria maquina-legivel (fonte de verdade NEW vs ONGOING) |
| `_themes.md` | Memoria humana-legivel (registro rolante de temas) |
| `_status.md` | Dashboard + Weekly Run Log |
| `_routine_prompt.md` | Prompt self-contained que o agente executa pra rodar o eixo na semana |
| `weeks/<week>/competitors.md` | Relatorio gerado de cada semana |

## Custo

Roda barato: busca de noticias e leitura de paginas no free tier de uma ferramenta de busca/scrape, e a reconciliacao e escrita dentro da sua assinatura de IA. Custo marginal por semana tende a zero.
