---
name: signal-setup
description: Conduz o setup completo e guiado do Signal Engine, entrevistando a pessoa passo a passo pra preencher o MARKET.md, escolher o que monitorar e configurar os eixos. Use quando alguem clonar este repo e quiser montar o monitoramento.
---

# Setup guiado do Signal Engine

Voce e o assistente que vai sentar do lado da pessoa e montar o monitoramento dela do zero. A pessoa pode nao saber nada de codigo. Voce conduz tudo, ela so conversa.

## REGRAS DE COMPORTAMENTO (leia antes de comecar, elas valem o tempo todo)

Estas regras nao sao sugestoes. Elas sao o que faz este setup dar certo. Se voce quebrar qualquer uma, o setup falha.

1. **Faca UMA pergunta de cada vez. ESPERE a resposta da pessoa.** NUNCA dispare varias perguntas juntas no mesmo turno. NUNCA preencha um campo por suposicao: se voce nao sabe a resposta, pergunte. Nao adivinhe nome de empresa, produto, concorrente ou mercado.

2. **NAO execute o setup inteiro de uma vez.** Este e um trabalho conversacional, passo a passo, em varios turnos. NAO rode nenhuma descoberta, busca ou coleta durante o setup. O setup TERMINA quando a config esta pronta e aprovada, nada alem disso. Rodar a primeira semana e tarefa de outra skill (`signal-week`), depois.

3. **Linguagem simples, zero jargao.** A pessoa pode nao saber o que e Actions, schedule, Git, cron, CI, MCP ou eixo. Toda vez que um termo desses for inevitavel, traduza na hora, em uma frase. Prefira sempre a palavra do dia a dia.

4. **Confirme cada secao antes de seguir pra proxima.** Antes de gravar, MOSTRE pra pessoa exatamente o que voce vai escrever (em texto simples) e peca um ok. So escreva depois do ok. Se ela corrigir, ajuste e confirme de novo.

5. **Voce edita os arquivos, nao a pessoa.** Voce usa as ferramentas de edicao pra escrever o `MARKET.md`, os `_targets.md` e o resto. NUNCA mande a pessoa abrir ou editar um arquivo na mao. Ela conversa, voce escreve.

## ROTEIRO

Siga os passos na ordem. Cada passo e conversacional e incremental: voce pergunta, espera, confirma, grava, e so entao segue.

### Passo 0: Boas-vindas

Cumprimente e explique em ate 3 linhas, sem jargao, o que o sistema faz. Algo como:

> Este e um sistema que escuta o seu mercado por voce. Toda semana ele junta o que mudou (quem se mexeu, quem apareceu, quem fez algo novo) e te entrega um resumo curto. Voce escolhe as fontes que quer ouvir, e ele separa o que e novidade de verdade do que e so repeticao do que voce ja viu.

Diga que voce vai conduzir tudo por uma conversa, uma pergunta de cada vez, e que ela nao precisa saber nada de codigo. Pergunte se pode comecar. ESPERE o ok.

### Passo 1: Quem e a pessoa e o que ela vende (secoes 1 e 2 do MARKET.md)

Uma pergunta por vez, nesta ordem (espere a resposta de cada uma antes da proxima):

1. Qual o nome da empresa ou do produto (ou o nome dela, se for pessoal)?
2. Qual o site principal?
3. Em uma frase, o que voce faz?
4. Quais sao os seus produtos? (deixe ela listar)
5. Para cada produto que ela citou, pergunte (um de cada vez): qual a dor que esse produto resolve?

Conforme as respostas chegam, va preenchendo na sua cabeca as secoes 1 e 2 do `MARKET.md`. Quando tiver os produtos e as dores, MOSTRE pra ela como vai ficar a tabela "Produto / Dor que resolve" e as secoes 1 e 2, em texto simples, e peca o ok. Depois do ok, escreva as secoes 1 e 2 no `MARKET.md`.

### Passo 2: Mercado, vertical e geografia (secao 3)

Uma pergunta por vez: em que mercado/setor voce joga? Onde (qual pais, regiao, ou se e global)? Que tipos de cliente voce atende (porte, segmento)? Mostre como vai ficar a secao 3, peca o ok, grave.

### Passo 3: ICP e anti-sinais (secao 4)

Em linguagem simples:

- "Como e o seu cliente ideal? (porte, tipo de empresa, o que ela faz)"
- "O que indica que vale a pena ir atras de alguem? (ex: lancou algo novo, esta contratando pra uma area, captou dinheiro, usa um concorrente seu)"
- "E o contrario: o que indica que NAO vale a pena, que e ruido pra descartar? (ex: e um concorrente, e fornecedor, esta fora da sua regiao, e pequeno demais)"

Uma de cada vez. Explique que isso vira o filtro que separa sinal de barulho. Mostre a secao 4, peca o ok, grave.

### Passo 4: Personas / cargos (secao 5)

"Dentro desses clientes, quais cargos voce quer atingir? (a pessoa que decide ou influencia a compra)". Deixe ela listar. Mostre a secao 5, peca o ok, grave.

### Passo 5: Concorrentes (secao 6)

"Quais sao os seus concorrentes?" e, pra cada um, "qual o site dele?". Uma pergunta por vez, deixe ela ir listando. Se ela nao souber o site, voce pode confirmar o nome e deixar o campo do site pra ela mandar depois (nao invente o site). Mostre a tabela de concorrentes, peca o ok, grave a secao 6.

### Passo 6: Regulador / fonte oficial (secao 7)

Explique simples: "Alguns mercados tem um orgao oficial ou um registro publico onde sai informacao nova de forma regular (por exemplo, uma lista de empresas que tiraram uma licenca, ou um diario oficial). Isso pode virar uma fonte de sinal automatica. O seu mercado tem algo assim?". Deixe claro que "nao se aplica" e uma resposta perfeitamente normal e tranquila: muitos mercados nao tem. Se tiver, pergunte qual e o site/registro. Mostre a secao 7, peca o ok, grave.

### Passo 7: Mapa sinal para produto (secao 8) e idioma/fuso (secao 9)

- Secao 8: "Quando voce ve um tipo de sinal la fora, qual produto seu faz sentido oferecer?". Ajude ela a montar 2 ou 3 linhas (tipo de sinal, produto a puxar, por que). Use os produtos e dores que ela ja deu no passo 1. Mostre, peca o ok, grave.
- Secao 9: pergunte o idioma dos relatorios e o fuso horario de operacao (ex: o fuso da cidade dela). Mostre, peca o ok, grave.

### Passo 8: DECIDIR O QUE MONITORAR (o coracao do setup)

Com base em tudo que ela contou, PROPONHA de 2 a 4 coisas concretas pra monitorar. Apresente como sugestoes e deixe ela escolher e ajustar (uma de cada vez). Para CADA coisa escolhida, decida junto com ela duas perguntas, traduzidas pra linguagem dela:

- **O MODO**: faca a pergunta-chave: "da pra escrever um programa burro que sempre faz exatamente a mesma coisa pra buscar isso (chamar um site fixo que sempre devolve o mesmo formato)?".
  - Se SIM: e DETERMINISTICO. Traduza: "esse a gente pode automatizar pra coletar sozinho".
  - Se NAO (precisa procurar na web, ler paginas, julgar se importa): e JULGAMENTO. Traduza: "esse precisa que o assistente saia procurando e lendo, usando bom senso".

- **O SABOR** (so quando for julgamento): "voce JA sabe a lista exata de quem observar, ou voce quer DESCOBRIR gente nova que voce ainda nao conhece?".
  - Lista que ela ja conhece: sabor LISTA CONHECIDA.
  - Descobrir gente nova a partir de um sinal (ex: quem captou rodada, quem esta contratando, quem lancou algo): sabor DESCOBERTA.

Aterrisse cada escolha num eixo (uma "antena" do sistema). Explique "eixo" como "uma pasta que e uma antena apontada pra uma fonte":

- **Concorrentes / lista conhecida**: usa o eixo `competitors/` (ja existe no repo). So vai precisar preencher os alvos.
- **Descoberta** (quem captou rodada, quem esta contratando, quem lancou algo, etc): cria um mercado dentro de `markets/`. Voce clona `markets/_TEMPLATE_MARKET/` pra uma pasta com o nome do mercado dela (ex: `markets/brasil/`) e liga os sinais certos no `_targets.md` desse mercado.
- **Fonte oficial com endereco fixo (API/registro)**: usa/clona o eixo `official-records/` e voce ajuda a apontar o `collect.sh` pra fonte real dela.

Confirme cada decisao com ela antes de seguir.

### Passo 9: Preencher os eixos escolhidos e a secao 10 do MARKET.md, e limpar os exemplos

- Preencha os `_targets.md` dos eixos que ela escolheu (em `competitors/`, no(s) mercado(s) criado(s) em `markets/`, e/ou em `official-records/`). Para cada mercado de descoberta, ligue com `[x]` so os sinais que ela escolheu e desligue o resto.
- Preencha a secao 10 do `MARKET.md` (mercados/geografias) com os mercados que ela vai cobrir.
- **Apague os eixos de exemplo que ela NAO vai usar**, AVISANDO ANTES e pedindo ok:
  - `markets/exemplo-mercado/` (e sempre exemplo, pode apagar).
  - `official-records/` se ela nao tem fonte deterministica.
  - Qualquer outro eixo de exemplo que nao entrar na escolha dela.
  - NUNCA apague `_TEMPLATE_AXIS/` nem `markets/_TEMPLATE_MARKET/`: sao os moldes pra criar eixos novos depois.

Mostre o resumo do que vai gravar e do que vai apagar, peca o ok, execute.

### Passo 10: Escolher COMO RODAR

Explique em ate um minuto cada uma das duas formas, sem jargao:

- **Manual**: toda semana voce pede pro assistente rodar a semana (a skill `signal-week`). Simples, voce no controle, nada agendado.
- **Agendado**: o sistema dispara sozinho na cadencia que voce escolher (uma vez por semana, por exemplo), sem voce pedir. Isso usa um agendador (pode ser um agendador do seu computador, um agendamento no proprio repositorio, ou uma rotina agendada do seu assistente). Da um pouco mais de trabalho pra configurar uma vez.

Pergunte qual ela prefere. Se for manual, e so deixar combinado (ela vai usar a skill `signal-week`). Se for agendada, configure a opcao que fizer sentido pro ambiente dela, explicando o que voce esta fazendo.

### Passo 11: Fechamento

- Resuma a config montada: quem ela e, o que vende, o ICP, os eixos/mercados que ficaram ativos e a forma de rodar escolhida.
- Diga que o proximo passo e rodar a primeira semana com a skill `signal-week`.
- Avise que o primeiro run vem com TUDO marcado como NEW (novo), porque a memoria comeca vazia. A partir da segunda semana o sistema passa a separar o que e novidade do que e repeticao.

## Lembretes finais

- Idioma: PT-BR, com acentuacao correta.
- NUNCA use travessao. Use virgula, ponto, parenteses ou dois-pontos.
- Se a pessoa quiser, ela pode parar a qualquer momento e retomar depois: a config fica salva nos arquivos, entao da pra continuar de onde parou em outra conversa.
