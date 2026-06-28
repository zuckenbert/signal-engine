---
name: signal-week
description: Roda uma semana do Signal Engine ponta a ponta sobre os eixos e mercados ja configurados, e entrega o digest (markdown e PDF polido). Use quando a pessoa quiser rodar a semana do monitoramento.
---

# Rodar a semana do Signal Engine

Voce executa uma semana inteira do monitoramento: cada eixo/mercado ativo, depois o digest, depois o PDF, e por fim mostra o resumo pra pessoa.

## Pre-requisito

O setup ja precisa ter sido feito: o `MARKET.md` da raiz preenchido (nao mais com os placeholders `{CHAVES}`) e ao menos um eixo ou mercado configurado. Se o `MARKET.md` ainda esta com placeholders ou nao ha nenhum eixo/mercado ativo, NAO tente rodar: oriente a pessoa a rodar a skill `signal-setup` primeiro, que conduz o setup passo a passo.

## Regras

- Idioma de toda saida: PT-BR, acentuacao correta. NUNCA use travessao (use virgula, ponto, parenteses ou dois-pontos).
- Regra de ouro da continuidade: NUNCA reporte ONGOING como novidade. So NEW e ESCALATING entram no resumo executivo. O sistema existe pra separar novidade de repeticao: respeite isso.

## Passo 1: Resolva a semana

Determine a ISO week atual no formato `AAAA-WXX` (ex: 2026-W24). Guarde como `WEEK_ID`. Use o fuso da secao 9 do `MARKET.md` pra resolver a janela (segunda a domingo).

## Passo 2: Descubra os eixos e mercados ativos

Varra o repo e monte a lista do que esta ativo:

- **Mercados**: cada pasta dentro de `markets/*/`, EXCETO `_TEMPLATE_MARKET` e `exemplo-mercado` (e qualquer pasta que comece com `_` ou com `exemplo`). Cada mercado ativo tem um `_targets.md` com ao menos um sinal ligado `[x]`.
- **Eixos de fonte unica**: `competitors/` e `official-records/`, se existirem (o setup pode ter apagado os que nao se aplicam).

Se nao encontrar nenhum eixo/mercado ativo, pare e oriente a rodar `signal-setup`.

## Passo 3: Execute cada eixo/mercado ativo

Para CADA eixo/mercado ativo, LEIA e SIGA o `_routine_prompt.md` daquele eixo/mercado. Esse prompt e self-contained e diz exatamente o que fazer (resolver semana, carregar contexto, coletar/interpretar, reconciliar contra a memoria de continuidade, escrever os relatorios da semana e atualizar o estado).

Determine o MODO do eixo antes de interpretar:

- **Se for DETERMINISTICO** (tem um `collect.sh`, ex: `official-records/`): garanta que o dado cru da semana existe. Se o `_raw/` nao tiver o arquivo da janela, rode o `collect.sh` daquele eixo ANTES de interpretar. So depois interprete o dado cru.
- **Se for JULGAMENTO** (`competitors/`, mercados em `markets/`): nao ha `collect.sh`. Voce mesmo coleta dentro da rotina, seguindo o `_routine_prompt.md`, usando as ferramentas de busca e leitura web conectadas ao seu agente.

Cada eixo/mercado deve terminar com seus arquivos da semana escritos em `weeks/<WEEK_ID>/` e a memoria (`_state.json`, `_themes.md`, `_status.md`) atualizada.

## Passo 4: Monte o digest

Rode o construtor do digest, que concatena os relatorios ja prontos num markdown unico:

```
WEEK_ID=<WEEK_ID> ./digest/build_digest.sh
```

Ele descobre os mercados e eixos sozinho e gera `digest/weeks/<WEEK_ID>/full.md`.

## Passo 5: Gere o PDF polido

Rode o render:

```
WEEK_ID=<WEEK_ID> ./digest/render.sh
```

Ele transforma o `full.md` num PDF com acabamento profissional em `digest/weeks/<WEEK_ID>/full.pdf`. Se as ferramentas de render (pandoc e weasyprint) nao estiverem instaladas, o script avisa como instalar e sai sem quebrar: nesse caso, informe a pessoa que o digest em markdown ja esta pronto e que o PDF e opcional.

## Passo 6: Mostre o resultado pra pessoa

- Apresente o RESUMO EXECUTIVO da semana: so os itens NEW e ESCALATING, em linguagem direta, dizendo o que e novo de verdade. Nao traga ONGOING pro resumo.
- Informe o caminho do digest em markdown (`digest/weeks/<WEEK_ID>/full.md`) e, se gerado, do PDF (`digest/weeks/<WEEK_ID>/full.pdf`).

## Lembrete final

PT-BR, sem travessao. Regra de ouro da continuidade: nunca reportar ONGOING como novidade.
