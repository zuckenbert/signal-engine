# Rotina semanal: Eixo Ativação

> Prompt self-contained. Assuma que você (agente de IA) acabou de clonar este repo e tem ZERO contexto.
> Execute os passos na ordem. Idioma de toda saída: PT-BR. NUNCA use travessão (use vírgula, ponto, parênteses ou dois-pontos).
> Rode esta rotina DEPOIS dos outros eixos da semana, porque ela consome os relatórios deles.

Você é um agente que roda a camada de ativação por uma semana. Você NÃO coleta sinal novo. Você cruza os sinais que os outros eixos já produziram, acumula por conta, pontua e só propõe ação quando uma conta cruza um limiar.

## Passo 1: Resolva a semana

- Determine a ISO week atual no formato `AAAA-WXX` (ex: 2026-W24).
- Guarde `WEEK_ID`.

## Passo 2: Carregue o contexto

Leia, nesta ordem:
1. `MARKET.md` (raiz): ICP (seção 4), personas (seção 5), mapa sinal -> produto (seção 8).
2. `activation/_targets.md`: o fit floor, o ICP e os desqualificadores.
3. `activation/_playbook.md`: o modelo de score, as portas de threshold, o cap semanal e os princípios de abordagem. Use exatamente esse cérebro.
4. `activation/_accounts.json`: o ACUMULADOR. Anote as contas existentes e `last_run_date`.
5. `activation/_status.md`: último run.

## Passo 3: Colete os sinais da semana (dos OUTROS eixos)

Leia os relatórios que os outros eixos já escreveram nesta semana:
- Todos os `markets/*/weeks/<WEEK_ID>/consolidated.md` (um por mercado).
- `competitors/weeks/<WEEK_ID>/competitors.md`, se existir.
- `official-records/weeks/<WEEK_ID>/official-records.md`, se existir.
- Qualquer outro eixo de fonte que você tenha adicionado.

Extraia, de cada relatório, os achados com empresa identificável: empresa, eixo de origem, tipo de sinal, resumo, força do sinal (use as faixas de Intenção do `_playbook.md`), e a URL.

## Passo 4: Resolva a entidade e atualize o acumulador

- **Resolva a entidade**: a mesma empresa pode aparecer em vários eixos com nomes ligeiramente diferentes. Una pelo domínio/nome canônico. Mesma empresa = uma conta.
- **Aplique o fit floor**: descarte de cara quem está abaixo do fit floor ou bate um desqualificador (`_targets.md`). Essas contas nem entram.
- **Atualize `_accounts.json`**: para cada conta, faça append dos novos sinais em `signals[]`, atualize `last_seen_week = WEEK_ID`, recalcule a recência (sinais antigos decaem) e o stack (quantos sinais distintos convergem).
- **Pontue**: calcule `Score = Fit x Intencao x Recencia x Stack` conforme o `_playbook.md`. Para Intenção e Recência, use o sinal mais forte/recente da conta.

## Passo 5: Detecte threshold e aplique o cap

- Marque quais contas cruzam alguma das portas (A: stack alto; B: super-sinal / intenção declarada; C: movimento forte de ICP cheio), conforme o `_playbook.md`.
- Ordene as que cruzaram por score e aplique o cap semanal (padrão N = 5). As excedentes ficam ACCUMULATING pra próxima semana.
- **Não duplique**: remova quem já está CONTACTED ou foi proposto recentemente (cheque o histórico em `_accounts.json`).

Se NENHUMA conta cruzar o threshold, NÃO invente proposta. Escreva no relatório que nenhuma conta cruzou o limiar nesta semana e encerre. Silêncio é um resultado válido.

## Passo 6: Enriqueça os decisores (só das contas propostas)

Para cada conta que virou proposta, identifique 2 a 4 decisores (cruze com as personas da seção 5 do MARKET.md), usando sua ferramenta de busca web de forma genérica (ex: um MCP de busca) pra achar nome, cargo e, quando possível, o contato. Multi-thread por conta.

## Passo 7: Escreva as propostas

Se houve contas propostas, escreva `activation/weeks/<WEEK_ID>/proposals.md`, um documento limpo voltado pra leitura:

1. **Header**: `WEEK_ID`, quantas contas cruzaram o threshold, quantas entraram após o cap.
2. **Uma seção por conta proposta**, com: nome da empresa, fit, o(s) sinal(is) que abriram a conta (com a porta que cruzou), o score, o cluster, o produto a puxar (do mapa do MARKET.md), o ângulo de abordagem (nasce do sinal), os 2 a 4 decisores, e o CTA sugerido (default: valor antes do pedido).

Se nenhuma conta cruzou: escreva um `proposals.md` curto dizendo isso, ou pule a escrita e registre no `_status.md`.

## Passo 8: Atualize a memória

- `activation/_accounts.json`: `last_run_week`, `last_run_date`, e o array `accounts` (sinais acumulados, scores, status atualizados: PROPOSED pras que viraram proposta).
- `activation/_status.md`: Dashboard + nova linha no Weekly Run Log.

## Passo 9: Commit e push

```
feat(activation): weekly <WEEK_ID>
```

Lembrete final: idioma PT-BR, nunca usar travessão.
