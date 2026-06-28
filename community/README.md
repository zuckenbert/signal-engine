# Eixo: Comunidade (`community/`)

> **Modo: DETERMINÍSTICO.** A coleta é um script burro (`collect.sh`) que roda no CI / GitHub Actions, commita o dado cru em `_raw/` e a rotina (LLM) lê esse `_raw` depois. Entenda o porquê na seção "Quem faz o que: braço e cérebro" do README da raiz.

Antena apontada para intent dev-led / community-led: quem do seu ICP interage com os seus projetos open source, o seu fórum ou a sua comunidade.

## O que este eixo monitora

- Atividade nos seus repos open source: quem de FORA forka, dá star, abre issue ou manda PR.
- Movimento no seu fórum / canal de comunidade: quem pergunta, quem responde, quem volta.
- Sinais de adoção técnica: alguém do ICP testando, integrando ou citando seu projeto.

A lógica: um desenvolvedor ou time que mexe nos seus projetos sozinho já está a meio caminho de virar cliente. Esse é o intent dev-led.

## Como funciona

1. **Descoberta**: coleta a atividade da janela da semana (via API da fonte, como a API de um host de repositórios, ou via busca/leitura do fórum), filtra insiders (sua própria equipe) e classifica fit contra o ICP do `MARKET.md`.
2. **Reconciliação**: cada ator/sinal é casado contra a memória de continuidade (`_state.json`). Só NEW e ESCALATING entram no resumo executivo.

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
| `_targets.md` | Config: quais repos/fórum/comunidade ouvir, filtro de insider, mapa pro produto |
| `_state.json` | Memória máquina-legível (fonte de verdade NEW vs ONGOING) |
| `_themes.md` | Memória humana-legível (registro rolante de temas) |
| `_status.md` | Dashboard + Weekly Run Log |
| `_routine_prompt.md` | Prompt self-contained que o agente executa pra rodar o eixo na semana |
| `weeks/<week>/community.md` | Relatório gerado de cada semana |

## Custo

Roda barato: a API do host de repositórios costuma ter free tier generoso, e a leitura do fórum cabe numa ferramenta de busca/scrape gratuita. Reconciliação e escrita dentro da sua assinatura de IA. Custo marginal por semana tende a zero.
