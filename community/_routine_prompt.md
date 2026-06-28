# Rotina semanal: Eixo Comunidade

> Prompt self-contained. Assuma que você (agente de IA) acabou de clonar este repo e tem ZERO contexto.
> Execute os passos na ordem. Idioma de toda saída: PT-BR. NUNCA use travessão (use vírgula, ponto, parênteses ou dois-pontos).

Você é um agente que roda o eixo de monitoramento de Comunidade (intent dev-led / community-led) por uma semana e produz um relatório versionado.

## Passo 1: Resolva a semana

- Determine a ISO week atual no formato `AAAA-WXX` (ex: 2026-W24).
- Determine a janela: segunda a domingo (use o fuso da seção 9 do `MARKET.md`).
- Guarde `WEEK_ID` e a janela.

## Passo 2: Carregue o contexto

Leia, nesta ordem:
1. `MARKET.md` (raiz): foco no ICP (seção 4), personas (seção 5) e mapa sinal -> produto (seção 8).
2. `community/_targets.md`: as fontes a ouvir (repos, fórum, comunidade), o filtro de insider e o que conta como sinal.
3. `community/_state.json`: a MEMÓRIA. Anote `last_run_date` e `themes[]`. Defina `startDate = last_run_date` (se null, 1o run).
4. `community/_status.md`: último run no Weekly Run Log.

## Passo 3: Descoberta (eixo DETERMINÍSTICO: leia o `_raw`)

Este eixo é DETERMINÍSTICO. O coletor (`community/collect.sh`) já rodou no CI (GitHub Actions) e deixou os arquivos `community/_raw/<data>.json` da janela versionados no Git. O braço já coletou: você só precisa LER o dado cru, não decidir o que buscar.

- **Leia o `_raw` da janela**: abra todos os `community/_raw/<data>.json` cujas datas caem entre `startDate` e o fim da janela. Esse é o dado cru (forks, stars, issues, PRs, mensagens) que o coletor salvou.
- **Se faltar algum dia** (um arquivo `_raw/<data>.json` esperado não existe, ex: o Actions não rodou): você mesmo pode rodar `bash community/collect.sh` (ou `DATE=AAAA-MM-DD bash community/collect.sh` pra um dia específico) pra preencher a lacuna antes de continuar.
- **Filtre insiders**: remova sua própria equipe e bots, conforme o filtro do `_targets.md`.
- **Enriqueça o ator**: para cada evento, descubra a pessoa e a empresa por trás (pode usar busca web pra enriquecer handle -> empresa/cargo). É aqui que entra o seu julgamento, não na coleta.
- **Classifique fit**: compare o ator contra o ICP (seção 4 do `MARKET.md`). Descarte quem não tem fit (ruído).

Junte os achados crus já enriquecidos: ator (pessoa/empresa), fonte/projeto, tipo de evento, data, URL(s).

## Passo 4: Reconciliação contra `_state.json`

Para cada achado, case semanticamente contra `themes[]` (normalmente a chave é ator + projeto):

- **Casou, sem novidade**: ONGOING. Atualize `last_seen_week`, append em `weeks_seen`, junte URLs novas. Não reporte no resumo executivo.
- **Casou, com desdobramento novo** (ex: quem só deu star agora mandou PR): ESCALATING. Atualize os campos e `summary`, `status = ESCALATING`. Reporte no resumo executivo.
- **Não casou**: NEW. Crie tema novo (shape no README do eixo), `first_seen_week = WEEK_ID`, `weeks_seen = [WEEK_ID]`, `status = NEW`. Reporte no resumo executivo.

Temas que não reapareceram: 2 ou mais semanas sem ver = DORMANT; 4 ou mais = RESOLVED.

**Regra de ouro: NUNCA reporte ONGOING como novidade. Só NEW e ESCALATING entram no resumo executivo.**

## Passo 5: Gere o relatório

Escreva `community/weeks/<WEEK_ID>/community.md`:

1. **Header**: título, `WEEK_ID`, janela e data do run.
2. **Resumo executivo**: SÓ NEW e ESCALATING, uma linha por sinal, o que mudou vs a semana passada.
3. **Corpo por alvo**: subseção por ator/projeto com movimento, marcador de status por item (🆕 NEW, ⬆️ ESCALATING, ➡️ ONGOING compacto com contagem de semanas).
4. **"E daí? / So what"**: uma linha de implicação por sinal (qual produto puxar, por que esse ator é quente).
5. **Apêndice de fontes**: URLs clicáveis.

## Passo 6: Atualize a memória

- `community/_state.json`: `last_run_week`, `last_run_date`, e `themes[]` (NEW criados, ESCALATING/ONGOING atualizados, DORMANT/RESOLVED remarcados).
- `community/_themes.md`: tabela legível atualizada (apague a linha de exemplo).
- `community/_status.md`: Dashboard + nova linha no Weekly Run Log.

## Passo 7: Commit e push

```
feat(community): weekly watch <WEEK_ID>
```

Lembrete final: idioma PT-BR, nunca usar travessão.
