# MARKET.md

> ESTE e o arquivo "plugue seu mercado". E a unica config global do Signal Engine.
> Preencha cada campo abaixo. Tudo que esta entre `{CHAVES}` e placeholder: troque pelo seu.
> Os comentarios `<!-- preencha: ... -->` explicam o que entra em cada campo.
> Tudo que ja esta preenchido aqui e EXEMPLO GENERICO. Apague e troque pelo seu.
>
> Regra de estilo: nunca use travessao. Use virgula, ponto, parenteses ou dois-pontos.

## 1. Quem voce e

<!-- preencha: nome da empresa/produto/pessoa por tras do monitoramento -->
- **Empresa / Produto / Voce**: {SUA_EMPRESA}
- **Site canonico**: {https://seu-site.exemplo}
- **Uma frase do que voce faz**: {ex: plataforma que resolve X para empresas do tipo Y}

## 2. O que voce vende (produtos e a dor que cada um resolve)

<!-- preencha: liste seus produtos. Para cada um, a dor que ele resolve.
     Isso alimenta o mapa "sinal -> produto" la embaixo. -->

| Produto | Dor que resolve |
| --- | --- |
| {PRODUTO_A} | {ex: o cliente perde tempo fazendo X na mao} |
| {PRODUTO_B} | {ex: o cliente nao consegue enxergar Y} |
| {PRODUTO_C} | {ex: o cliente paga caro por Z} |

## 3. Seu mercado / vertical / geografia

<!-- preencha: em que mercado voce joga e onde -->
- **Vertical**: {ex: software para o setor X}
- **Geografia**: {ex: Brasil / LATAM / global}
- **Segmentos que voce atende**: {ex: enterprise, mid-market, startups do setor X}

## 4. Seu ICP (perfil de cliente ideal)

<!-- preencha: como e a empresa ideal pra voce. Isso vira o filtro de ruido dos eixos. -->
- **Tamanho**: {ex: 50 a 500 funcionarios, ou faturamento de X a Y}
- **Vertical**: {ex: empresas do setor X que fazem Y}
- **Sinais de fit** (o que indica que vale a pena): {ex: usa ferramenta concorrente, esta contratando para a area Z, lancou produto novo, captou rodada}
- **Anti-sinais** (o que indica ruido, descartar): {ex: concorrente direto, estudante, fornecedor, empresa fora da geografia}

## 5. Personas-alvo (cargos)

<!-- preencha: os cargos que voce quer atingir dentro do ICP -->
- {ex: Head de X}
- {ex: Diretor de Y}
- {ex: Gerente de Z}

## 6. Seus concorrentes

<!-- preencha: liste seus concorrentes com a URL canonica de cada (site, blog ou sala de imprensa).
     Os exemplos abaixo sao FICTICIOS. Apague e troque. -->

| Concorrente | URL canonica |
| --- | --- |
| {CONCORRENTE_1} | {https://concorrente-1.exemplo} |
| {CONCORRENTE_2} | {https://concorrente-2.exemplo} |
| {CONCORRENTE_3} | {https://concorrente-3.exemplo} |

## 7. Seu regulador / fonte oficial (se houver)

<!-- preencha: se o seu mercado tem um orgao regulador, diario oficial ou registro publico de licencas
     que gera sinal, liste aqui. Se nao houver, deixe "nao se aplica". -->
- **Orgao regulador**: {ex: orgao regulador do setor X, ou "nao se aplica"}
- **Diario oficial / publicacao de atos**: {ex: URL do diario oficial}
- **Registro publico de licencas / autorizacoes**: {ex: URL do registro onde saem novas licencas}

## 8. Mapa "sinal -> produto"

<!-- preencha: pra cada tipo de sinal que voce espera ver, qual produto puxar.
     Isso e o que conecta o monitoramento a uma acao comercial concreta. -->

| Tipo de sinal observado | Produto a puxar | Por que |
| --- | --- | --- |
| {ex: alvo lancou iniciativa de X} | {PRODUTO_A} | {ex: e exatamente a dor que A resolve} |
| {ex: alvo esta contratando para a area Y} | {PRODUTO_B} | {ex: indica que vao precisar de Y} |
| {ex: alvo reclamou de fornecedor atual} | {PRODUTO_C} | {ex: janela de troca} |

## 9. Idioma e fuso de operacao

<!-- preencha: idioma dos relatorios e fuso pra resolver a janela semanal -->
- **Idioma dos relatorios**: {ex: PT-BR}
- **Fuso de operacao**: {ex: America/Sao_Paulo}
- **Janela da semana**: ISO week (segunda a domingo)
