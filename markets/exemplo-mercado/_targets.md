# Targets: Mercado Exemplo (software de gestão para e-commerce no País X)

> EXEMPLO ILUSTRATIVO. APAGUE esta pasta e crie o seu mercado clonando `_TEMPLATE_MARKET/`.
> O vertical abaixo (uma empresa fictícia que vende software de gestão para lojas de e-commerce)
> é só pra mostrar como a suite fica preenchida com 2 sinais ligados. Troque pelo seu mercado.
> A fonte de verdade do ICP, personas e mapa sinal -> produto é o `MARKET.md` na raiz.
> Estilo: nunca usar travessão.

## Identidade do mercado

- **Nome / geografia**: Mercado de exemplo, software de gestão para e-commerce no País X
- **Idioma dos relatórios**: PT-BR
- **Fuso de operação**: herda da seção 9 do MARKET.md
- **Janela padrão**: ISO week (segunda a domingo)

## Suite de sinais (menu: ligue com `[x]`, desligue com `[ ]`)

> Aqui só 2 sinais estão ligados, pra ilustrar. No seu mercado, escolha os seus.

### [x] fundraising (quem captou rodada)

Pesca empresas que acabaram de anunciar captação, porque costuma abrir orçamento e janela de decisão.

- **Queries-semente**: "captou rodada" + e-commerce/varejo digital + País X; "raised seed/series A" + e-commerce + País X
- **Termos / cargos que contam**: rodada, seed, série A, aporte; e os cargos da seção 5 do MARKET.md
- **Janela**: últimas 2 semanas
- **Filtro de ICP**: aplica o ICP da seção 4 do MARKET.md

### [x] hiring-tech (quem contrata pra área técnica que você atende)

Pesca empresas abrindo vagas na área que o seu produto toca.

- **Queries-semente**: vaga "analista de operações de e-commerce" + País X; "estamos contratando" + logística/fulfillment
- **Termos / cargos que contam**: analista de operações, coordenador de logística, gerente de e-commerce, tech lead do tema que você atende
- **Janela**: vagas abertas nas últimas 4 semanas
- **Filtro de ICP**: aplica o ICP do MARKET.md (descarta concorrente e fornecedor)

### [ ] new-leaders (novos executivos no ICP)

(desligado neste exemplo)

### [ ] content-intent (quem publica/fala sobre o tema que você resolve)

(desligado neste exemplo)

### [ ] public-tenders (editais / licitações / RFP)

(desligado neste exemplo)

### [ ] regulatory (novas licenças / atos do regulador do setor)

(desligado neste exemplo)

## Adicione seus próprios sinais aqui

### [ ] {seu-sinal}

- **Queries-semente**: {...}
- **Termos / cargos que contam**: {...}
- **Janela**: {...}
- **Filtro de ICP**: aplica o ICP do MARKET.md

## Mapa sinal -> produto

| Sinal da suite | Produto a puxar (do MARKET.md) | Ângulo |
| --- | --- | --- |
| fundraising | {PRODUTO_A} | abriu orçamento, posicionar A |
| hiring-tech | {PRODUTO_B} | vão construir o tema, oferecer B |
