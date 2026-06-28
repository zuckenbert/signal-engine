# Playbook de Ativação

> O cérebro da ativação. É um FRAMEWORK CONFIGURÁVEL: os números, faixas e princípios abaixo
> são pontos de partida razoáveis, não verdades. Ajuste a crença do SEU negócio.
> Estilo: nunca usar travessão.

## 1. Fit floor (gate duro)

Antes de qualquer score, um corte binário: a conta tem que estar dentro do ICP (seção 4 do `MARKET.md`). Abaixo do fit floor, a conta NUNCA entra na ativação, por mais sinais que acumule. Isso evita perseguir empresa errada só porque ela é barulhenta.

- Fit floor padrão: fit médio ou alto. Fit baixo = fora.
- Desqualificadores automáticos (do `_targets.md`): concorrente, fornecedor, fora da geografia, fora do tamanho.

## 2. Modelo de score (multiplicativo)

O score é multiplicativo de propósito: se qualquer dimensão é fraca, o total cai. Uma conta só sobe quando TODAS as dimensões ajudam.

```
Score = Fit  x  Intencao  x  Recencia  x  Stack
```

### Fit (0 a 1): quão dentro do ICP

| Faixa | Quando |
| --- | --- |
| 1.0 | fit alto, ICP cheio (casa em tamanho, vertical e sinais de fit) |
| 0.6 | fit médio (casa em parte) |
| 0.0 | abaixo do fit floor (a conta nem entra) |

### Intenção (0 a 1): força do sinal

| Faixa | Quando |
| --- | --- |
| 1.0 | intenção declarada (ex: pediu solução, abriu RFP, reclamou de fornecedor) |
| 0.7 | sinal forte de movimento (ex: captou rodada, contratando pra o tema, novo líder no ICP) |
| 0.4 | sinal indireto (ex: publicou sobre o tema, interagiu com seu conteúdo) |
| 0.2 | sinal fraco / passivo |

### Recência (0 a 1): decaimento no tempo

| Faixa | Quando |
| --- | --- |
| 1.0 | sinal desta semana |
| 0.7 | 1 a 2 semanas atrás |
| 0.4 | 3 a 4 semanas atrás |
| 0.1 | mais de 4 semanas sem sinal novo |

### Stack (0.5 a 2.5): convergência de sinais

Quantos sinais DIFERENTES (eixos ou tipos de sinal distintos) convergem na mesma conta. Convergência é o sinal mais confiável de todos.

| Faixa | Quando |
| --- | --- |
| 0.5 | sinal único e fraco |
| 1.0 | sinal único |
| 1.5 | 2 sinais convergentes |
| 2.0 | 3 sinais convergentes |
| 2.5 | 4 ou mais sinais convergentes |

## 3. Portas de threshold (qualquer uma abre a proposta)

A conta gera proposta se cruzar QUALQUER uma destas portas:

- **Porta A (stack alto)**: 3 ou mais sinais convergentes (Stack >= 2.0), com fit médio ou alto.
- **Porta B (super-sinal / intenção declarada)**: um sinal de Intenção = 1.0 (pedido explícito, RFP, reclamação de fornecedor), com fit médio ou alto, mesmo que seja sinal único.
- **Porta C (movimento forte de ICP cheio)**: Fit = 1.0 (ICP cheio) com um sinal de Intenção >= 0.7 e recente (Recência >= 0.7).

Quem não cruza nenhuma porta: continua acumulando, sem proposta. Silêncio é válido.

## 4. Cap semanal

No máximo **N contas por semana** (padrão: N = 5). Se mais contas cruzarem o threshold, ordene por score e leve só as N melhores. As demais ficam para a próxima semana (continuam acumulando). Isso mantém o outreach focado e executável.

## 5. Princípios de boa abordagem (DEFAULT editável)

São princípios genéricos. Ajuste à sua realidade.

- **Multi-thread**: aborde 2 a 4 contatos por conta (não aposte num só), cobrindo decisor e influenciador.
- **Valor antes do pedido**: no primeiro toque, ofereça algo útil (um insight, um dado, uma referência relevante) em vez de já pedir reunião. Isto é o DEFAULT: edite se a sua motion for diferente.
- **Não duplicar**: nunca aborde quem já foi contatado recentemente. A ativação deve checar o histórico de contas antes de propor.
- **Ângulo do sinal**: a abordagem nasce do sinal que abriu a conta (o porquê ela está quente), não de um pitch genérico. Puxe o produto pelo mapa sinal -> produto do `MARKET.md`.
