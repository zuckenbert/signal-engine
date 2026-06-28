# Signal Engine

Um template (fork e preencha) para construir uma máquina que escuta o seu mercado.

> Este é um TEMPLATE agnóstico de mercado. Não há nenhuma empresa, produto, concorrente, regulador ou ferramenta proprietária embutida. Você clona, preenche um arquivo de config (`MARKET.md`), ajusta os alvos de cada eixo e sai rodando.

### 👋 Não entende nada de código? Sem problema.

Copie a linha abaixo e cole no seu assistente de IA (ex: Claude), trocando a URL pela deste repositório:

> "Leia o repositório <URL_DESTE_REPO> e me guie, passo a passo, pra montar meu monitoramento de mercado. Pode me entrevistar pra preencher as configurações."

O assistente vai ler o repo, te entrevistar e conduzir tudo. Você não precisa saber o que é Actions, schedule ou Git.

## O que é

Signal Engine é uma máquina que escuta o mercado. Toda semana ela faz a mesma rotina disciplinada: várias fontes de sinal (cada fonte é uma pasta, chamada de "eixo") coletam o que aconteceu, separam o ruído do que importa, reconciliam o achado contra uma memória de continuidade (pra saber o que é novo de verdade vs o que já foi visto antes) e, no fim, um DIGEST costura tudo num relatório único.

Como tudo vive no Git, cada semana vira um ponto no tempo. O diff entre duas semanas é, literalmente, o movimento do mercado capturado por escrito.

## Como funciona (a metáfora)

Pense num radar. Ele varre o céu em círculos, sempre na mesma cadência. Cada volta, ele compara o que vê agora com o que viu na volta anterior. Um ponto novo na tela chama atenção. Um ponto que já estava lá e só andou um pouco é contexto, não alarme. Um ponto que sumiu por várias voltas é arquivado.

O Signal Engine é esse radar para o seu mercado:
- Cada **eixo** é uma antena apontada para uma fonte de sinal (concorrentes, comunidade, social, etc).
- Cada semana é uma volta do radar.
- A **memória de continuidade** é o que separa "ponto novo" de "ponto que já estava lá".
- O **digest** é a tela única onde todas as antenas aparecem juntas.

## O conceito de eixo

Um eixo é uma pasta autocontida que monitora UMA fonte de sinal. Cada eixo tem a mesma anatomia (config, memória, dashboard, prompt de rotina e a pasta de relatórios semanais) e roda de forma independente. Adicionar uma nova fonte ao seu radar é literalmente copiar uma pasta de eixo, trocar os alvos e plugar no digest.

Eixos de exemplo que já vêm no template:

| Eixo | Tipo de intent | O que escuta |
| --- | --- | --- |
| `competitors/` | competitor-led | Movimentos institucionais e de porta-vozes dos seus concorrentes, na web e nas páginas próprias deles |
| `community/` | dev-led / community-led | Quem do seu ICP interage com seus projetos open source, fórum ou comunidade |
| `social/` | marketing-led | Quem do seu ICP reage ou comenta no seu conteúdo social |
| `_TEMPLATE_AXIS/` | (esqueleto) | Pasta vazia pra clonar e criar um eixo novo |

## A máquina de continuidade (o coração do sistema)

Cada sinal detectado vira um "tema" com um ciclo de vida. A memória de cada eixo (`_state.json`) guarda esses temas entre as semanas. É isso que evita o pior erro de qualquer monitoramento: reportar a mesma coisa toda semana como se fosse nova.

| Estado | Significado | Como reportar |
| --- | --- | --- |
| **NEW** | 1a vez rastreado nesta semana | Entra no resumo executivo |
| **ESCALATING** | Já rastreado antes + um desdobramento novo nesta semana | Entra no resumo executivo (destaque o que mudou) |
| **ONGOING** | Continua visível, sem novidade | Reportar de forma compacta, com a contagem de semanas. NUNCA no resumo executivo |
| **DORMANT** | Não visto há 2 ou mais semanas | Fora do relatório ativo |
| **RESOLVED** | Concluído ou não visto há 4 ou mais semanas | Arquivado |

**Regra de ouro: NUNCA reporte ONGOING como novidade. Só NEW e ESCALATING entram no resumo executivo.**

Isso é o que faz o relatório ser lido. Quem recebe o digest confia que tudo ali é, de fato, movimento desta semana.

## O digest

O digest concatena o relatório de cada eixo da semana num markdown único, costurando tudo numa leitura só. É onde o dado bruto vira contexto pro time: ao invés de três relatórios soltos, uma pessoa de comercial, produto ou liderança abre um documento e entende a semana do mercado de cima a baixo.

O digest é gerado por `digest/build_digest.sh` (veja `digest/README.md`).

## Quem faz o que: braço e cérebro

A confusão mais comum nesse tipo de sistema é misturar duas coisas que precisam ficar separadas: o trabalho mecânico e o trabalho de pensar. Aqui elas têm donos diferentes.

**Regra de ouro: GitHub Actions = trabalho MECÂNICO (coletar dado determinístico e enviar e-mail). Schedule / rotina de LLM = trabalho de PENSAR (interpretar sinais e montar o resumo).**

### A pergunta que decide onde a coleta roda

Pra cada fonte de sinal, pergunte: "a coleta dá pra escrever como um script burro que sempre faz a mesma coisa?"

- **SE DÁ** (chamar uma API, raspar um endpoint fixo): vira um `collect.sh` e roda no **GitHub Actions** (barato, confiável, guarda o secret, sem LLM). Ele só busca o dado cru e commita em `_raw/<data>.json`. Esse `_raw` versionado é o "bastão" que o Actions passa pra rotina ler depois.
- **SE NÃO DÁ** porque a coleta exige julgamento (decidir o que buscar na web aberta, ler páginas e avaliar relevância): a **própria LLM coleta**, chamando as ferramentas de busca dentro da rotina. Nesse caso o eixo NÃO tem Actions de coleta.

### A interpretação é sempre da LLM, e é por eixo

Não existe um cérebro central único. Cada eixo tem a sua própria rotina (schedule de LLM) que interpreta só o dele: enriquece o ator, classifica fit, reconcilia contra a memória de continuidade e escreve o relatório daquele eixo. Depois, um passo final de **digest** (também um schedule de LLM) MONTA tudo: concatena os relatórios já prontos de cada eixo (via `digest/build_digest.sh`) e escreve o resumo executivo. O push desse resultado acende um Actions `on: push` que renderiza e envia o e-mail.

### Cadências podem diferir (coletar diário, pensar semanal)

O Actions desacopla "coletar com frequência" de "pensar com frequência". Um `collect.sh` pode rodar diário (ex: uma fonte que publica todo dia), enquanto a interpretação roda semanal sobre a pilha de `_raw` acumulada. Você não precisa pensar todo dia só porque coleta todo dia.

```
                  UMA SEMANA NO SIGNAL ENGINE

=== 1. COLETA ====================================================

  Eixos deterministicos          |   Eixo de julgamento
  (fonte com API/endpoint fixo)   |   (busca aberta na web)
                                  |
  +----------------------------+  |   (nao tem coleta separada,
  | GITHUB ACTIONS  <- ACTIONS |  |    a LLM busca na hora,
  | cron proprio (ex: diario)  |  |    no passo 2)
  | roda collect.sh -> API     |  |
  | commita _raw/<data>.json   |  |
  +-------------+--------------+  |
                | dado cru no Git |
                v                 v

=== 2. INTERPRETACAO (uma rotina por eixo) =======================

  +---------------------------------------------+
  | SCHEDULE de LLM, UM POR EIXO     <- SCHEDULE |
  |   eixo de julgamento -> busca + reconcilia   |
  |   eixo deterministico -> le _raw + reconcilia|
  |   cada um escreve weeks/<semana>/<eixo>.md   |
  +----------------------+----------------------+
                         | 1 relatorio por eixo, commitado
                         v

=== 3. DIGEST + ENVIO ============================================

  +---------------------------------------------+
  | DIGEST (schedule de LLM)         <- SCHEDULE |
  |   build_digest.sh concatena -> full.md       |
  |   LLM escreve o resumo executivo -> resumo.md|
  |   commita + PUSH                             |
  +----------------------+----------------------+
                         | o push acende um evento
                         v
  +---------------------------------------------+
  | GITHUB ACTIONS (on: push)        <- ACTIONS  |
  |   renderiza e manda o e-mail                 |
  +----------------------+----------------------+
                         v
                 (e-mail) cai na caixa do time
```

## Git como linha do tempo

Cada semana é um commit. Isso dá, de graça:
- **Histórico**: `git log` mostra todas as semanas que a máquina rodou.
- **Diff de mercado**: `git diff` entre dois commits semanais mostra exatamente o que mudou no mercado.
- **Auditoria**: cada sinal tem fonte (URL) e data, versionados.
- **Continuidade**: o `_state.json` versionado é a prova de quando cada tema apareceu pela 1a vez.

## QUICKSTART: plugue seu mercado

### Passo 1: preencha `MARKET.md`
É a única config global. Diga quem você é, o que vende, qual seu mercado, seu ICP, suas personas, seus concorrentes, seu regulador (se houver) e o mapa "sinal -> produto". Tudo vem com placeholder e instrução inline.

### Passo 2: ajuste os `_targets.md` de cada eixo
Cada eixo tem um `_targets.md` que diz quem ou o que monitorar (URLs canônicas, contas, repos, etc) e pra qual produto puxar cada tipo de sinal. Os alvos apontam de volta pro `MARKET.md` como fonte de verdade.

### Passo 3: escolha como rodar
Duas formas:
- **Manual**: você abre seu agente de IA (ex: um CLI de coding assistant), aponta pro `_routine_prompt.md` do eixo e manda rodar.
- **Agendado**: um cron ou CI (ex: um workflow agendado num schedule semanal, ou uma routine agendada do seu assistente) dispara o mesmo prompt sozinho.

As ferramentas de busca e leitura web entram como conectores (MCP) do seu agente. Não há nada proprietário amarrado.

### Passo 4: rode a 1a semana
Rode o `_routine_prompt.md` de cada eixo. Na 1a semana, tudo será NEW (a memória começa vazia). A partir da 2a semana, a máquina de continuidade começa a separar novo de contínuo. Depois, rode `WEEK_ID=AAAA-WXX ./digest/build_digest.sh` pra costurar o digest.

## Custo estimado

Pensado pra rodar barato:
- **Busca e leitura web**: cabe no free tier da maioria das ferramentas de busca e scrape (ou no plano que você já tem).
- **Geração do relatório**: roda dentro da sua assinatura de IA (o agente faz o trabalho de reconciliação e escrita).
- **Hospedagem**: Git (o repo é o produto).

Na prática, o custo marginal de mais uma semana tende a zero. O investimento é o tempo de preencher o `MARKET.md` uma vez.

## Para o assistente de IA: como guiar a pessoa do zero

Esta seção é endereçada a você, assistente de IA. Quando alguém te disser "leia este repo e me guie", siga este roteiro de onboarding:

1. **Explique em 3 linhas, sem jargão, o que este sistema faz.** Algo como: é uma máquina que escuta o mercado da pessoa e, toda semana, manda pra ela um resumo do que mudou. Ela escolhe as fontes que quer ouvir e o sistema separa o que é novo do que é repetição.
2. **ENTREVISTE a pessoa pra preencher o `MARKET.md`.** Faça as perguntas das 9 seções em linguagem simples, uma de cada vez, e escreva o arquivo por ela. Não mande ela editar o arquivo: você edita.
3. **Ajude a escolher os eixos (fontes de sinal)** que fazem sentido pro mercado dela e preencha o `_targets.md` de cada um.
4. **Para cada eixo, ajude a decidir o MODO** (determinístico com `collect.sh` + Actions, ou julgamento com a LLM coletando na rotina) usando a pergunta da seção "Quem faz o que: braço e cérebro". Se for determinístico, ajude a montar o `collect.sh` e o workflow.
5. **Explique as duas formas de rodar** e ajude a configurar a que ela preferir: (a) manual: a pessoa pede pra você rodar o `_routine_prompt.md` do eixo; (b) agendado: um cron, CI ou rotina dispara sozinho.
6. **Rode a primeira semana JUNTO com a pessoa** e mostre o relatório gerado.

Lembrete pra você, assistente: linguagem simples, nunca assuma conhecimento técnico, nunca use travessão, idioma PT-BR.

## Estilo de escrita

Todo o conteúdo é em PT-BR e nunca usa travessão. Use vírgula, ponto, parênteses ou dois-pontos. Vale pra todos os relatórios gerados também.
