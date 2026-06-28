# Workflows (GitHub Actions)

Esta pasta tem dois workflows de exemplo. Eles cobrem o lado MECÂNICO do sistema, o "braço". Lembre da regra de ouro:

**GitHub Actions = trabalho MECÂNICO (coletar dado determinístico e enviar e-mail). Schedule / rotina de LLM = trabalho de PENSAR (interpretar sinais e montar o resumo).**

## Os dois workflows

| Arquivo | Quando dispara | O que faz |
| --- | --- | --- |
| `collect-community.yml` | `schedule` (cron) + manual | Roda o `community/collect.sh` (coleta determinística, sem LLM) e commita o dado cru em `community/_raw/`. Esse `_raw` versionado é o bastão pra rotina ler depois. |
| `digest.yml` | `on: push` em `**/weeks/**` + manual | Quando um relatório é commitado, o push acende este Actions. Ele monta o digest (`digest/build_digest.sh`) e dispara o envio do e-mail (passo de envio é um PLACEHOLDER, sem provedor amarrado). |

## E a interpretação? Onde ela roda?

A INTERPRETAÇÃO (as rotinas por eixo, que enriquecem o ator, classificam fit, reconciliam contra a memória e escrevem o relatório) é trabalho de LLM e normalmente roda FORA do Actions, no agendador do seu próprio assistente de IA (a rotina/schedule dele).

Dá pra rodar a interpretação no Actions também, se você quiser tudo num lugar só: basta adicionar um CLI de IA ao job e colocar a chave de API como secret do repo. Mas isso é opcional. O Actions existe aqui pro trabalho mecânico (coletar e enviar), que é onde ele brilha (barato, confiável, guarda secret, sem precisar de LLM).

## Eixos determinísticos vs de julgamento

Só os eixos DETERMINÍSTICOS têm um workflow de coleta como o `collect-community.yml`. Os eixos de JULGAMENTO (ex: `competitors/`) não têm `collect.sh` nem Actions de coleta: a própria LLM coleta dentro da rotina, porque a coleta exige decidir o que buscar na web aberta. Veja a seção "Quem faz o que: braço e cérebro" no README da raiz.
