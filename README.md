# Signal Engine

Um motor (fork e preencha) para construir uma máquina que escuta o seu mercado.

> Este é um TEMPLATE agnóstico de mercado. Não há nenhuma empresa, produto, concorrente, regulador ou ferramenta proprietária embutida. Você clona, preenche um arquivo de config (`MARKET.md`), escolhe o que quer monitorar, pluga as suas chaves e sai rodando. Os eixos e sinais que vêm no repo são EXEMPLOS ilustrativos cobrindo os modos de coleta, não a lista oficial de monitoramento de ninguém. Você escolhe o que ouvir e é incentivado a criar mais.

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
- Cada **eixo** é uma antena apontada para uma fonte de sinal.
- Cada semana é uma volta do radar.
- A **memória de continuidade** é o que separa "ponto novo" de "ponto que já estava lá".
- O **digest** é a tela única onde todas as antenas aparecem juntas.

## O conceito de eixo

Um eixo é uma pasta autocontida que monitora UMA fonte de sinal. Cada eixo tem a mesma anatomia (config, memória, dashboard, prompt de rotina e a pasta de relatórios semanais) e roda de forma independente. Adicionar uma nova fonte ao seu radar é literalmente copiar uma pasta de eixo, trocar os alvos e plugar no digest.

Os eixos abaixo vêm no repo como EXEMPLOS cobrindo todos os modos de coleta. Eles são ilustrativos: você escolhe quais usar, apaga o que não quiser e cria os seus.

| Eixo / pasta | Modo | O que ilustra |
| --- | --- | --- |
| `markets/` | Julgamento, sabor DESCOBERTA | O motor que pesca empresas DESCONHECIDAS a partir de um sinal (ex: quem captou rodada, quem contrata pra a área que você atende). Multi-região: uma pasta por mercado. |
| `competitors/` | Julgamento, sabor LISTA CONHECIDA | Monitorar uma lista que você JÁ conhece (ex: concorrentes). |
| `official-records/` | DETERMINÍSTICO | Coletar uma fonte oficial / registro público com endpoint fixo, via `collect.sh` no Actions. |
| `_TEMPLATE_AXIS/` | (esqueleto) | Molde pra criar QUALQUER eixo de fonte novo. |
| `activation/` | (opcional / avançado) | A camada que transforma sinal em proposta de ação. Pode apagar se não precisar. |

## Os dois modos e os dois sabores de julgamento

Toda fonte de sinal cai em um de dois MODOS. A pergunta que decide:

> "A coleta dá pra escrever como um script burro que sempre faz a mesma coisa?"

- **DETERMINÍSTICO** (sim): dá pra escrever um script que sempre faz a mesma chamada (uma API, um endpoint fixo, um feed). Vira um `collect.sh` que roda no GitHub Actions, commita o dado cru em `_raw/<data>.json` (o "bastão") e a LLM só interpreta depois. Exemplo no repo: `official-records/`.
- **JULGAMENTO** (não): a coleta exige decidir o que buscar na web aberta, ler páginas e avaliar relevância. A própria LLM coleta dentro da rotina, sem Actions de coleta.

Dentro de JULGAMENTO, há dois SABORES:

- **LISTA CONHECIDA**: você já sabe QUEM observar (ex: seus concorrentes). O alvo é uma lista. Exemplo no repo: `competitors/`.
- **DESCOBERTA**: você NÃO tem lista. Você pesca empresas desconhecidas a partir de um SINAL (ex: "quem está contratando engenheiro de X", "quem captou rodada"). Aqui o alvo não é uma lista de empresas, é a DEFINIÇÃO DO SINAL: queries-semente, termos/cargos que contam, e o filtro de ICP. Exemplo no repo: o motor `markets/`.

## Multi-região (uma pasta por mercado)

O motor de descoberta (`markets/`) é multi-região. Cada mercado ou geografia é uma PASTA dentro de `markets/`. Você clona `markets/_TEMPLATE_MARKET/`, renomeia pro seu mercado (ex: `markets/brasil/`) e cada mercado roda a SUA suite de sinais de descoberta. Assim você cobre vários mercados sem misturar a memória de continuidade de um com a do outro. O digest descobre os mercados sozinho. Veja `markets/README.md`.

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

O digest concatena o relatório de cada eixo e mercado da semana num markdown único, costurando tudo numa leitura só. É onde o dado bruto vira contexto pro time: ao invés de vários relatórios soltos, uma pessoa de comercial, produto ou liderança abre um documento e entende a semana do mercado de cima a baixo.

O digest é gerado por `digest/build_digest.sh` (veja `digest/README.md`). Ele descobre os mercados e eixos dinamicamente. A camada de ativação (`activation/`) roda separado e não entra no digest.

## Quem faz o que: braço e cérebro

A confusão mais comum nesse tipo de sistema é misturar duas coisas que precisam ficar separadas: o trabalho mecânico e o trabalho de pensar. Aqui elas têm donos diferentes.

**Regra de ouro: GitHub Actions = trabalho MECÂNICO (coletar dado determinístico e enviar e-mail). Schedule / rotina de LLM = trabalho de PENSAR (interpretar sinais e montar o resumo).**

### A pergunta que decide onde a coleta roda

Pra cada fonte de sinal, pergunte: "a coleta dá pra escrever como um script burro que sempre faz a mesma coisa?"

- **SE DÁ** (chamar uma API, raspar um endpoint fixo): vira um `collect.sh` e roda no **GitHub Actions** (barato, confiável, guarda o secret, sem LLM). Ele só busca o dado cru e commita em `_raw/<data>.json`. Esse `_raw` versionado é o "bastão" que o Actions passa pra rotina ler depois.
- **SE NÃO DÁ** porque a coleta exige julgamento (decidir o que buscar na web aberta, ler páginas e avaliar relevância): a **própria LLM coleta**, chamando as ferramentas de busca dentro da rotina. Nesse caso o eixo NÃO tem Actions de coleta.

### A interpretação é sempre da LLM, e é por eixo

Não existe um cérebro central único. Cada eixo (e cada mercado) tem a sua própria rotina (schedule de LLM) que interpreta só o dele: enriquece o ator, classifica fit, reconcilia contra a memória de continuidade e escreve o relatório daquele eixo. Depois, um passo final de **digest** (também um schedule de LLM) MONTA tudo: concatena os relatórios já prontos (via `digest/build_digest.sh`) e escreve o resumo executivo. O push desse resultado acende um Actions `on: push` que renderiza e envia o e-mail.

### Cadências podem diferir (coletar diário, pensar semanal)

O Actions desacopla "coletar com frequência" de "pensar com frequência". Um `collect.sh` pode rodar diário (ex: uma fonte que publica todo dia), enquanto a interpretação roda semanal sobre a pilha de `_raw` acumulada. Você não precisa pensar todo dia só porque coleta todo dia.

```
                  UMA SEMANA NO SIGNAL ENGINE

=== 1. COLETA ====================================================

  Eixos deterministicos          |   Eixos de julgamento
  (fonte com API/endpoint fixo)   |   lista conhecida (competitors/)
                                  |   descoberta     (markets/)
  +----------------------------+  |
  | GITHUB ACTIONS  <- ACTIONS |  |   (nao tem coleta separada,
  | cron proprio (ex: diario)  |  |    a LLM busca na hora,
  | roda collect.sh -> API     |  |    no passo 2)
  | commita _raw/<data>.json   |  |
  +-------------+--------------+  |
                | dado cru no Git |
                v                 v

=== 2. INTERPRETACAO (uma rotina por eixo/mercado) ===============

  +-----------------------------------------------+
  | SCHEDULE de LLM, UM POR EIXO/MERCADO <- SCHEDULE |
  |   descoberta    -> busca + filtra fit + recon. |
  |   lista conhec. -> busca + reconcilia          |
  |   deterministico -> le _raw + reconcilia       |
  |   cada um escreve weeks/<semana>/...md         |
  +----------------------+------------------------+
                         | 1 relatorio por eixo/mercado, commitado
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

  (opcional) activation/ roda depois, cruza os relatorios,
             acumula por conta e propoe acao quando passa do limiar.
```

## Git como linha do tempo

Cada semana é um commit. Isso dá, de graça:
- **Histórico**: `git log` mostra todas as semanas que a máquina rodou.
- **Diff de mercado**: `git diff` entre dois commits semanais mostra exatamente o que mudou no mercado.
- **Auditoria**: cada sinal tem fonte (URL) e data, versionados.
- **Continuidade**: o `_state.json` versionado é a prova de quando cada tema apareceu pela 1a vez.

## Como adicionar o que VOCÊ quer monitorar

O repo é um motor extensível. Você adiciona o que quiser de dois jeitos:

- **Um eixo de fonte novo** (uma fonte específica, como concorrentes, um registro, um fórum): clone `_TEMPLATE_AXIS/`, decida o modo (determinístico ou julgamento), preencha o `_targets.md` e o `_routine_prompt.md`, e pluge no digest (se for de eixo único, adicione a linha em `digest/build_digest.sh`). Veja `_TEMPLATE_AXIS/README.md`.
- **Um mercado / sinal de descoberta novo**: clone `markets/_TEMPLATE_MARKET/`, renomeie pro seu mercado, e ligue os sinais que quiser na suite do `_targets.md` (ou crie os seus). O digest descobre o mercado sozinho. Veja `markets/README.md`.

Comece pequeno (um eixo ou um mercado com 1 ou 2 sinais) e amplie.

## QUICKSTART: plugue seu mercado

### Passo 1: preencha `MARKET.md`
É a única config global. Diga quem você é, o que vende, qual seu mercado, seu ICP, suas personas, seus concorrentes, seu regulador (se houver), seus mercados/geografias e o mapa "sinal -> produto". Tudo vem com placeholder e instrução inline.

### Passo 2: escolha o que monitorar e ajuste os `_targets.md`
Decida quais eixos e mercados fazem sentido pra você. Cada eixo tem um `_targets.md` que diz quem ou o que monitorar (e, no caso de `markets/`, qual suite de sinais ligar). Os alvos apontam de volta pro `MARKET.md` como fonte de verdade.

### Passo 3: escolha como rodar
Duas formas:
- **Manual**: você abre seu agente de IA (ex: um CLI de coding assistant), aponta pro `_routine_prompt.md` do eixo/mercado e manda rodar.
- **Agendado**: um cron ou CI (ex: um workflow agendado num schedule semanal, ou uma routine agendada do seu assistente) dispara o mesmo prompt sozinho.

As ferramentas de busca e leitura web entram como conectores (MCP) do seu agente. Não há nada proprietário amarrado.

### Passo 4: rode a 1a semana
Rode o `_routine_prompt.md` de cada eixo/mercado. Na 1a semana, tudo será NEW (a memória começa vazia). A partir da 2a semana, a máquina de continuidade começa a separar novo de contínuo. Depois, rode `WEEK_ID=AAAA-WXX ./digest/build_digest.sh` pra costurar o digest.

## Custo estimado

Pensado pra rodar barato:
- **Busca e leitura web**: cabe no free tier da maioria das ferramentas de busca e scrape (ou no plano que você já tem).
- **Geração do relatório**: roda dentro da sua assinatura de IA (o agente faz o trabalho de reconciliação e escrita).
- **Hospedagem**: Git (o repo é o produto).

Na prática, o custo marginal de mais uma semana tende a zero. O investimento é o tempo de preencher o `MARKET.md` uma vez.

## Para o assistente de IA: como guiar a pessoa do zero

Esta seção é endereçada a você, assistente de IA. Quando alguém te disser "leia este repo e me guie", siga este roteiro de onboarding:

1. **Explique em 3 linhas, sem jargão, o que este sistema faz.** Algo como: é uma máquina que escuta o mercado da pessoa e, toda semana, manda pra ela um resumo do que mudou. Ela escolhe as fontes que quer ouvir e o sistema separa o que é novo do que é repetição.
2. **ENTREVISTE a pessoa pra descobrir O QUE ela quer monitorar.** Antes de preencher arquivos, entenda o negócio dela, o mercado, e quais sinais importam. Os eixos que vêm no repo são só exemplos: a lista do que monitorar é dela.
3. **ENTREVISTE pra preencher o `MARKET.md`.** Faça as perguntas das seções em linguagem simples, uma de cada vez, e escreva o arquivo por ela. Não mande ela editar o arquivo: você edita.
4. **Para cada coisa que ela quer monitorar, ajude a decidir o MODO e o SABOR.** Use a pergunta da seção "Os dois modos e os dois sabores de julgamento": é determinístico (script burro) ou julgamento? Se julgamento, é lista conhecida (clone `competitors/`) ou descoberta (crie um mercado em `markets/`)? Se determinístico, ajude a montar o `collect.sh` e o workflow (clone `official-records/`).
5. **Monte os eixos e mercados** que ela escolheu, preenchendo os `_targets.md` e ligando os sinais da suite quando for descoberta.
6. **Explique as duas formas de rodar** e ajude a configurar a que ela preferir: (a) manual: a pessoa pede pra você rodar o `_routine_prompt.md`; (b) agendado: um cron, CI ou rotina dispara sozinho.
7. **Rode a primeira semana JUNTO com a pessoa** e mostre o relatório gerado.

Lembrete pra você, assistente: linguagem simples, nunca assuma conhecimento técnico, nunca use travessão, idioma PT-BR. E nunca apresente os exemplos do repo como "o que nós monitoramos": eles são ilustrativos, a escolha é da pessoa.

## Estilo de escrita

Todo o conteúdo é em PT-BR e nunca usa travessão. Use vírgula, ponto, parênteses ou dois-pontos. Vale pra todos os relatórios gerados também.
