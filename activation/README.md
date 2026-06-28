# Eixo: Ativação (`activation/`)

> **EIXO OPCIONAL / AVANÇADO.** Só adote se você quer ir do sinal até a PROPOSTA de ação (outreach). Se você só quer o monitoramento (saber o que mudou no mercado), pode APAGAR esta pasta inteira. O Signal Engine funciona sem ela.

A ativação é a camada que transforma sinal em ação. Os outros eixos respondem "o que aconteceu no mercado". A ativação responde "e então, quem eu aciono, e por quê". Ela não coleta sinal novo: ela LÊ os relatórios que os outros eixos já produziram na semana, ACUMULA por conta (empresa) ao longo do tempo, PONTUA e só PROPÕE ação quando uma conta cruza um limiar.

## A ideia central: acumular, pontuar, propor (só no limiar)

- **Acumular por conta**: a mesma empresa pode aparecer em vários eixos e em várias semanas. A ativação resolve a entidade (mesma empresa = uma conta) e guarda todos os sinais dela em `_accounts.json`.
- **Pontuar**: cada conta recebe um score que combina fit, intenção, recência e convergência de sinais (veja `_playbook.md`).
- **Propor só no limiar**: a maioria das contas NÃO deve gerar ação numa dada semana. A ativação só escreve uma proposta quando a conta cruza uma das portas de threshold. Silêncio é um resultado válido e esperado.

## Por que isso evita o erro clássico

Sem essa camada, todo sinal vira "vamos falar com eles", e o time afoga em leads mornos. Com ela, você espera o sinal AMADURECER (acumular convergência) antes de gastar um toque de outreach. O limiar é o que protege o seu tempo.

## Arquivos do eixo

| Arquivo | Papel |
| --- | --- |
| `README.md` | Este arquivo |
| `_targets.md` | Fit floor / ICP / desqualificadores (aponta pro MARKET.md) |
| `_playbook.md` | O cérebro: modelo de score, portas de threshold, cap semanal, princípios de abordagem |
| `_accounts.json` | Acumulador de contas (sinais, score, status) ao longo das semanas |
| `_status.md` | Dashboard + Weekly Run Log |
| `_routine_prompt.md` | Prompt self-contained do run semanal (roda DEPOIS dos outros eixos) |
| `weeks/<week>/proposals.md` | Propostas da semana (só quando contas cruzam o threshold) |

## Quando roda

Depois dos outros eixos da semana, porque ela consome os relatórios deles (os `consolidated.md` dos mercados e os relatórios dos eixos de fonte). Roda fora do digest: o digest é a foto do mercado, a ativação é a recomendação de ação.

## Custo

Roda barato: não faz coleta nova, só cruza o que já existe e enriquece decisores via busca quando uma conta cruza o threshold. Custo dentro da sua assinatura de IA.
