# Targets: Mercado {NOME_DO_MERCADO}

> Config deste mercado (modo DESCOBERTA). Aqui você define a SUITE DE SINAIS que este mercado roda.
> A fonte de verdade do ICP, personas e mapa sinal -> produto é o `MARKET.md` na raiz.
> Tudo entre `{CHAVES}` é placeholder: troque pelo seu.
> Estilo: nunca usar travessão.

## Identidade do mercado

- **Nome / geografia**: {ex: Brasil, ou Mercado X no País Y}
- **Idioma dos relatórios**: {ex: PT-BR, ou herda da seção 9 do MARKET.md}
- **Fuso de operação**: {ex: America/Sao_Paulo, ou herda do MARKET.md}
- **Janela padrão**: ISO week (segunda a domingo)

## Suite de sinais (menu: ligue com `[x]`, desligue com `[ ]`)

> Cada sinal abaixo é um EXEMPLO pra você escolher, editar e ampliar. Não é uma lista oficial de nada.
> Ligue poucos pra começar (1 ou 2) e vá ampliando. Para CADA sinal ligado, preencha os campos
> de configuração logo abaixo dele (queries-semente, termos/cargos, janela, filtro de ICP).
> No fim, há um espaço pra você criar os seus próprios sinais.
>
> Guia de janela: sinais raros (lançamento, rodada, troca de liderança) podem não acontecer toda
> semana. Pra esses, prefira uma janela de 4 a 6 semanas (pegando o que é novo desde o último run),
> não 1 semana rígida. O que garante que nada se repete é a memória de continuidade, não a janela curta.

### [ ] fundraising (quem captou rodada)

Pesca empresas que acabaram de anunciar captação, porque costuma abrir orçamento e janela de decisão.

- **Queries-semente**: {ex: "captou rodada" + {seu vertical}; "raised" + {vertical} + {geografia}; "investimento série A/B em {vertical}"}
- **Termos / cargos que contam**: {ex: rodada, seed, série A, série B, aporte, valuation; e os cargos da seção 5 do MARKET.md que decidem compra}
- **Janela**: {ex: últimas 1 a 2 semanas}
- **Filtro de ICP**: aplica o ICP da seção 4 do MARKET.md (tamanho, vertical, sinais e anti-sinais de fit)

### [ ] hiring-tech (quem contrata pra área técnica que você atende)

Pesca empresas abrindo vagas na área que o seu produto toca, porque indica que vão construir ou comprar algo nesse tema.

- **Queries-semente**: {ex: vaga "{cargo técnico que importa}" + {geografia}; "estamos contratando" + {área que você atende}}
- **Termos / cargos que contam**: {ex: os cargos/áreas técnicas que sinalizam o seu tema; tecnologias do seu domínio}
- **Janela**: {ex: vagas abertas nas últimas 2 a 4 semanas}
- **Filtro de ICP**: aplica o ICP do MARKET.md (descarta vaga de concorrente, fornecedor, fora da geografia)

### [ ] new-leaders (novos executivos no ICP)

Pesca trocas de liderança em empresas do ICP, porque executivo novo costuma reavaliar fornecedores.

- **Queries-semente**: {ex: "novo {cargo da persona}" + {vertical} + {geografia}; "assume como {cargo}" + {vertical}}
- **Termos / cargos que contam**: {os cargos da seção 5 do MARKET.md}
- **Janela**: {ex: últimas 1 a 2 semanas}
- **Filtro de ICP**: a EMPRESA tem que ter fit de ICP, não só o cargo

### [ ] content-intent (quem publica/fala sobre o tema que você resolve)

Pesca empresas e pessoas publicando sobre a dor que você resolve, porque sinaliza que o tema está vivo lá dentro.

- **Queries-semente**: {ex: artigos/posts recentes sobre "{a dor que você resolve}" + {vertical}}
- **Termos / cargos que contam**: {ex: termos do problema/solução que você endereça}
- **Janela**: {ex: últimas 1 a 2 semanas}
- **Filtro de ICP**: aplica o ICP do MARKET.md; descarta conteúdo de concorrente e de mídia genérica sem ator de fit

### [ ] public-tenders (editais / licitações / RFP)

Pesca demandas formais publicadas (editais, licitações, requests for proposal) que casam com o que você vende.

- **Queries-semente**: {ex: edital/licitação/RFP + "{o que você vende}" + {geografia}}
- **Termos / cargos que contam**: {ex: termos do objeto do edital que casam com seu produto}
- **Janela**: {ex: publicados na última semana}
- **Filtro de ICP**: o órgão/empresa comprador tem que estar dentro do seu escopo de atuação

### [ ] regulatory (novas licenças / atos do regulador do setor)

Pesca novos atores que tiraram licença ou autorização do regulador do seu setor, quando isso indica entrada no mercado.

- **Queries-semente**: {ex: "nova autorização" / "nova licença" + {setor} + {regulador da seção 7 do MARKET.md}}
- **Termos / cargos que contam**: {ex: tipos de licença/autorização que importam pro seu funil}
- **Janela**: {ex: atos publicados na última semana}
- **Filtro de ICP**: o novo autorizado tem que ter fit (descarta quem está fora do seu ICP)
- **Nota**: se o regulador publica num registro/endpoint FIXO que sempre devolve a mesma coisa, considere mover este sinal pro modo DETERMINÍSTICO (veja o eixo `official-records/`). Aqui ele vive como descoberta quando exige busca e leitura com julgamento.

## Adicione seus próprios sinais aqui

> Copie o bloco de um sinal acima e adapte. A receita é sempre a mesma: nome do sinal,
> uma frase do porquê ele indica intent, queries-semente, termos/cargos que contam, janela e filtro de ICP.

### [ ] {seu-sinal}

- **Queries-semente**: {...}
- **Termos / cargos que contam**: {...}
- **Janela**: {...}
- **Filtro de ICP**: aplica o ICP do MARKET.md

## Mapa sinal -> produto

> Cruze cada sinal da suite com o produto a puxar (seção 8 do MARKET.md).

| Sinal da suite | Produto a puxar (do MARKET.md) | Ângulo |
| --- | --- | --- |
| {ex: fundraising} | {PRODUTO_A} | {ex: abriu orçamento, posicionar A} |
| {ex: hiring-tech} | {PRODUTO_B} | {ex: vão construir o tema, oferecer B} |
