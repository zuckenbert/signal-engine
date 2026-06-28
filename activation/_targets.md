# Targets: Ativação

> Config deste eixo. Define o fit floor, o ICP e os desqualificadores que a ativação usa
> como gate duro. A fonte de verdade do ICP é a seção 4 do `MARKET.md`. Aqui você só
> traduz isso em regras de corte da ativação.
> Estilo: nunca usar travessão.

## Fit floor (gate duro)

<!-- O corte mínimo pra uma conta entrar na ativação. Abaixo disso, nunca entra. -->
- **Fit mínimo aceito**: {ex: fit médio ou alto}
- **Referência de ICP**: seção 4 do MARKET.md (tamanho, vertical, sinais de fit)

## Desqualificadores automáticos

<!-- Quem é cortado de cara, independente de quantos sinais acumule. -->
- {ex: concorrente direto}
- {ex: fornecedor / parceiro}
- {ex: fora da geografia}
- {ex: fora do tamanho de ICP}
- {ex: conta já em negociação por outro canal}

## Mapa sinal -> produto (referência)

<!-- A ativação usa o mapa da seção 8 do MARKET.md pra escolher o ângulo/produto de cada conta.
     Aqui você pode anotar ajustes específicos da ativação, se houver. -->
- Usa o mapa sinal -> produto da seção 8 do MARKET.md.
