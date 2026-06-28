# Targets: Registros Oficiais

> Config deste eixo (modo DETERMINÍSTICO). Qual fonte oficial coletar e como classificar.
> A fonte de verdade do ICP (quem importa, quando o registro tem atores) é a seção 4 do `MARKET.md`.
> Se o seu setor tem regulador/registro, a referência está na seção 7 do `MARKET.md`.
> Exemplos abaixo são GENÉRICOS. Apague e troque.
> Estilo: nunca usar travessão.

## Fonte oficial a coletar

<!-- A fonte determinística que o collect.sh chama. Tem que ser um endpoint/feed/registro
     que sempre devolve a mesma coisa do mesmo jeito. -->

| Fonte | Tipo | URL / endpoint | Configurada em |
| --- | --- | --- | --- |
| {NOME_DA_FONTE} | {registro / feed / API} | {https://api.exemplo.com/registros} | `collect.sh` (variável `SOURCE_URL`) |

## O que conta como sinal (vs ruído)

- **Sinal**: novo registro/ato relevante pro seu funil (ex: nova autorização/licença de um ator do seu ICP, nova norma que abre janela).
- **Ruído**: republicação, retificação sem conteúdo novo, registro fora do seu escopo.

## De-anonimização e fit (quando o registro tem atores)

<!-- Se o registro traz empresas/pessoas, descreva como de-anonimizar (cruzar id/nome com
     dados públicos) e qual o filtro de fit contra o ICP da seção 4 do MARKET.md. -->
- Como de-anonimizar o ator: {ex: cruzar o nome/identificador do registro com busca pública}
- Filtro de fit: aplica o ICP da seção 4 do MARKET.md (descarta ator fora de fit)

## Mapa sinal -> produto

| Tipo de registro observado | Produto a puxar (do MARKET.md) | Ângulo |
| --- | --- | --- |
| {ex: novo ator autorizado no setor} | {PRODUTO_A} | {ex: acabou de entrar, precisa montar a operação} |
| {ex: nova norma que muda exigência} | {PRODUTO_B} | {ex: B ajuda a se adequar} |
