# Eixo: Registros Oficiais (`official-records/`)

> **Modo: DETERMINÍSTICO.** A coleta é um script burro (`collect.sh`) que roda no CI / GitHub Actions, commita o dado cru em `_raw/` e a rotina (LLM) lê esse `_raw` depois. Entenda o porquê na seção "Quem faz o que: braço e cérebro" do README da raiz.

Antena apontada para uma FONTE OFICIAL / REGISTRO PÚBLICO que sempre devolve a mesma coisa do mesmo jeito: um endpoint, um feed, um registro de licenças/atos/autorizações. É o exemplo canônico do modo determinístico, porque a coleta dá pra escrever como um script que faz sempre a mesma chamada, sem precisar de julgamento.

Serve pra QUALQUER fonte com API/endpoint fixo: um registro público de autorizações do seu setor, um feed de publicações oficiais, um endpoint de dados abertos. Você troca a URL no `collect.sh` e está rodando.

## O que este eixo monitora

- Novos registros/atos publicados pela fonte oficial na janela.
- Quando o registro traz atores (empresas/pessoas), os novos atores que entraram, pra de-anonimizar e classificar fit.

## Como funciona (braço e cérebro separados)

1. **Coleta (braço, sem LLM)**: o `collect.sh` roda no GitHub Actions, chama a fonte e salva `official-records/_raw/<AAAA-MM-DD>.json`. Esse `_raw` é VERSIONADO (commitado) e é o "bastão" pra rotina ler.
2. **Interpretação (cérebro, LLM)**: a rotina (`_routine_prompt.md`) lê o `_raw` da janela, classifica cada registro, de-anonimiza e classifica fit contra o ICP quando houver atores, reconcilia contra a memória e escreve o relatório.

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
  "theme_id":       "string, slug estavel (ex: ator + tipo de registro)",
  "target":         "ator (empresa/pessoa) ou o objeto do registro",
  "category":       "novo-registro | norma | atualizacao | outro",
  "title":          "titulo curto do tema",
  "summary":        "resumo de 1 a 2 linhas",
  "since":          "AAAA-MM-DD, data real da publicacao",
  "first_seen_week":"AAAA-WXX, 1a semana em que NOS rastreamos",
  "last_seen_week": "AAAA-WXX, ultima semana em que reapareceu",
  "weeks_seen":     ["AAAA-WXX", "..."],
  "status":         "NEW | ESCALATING | ONGOING | DORMANT | RESOLVED",
  "fit":            "alto | medio | baixo | n/a (quando o registro tem ator)",
  "evidence_urls":  ["https://fonte-1", "..."]
}
```

## Arquivos do eixo

| Arquivo | Papel |
| --- | --- |
| `README.md` | Este arquivo |
| `_targets.md` | Config: qual fonte oficial, o que conta como sinal, mapa pro produto |
| `collect.sh` | Coletor determinístico (roda no Actions, salva `_raw/<data>.json`) |
| `_raw/<data>.json` | Dado cru versionado (o bastão entre Actions e a rotina) |
| `_state.json` | Memória máquina-legível (fonte de verdade NEW vs ONGOING) |
| `_themes.md` | Memória humana-legível (registro rolante de temas) |
| `_status.md` | Dashboard + Weekly Run Log |
| `_routine_prompt.md` | Prompt self-contained do run semanal |
| `weeks/<week>/official-records.md` | Relatório gerado de cada semana |

## Custo

Roda barato: a fonte oficial costuma ser pública/gratuita, a coleta roda de graça no Actions, e a interpretação cabe na sua assinatura de IA. Custo marginal por semana tende a zero.
