# Sinais: {EIXO} - {YYYY-WXX}

> Template genérico de relatório de um eixo numa semana. Copie para `{eixo}/weeks/{YYYY-WXX}/{eixo}.md` e preencha.
> Idioma: PT-BR. Nunca usar travessão.

- **Eixo**: {EIXO}
- **Semana**: {YYYY-WXX} (janela: {DATA_INICIO} a {DATA_FIM})
- **Data do run**: {DATA}
- **Status**: PENDING REVIEW

## Resumo executivo

<!-- SÓ entram aqui os sinais NEW e ESCALATING. Nunca ONGOING.
     Uma linha por movimento, dizendo o que é novo vs a semana passada. -->
- {sinal novo 1}
- {sinal escalando 2 (o que mudou)}

## Sinais da semana (formato tabela)

> Use a tabela quando os sinais são simples e cabem em uma linha cada (bom pra eixos de lista conhecida e determinísticos).

| # | Empresa / Alvo | O que faz | Segmento | Detalhe do Sinal | Produto a puxar | Persona | Fonte (URL) | Status |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| 1 | {alvo} | {o que a empresa faz} | {segmento} | {o que foi observado} | {produto do mapa} | {cargo} | {https://fonte} | PENDING |

## Sinais da semana (formato bloco por empresa)

> Use blocos quando cada achado tem contexto rico (bom pra um sinal de descoberta do `markets/`,
> onde a empresa é desconhecida e precisa ser apresentada). Um bloco por empresa.

### 🆕 {Empresa} ({status: NEW | ESCALATING | ONGOING})

- **Setor**: {setor}
- **Status regulatório** (se aplicável): {ex: autorizada / em processo / n/a}
- **Tamanho**: {ex: funcionários / faturamento}
- **Investidores** (se aplicável): {ex: nomes ou n/a}
- **Fit / produto a puxar**: {fit alto/médio} -> {PRODUTO do mapa do MARKET.md}
- **Detalhe do sinal (in-window)**: {o que aconteceu e quando, dentro da janela}
- **Cluster de contexto**: {outros sinais/fatos que reforçam o achado}
- **Tese de dor**: {por que essa empresa provavelmente sente a dor que você resolve}
- **Fonte**: {https://fonte}

## Notas de outreach

<!-- Como abordar cada sinal: ângulo, gancho, CTA. Opcional por linha. -->
- {alvo}: {ângulo de abordagem}

## Enriquecimento (opcional)

<!-- Preencha quando o sinal virar lead trabalhado. -->

| Empresa | Domínio | Tamanho | Contato | Cargo | Email | LinkedIn |
| --- | --- | --- | --- | --- | --- | --- |
| {empresa} | {dominio.exemplo} | {tamanho} | {nome} | {cargo} | {email} | {url linkedin} |

## Definições de Status

- **PENDING**: sinal capturado, ainda não revisado.
- **APPROVED**: revisado, vale acionar.
- **SKIPPED**: revisado, descartado (ruído ou fora de fit).
- **SENT**: outreach enviado.
- **REPLIED**: alvo respondeu.
