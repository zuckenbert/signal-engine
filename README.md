# Signal Engine

Um template (fork e preencha) para construir uma maquina que escuta o seu mercado.

> Este e um TEMPLATE agnostico de mercado. Nao ha nenhuma empresa, produto, concorrente, regulador ou ferramenta proprietaria embutida. Voce clona, preenche um arquivo de config (`MARKET.md`), ajusta os alvos de cada eixo e sai rodando.

## O que e

Signal Engine e uma maquina que escuta o mercado. Toda semana ela faz a mesma rotina disciplinada: varias fontes de sinal (cada fonte e uma pasta, chamada de "eixo") coletam o que aconteceu, separam o ruido do que importa, reconciliam o achado contra uma memoria de continuidade (pra saber o que e novo de verdade vs o que ja foi visto antes) e, no fim, um DIGEST costura tudo num relatorio unico.

Como tudo vive no Git, cada semana vira um ponto no tempo. O diff entre duas semanas e, literalmente, o movimento do mercado capturado por escrito.

## Como funciona (a metafora)

Pense num radar. Ele varre o ceu em circulos, sempre na mesma cadencia. Cada volta, ele compara o que ve agora com o que viu na volta anterior. Um ponto novo na tela chama atencao. Um ponto que ja estava la e so andou um pouco e contexto, nao alarme. Um ponto que sumiu por varias voltas e arquivado.

O Signal Engine e esse radar para o seu mercado:
- Cada **eixo** e uma antena apontada para uma fonte de sinal (concorrentes, comunidade, social, etc).
- Cada semana e uma volta do radar.
- A **memoria de continuidade** e o que separa "ponto novo" de "ponto que ja estava la".
- O **digest** e a tela unica onde todas as antenas aparecem juntas.

## O conceito de eixo

Um eixo e uma pasta autocontida que monitora UMA fonte de sinal. Cada eixo tem a mesma anatomia (config, memoria, dashboard, prompt de rotina e a pasta de relatorios semanais) e roda de forma independente. Adicionar uma nova fonte ao seu radar e literalmente copiar uma pasta de eixo, trocar os alvos e plugar no digest.

Eixos de exemplo que ja vem no template:

| Eixo | Tipo de intent | O que escuta |
| --- | --- | --- |
| `competitors/` | competitor-led | Movimentos institucionais e de porta-vozes dos seus concorrentes, na web e nas paginas proprias deles |
| `community/` | dev-led / community-led | Quem do seu ICP interage com seus projetos open source, forum ou comunidade |
| `social/` | marketing-led | Quem do seu ICP reage ou comenta no seu conteudo social |
| `_TEMPLATE_AXIS/` | (esqueleto) | Pasta vazia pra clonar e criar um eixo novo |

## A maquina de continuidade (o coracao do sistema)

Cada sinal detectado vira um "tema" com um ciclo de vida. A memoria de cada eixo (`_state.json`) guarda esses temas entre as semanas. E isso que evita o pior erro de qualquer monitoramento: reportar a mesma coisa toda semana como se fosse nova.

| Estado | Significado | Como reportar |
| --- | --- | --- |
| **NEW** | 1a vez rastreado nesta semana | Entra no resumo executivo |
| **ESCALATING** | Ja rastreado antes + um desdobramento novo nesta semana | Entra no resumo executivo (destaque o que mudou) |
| **ONGOING** | Continua visivel, sem novidade | Reportar de forma compacta, com a contagem de semanas. NUNCA no resumo executivo |
| **DORMANT** | Nao visto ha 2 ou mais semanas | Fora do relatorio ativo |
| **RESOLVED** | Concluido ou nao visto ha 4 ou mais semanas | Arquivado |

**Regra de ouro: NUNCA reporte ONGOING como novidade. So NEW e ESCALATING entram no resumo executivo.**

Isso e o que faz o relatorio ser lido. Quem recebe o digest confia que tudo ali e, de fato, movimento desta semana.

## O digest

O digest concatena o relatorio de cada eixo da semana num markdown unico, costurando tudo numa leitura so. E onde o dado bruto vira contexto pro time: ao inves de tres relatorios soltos, uma pessoa de comercial, produto ou lideranca abre um documento e entende a semana do mercado de cima a baixo.

O digest e gerado por `digest/build_digest.sh` (veja `digest/README.md`).

## Git como linha do tempo

Cada semana e um commit. Isso da, de graca:
- **Historico**: `git log` mostra todas as semanas que a maquina rodou.
- **Diff de mercado**: `git diff` entre dois commits semanais mostra exatamente o que mudou no mercado.
- **Auditoria**: cada sinal tem fonte (URL) e data, versionados.
- **Continuidade**: o `_state.json` versionado e a prova de quando cada tema apareceu pela 1a vez.

## QUICKSTART: plugue seu mercado

### Passo 1: preencha `MARKET.md`
E a unica config global. Diga quem voce e, o que vende, qual seu mercado, seu ICP, suas personas, seus concorrentes, seu regulador (se houver) e o mapa "sinal -> produto". Tudo vem com placeholder e instrucao inline.

### Passo 2: ajuste os `_targets.md` de cada eixo
Cada eixo tem um `_targets.md` que diz quem ou o que monitorar (URLs canonicas, contas, repos, etc) e pra qual produto puxar cada tipo de sinal. Os alvos apontam de volta pro `MARKET.md` como fonte de verdade.

### Passo 3: escolha como rodar
Duas formas:
- **Manual**: voce abre seu agente de IA (ex: um CLI de coding assistant), aponta pro `_routine_prompt.md` do eixo e manda rodar.
- **Agendado**: um cron ou CI (ex: um workflow agendado num schedule semanal, ou uma routine agendada do seu assistente) dispara o mesmo prompt sozinho.

As ferramentas de busca e leitura web entram como conectores (MCP) do seu agente. Nao ha nada proprietario amarrado.

### Passo 4: rode a 1a semana
Rode o `_routine_prompt.md` de cada eixo. Na 1a semana, tudo sera NEW (a memoria comeca vazia). A partir da 2a semana, a maquina de continuidade comeca a separar novo de continuo. Depois, rode `WEEK_ID=AAAA-WXX ./digest/build_digest.sh` pra costurar o digest.

## Custo estimado

Pensado pra rodar barato:
- **Busca e leitura web**: cabe no free tier da maioria das ferramentas de busca e scrape (ou no plano que voce ja tem).
- **Geracao do relatorio**: roda dentro da sua assinatura de IA (o agente faz o trabalho de reconciliacao e escrita).
- **Hospedagem**: Git (o repo e o produto).

Na pratica, o custo marginal de mais uma semana tende a zero. O investimento e o tempo de preencher o `MARKET.md` uma vez.

## Estilo de escrita

Todo o conteudo e em PT-BR e nunca usa travessao. Use virgula, ponto, parenteses ou dois-pontos. Vale pra todos os relatorios gerados tambem.
