# Eixo: Mercados (`markets/`)

> **Modo: JULGAMENTO, sabor DESCOBERTA.** A própria LLM coleta dentro da rotina (`_routine_prompt.md`), decidindo o que buscar, lendo os resultados e avaliando relevância. NÃO tem `collect.sh` nem Actions de coleta. A diferença pro eixo `competitors/` (que também é julgamento) é o sabor: lá você JÁ SABE quem observar (uma lista conhecida), aqui você NÃO TEM lista. Você pesca empresas desconhecidas a partir de um sinal. Entenda os dois sabores na seção "Os dois modos e os dois sabores de julgamento" do README da raiz.

Este é o motor de DESCOBERTA do Signal Engine. Em vez de vigiar uma lista de empresas, ele parte de um SINAL (ex: "quem captou rodada", "quem está contratando para a área que eu atendo") e descobre empresas novas que disparam esse sinal, valida o fit contra o seu ICP e te entrega só quem importa.

## O padrão multi-região (uma pasta por mercado)

Cada mercado ou geografia que você quer cobrir é uma PASTA dentro de `markets/`. Para criar um mercado novo:

1. **Copie a pasta `_TEMPLATE_MARKET/`** e renomeie pro seu mercado (ex: `markets/brasil/`, `markets/mercado-x-pais-y/`).
2. **Preencha o `_targets.md`** desse mercado: nome/geografia, idioma/fuso (ou herda do `MARKET.md`) e a suite de sinais que você quer ligar.
3. **Deixe o `_state.json`** como está (memória vazia). Ele se preenche no 1o run.
4. **Rode o `_routine_prompt.md`** desse mercado toda semana.

A pasta `_TEMPLATE_MARKET/` é o molde: NÃO rode ela, clone. A pasta `exemplo-mercado/` é uma ilustração levemente preenchida que você pode apagar.

## O conceito de suite de sinais de descoberta

Cada mercado roda uma SUITE de sinais. Um sinal é uma definição de "o que conta como pista de que uma empresa desconhecida pode virar cliente". No sabor descoberta, o alvo não é uma lista de empresas: é a DEFINIÇÃO DO SINAL, ou seja:

- **Queries-semente**: as buscas-base que a LLM expande pra pescar candidatos.
- **Termos / cargos que contam**: o vocabulário que indica que o sinal é real (ex: nomes de cargos técnicos, termos de rodada, termos do tema que você resolve).
- **Janela**: o período que vale (normalmente a semana, mas pode ser maior pra sinais raros).
- **Filtro de ICP**: puxado do `MARKET.md`, é o que separa um achado relevante do ruído.

A suite é um MENU. Você liga e desliga sinais com checkbox no `_targets.md` (`[ ]` desligado, `[x]` ligado) e adiciona os seus próprios. Comece com 1 ou 2 sinais e amplie.

## Como a semana fecha

Para cada mercado, numa semana:

- Cada sinal habilitado vira UM arquivo: `markets/<mercado>/weeks/<week>/<sinal>.md`.
- Todos os sinais do mercado são mesclados num `markets/<mercado>/weeks/<week>/consolidated.md`, que dedupa empresa entre sinais (a mesma empresa aparecendo em 2 ou mais sinais é um achado multi-sinal, destaque) e traz só NEW e ESCALATING no resumo executivo.
- É o `consolidated.md` de cada mercado que o digest puxa.

## A máquina de continuidade (5 estados)

Cada sinal por empresa vira um tema com ciclo de vida, igual aos outros eixos. A memória (`_state.json`) guarda esses temas entre as semanas.

| Estado | Significado | Como reportar |
| --- | --- | --- |
| **NEW** | 1a vez rastreado nesta semana | Entra no resumo executivo |
| **ESCALATING** | Já rastreado antes + desdobramento novo nesta semana | Entra no resumo executivo (destaque o que mudou) |
| **ONGOING** | Continua visível, sem novidade | Compacto, com contagem de semanas. NUNCA no resumo executivo |
| **DORMANT** | Não visto há 2 ou mais semanas | Fora do relatório ativo |
| **RESOLVED** | Concluído ou não visto há 4 ou mais semanas | Arquivado |

**Regra de ouro: NUNCA reporte ONGOING como novidade. Só NEW e ESCALATING entram no resumo executivo.**

### Shape de um tema individual (dentro de `themes[]` no `_state.json`)

```
{
  "theme_id":       "string, slug estavel (ex: empresa + sinal)",
  "target":         "empresa/ator que disparou o sinal",
  "signal":         "qual sinal da suite (ex: fundraising, hiring-tech)",
  "category":       "<adapte ao sinal>",
  "title":          "titulo curto do tema",
  "summary":        "resumo de 1 a 2 linhas",
  "since":          "AAAA-MM-DD, data real do evento no mundo",
  "first_seen_week":"AAAA-WXX, 1a semana em que NOS rastreamos",
  "last_seen_week": "AAAA-WXX, ultima semana em que reapareceu",
  "weeks_seen":     ["AAAA-WXX", "..."],
  "status":         "NEW | ESCALATING | ONGOING | DORMANT | RESOLVED",
  "fit":            "alto | medio | baixo (resultado do filtro de ICP)",
  "evidence_urls":  ["https://fonte-1", "..."]
}
```

## Arquivos de cada mercado

| Arquivo | Papel |
| --- | --- |
| `_targets.md` | Config: nome/geografia do mercado + suite de sinais (menu liga/desliga) |
| `_state.json` | Memória máquina-legível (fonte de verdade NEW vs ONGOING) |
| `_themes.md` | Memória humana-legível (registro rolante de temas) |
| `_status.md` | Dashboard + Weekly Run Log |
| `_routine_prompt.md` | Prompt self-contained do run semanal (modo descoberta) |
| `weeks/<week>/<sinal>.md` | Relatório de cada sinal habilitado |
| `weeks/<week>/consolidated.md` | Mescla de todos os sinais do mercado naquela semana |

## Custo

Roda barato: busca e leitura na web no free tier de uma ferramenta de busca/scrape, e a reconciliação e escrita dentro da sua assinatura de IA. O custo cresce com o número de sinais ligados e mercados, não com a semana. Ligue poucos sinais e amplie aos poucos.
