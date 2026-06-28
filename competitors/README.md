# Eixo: Concorrentes (`competitors/`)

> **Modo: JULGAMENTO, sabor LISTA CONHECIDA.** A própria LLM coleta dentro da rotina (`_routine_prompt.md`), decidindo o que buscar e quais páginas ler. NÃO tem `collect.sh` nem Actions de coleta, porque não dá pra escrever um script burro que saiba o que é relevante. O sabor é LISTA CONHECIDA: você JÁ SABE quem observar (os concorrentes do `MARKET.md`). Isso difere do motor `markets/`, que também é julgamento mas no sabor DESCOBERTA (pesca empresas desconhecidas a partir de um sinal). Entenda os dois sabores na seção "Os dois modos e os dois sabores de julgamento" do README da raiz.

Antena apontada para o movimento dos seus concorrentes: o que eles publicam na web (notícias, lançamentos, parcerias) e o que muda nas páginas próprias deles (site, blog, sala de imprensa).

## O que este eixo monitora

- Anúncios institucionais: lançamentos, parcerias, rodadas, contratações-chave, expansão.
- Movimento de porta-vozes: o que executivos e times dos concorrentes dizem em entrevistas, posts e palestras.
- Mudança nas páginas próprias do concorrente: nova página de produto, mudança de pricing, nova mensagem na home.

## Como funciona

Toda semana o eixo faz dois passos:

1. **Descoberta**: busca notícias e lê as páginas dos concorrentes listados em `_targets.md` (que apontam pro `MARKET.md`), detectando o que é novo na janela da semana.
2. **Reconciliação**: cada achado é casado contra a memória de continuidade (`_state.json`) pra decidir se é novo de verdade ou se já foi visto. Só NEW e ESCALATING entram no resumo executivo.

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
| `_state.json` | Memória máquina-legível (fonte de verdade NEW vs ONGOING) |
| `_themes.md` | Memória humana-legível (registro rolante de temas) |
| `_status.md` | Dashboard + Weekly Run Log |
| `_routine_prompt.md` | Prompt self-contained que o agente executa pra rodar o eixo na semana |
| `weeks/<week>/competitors.md` | Relatório gerado de cada semana |

## Custo

Roda barato: busca de notícias e leitura de páginas no free tier de uma ferramenta de busca/scrape, e a reconciliação e escrita dentro da sua assinatura de IA. Custo marginal por semana tende a zero.
