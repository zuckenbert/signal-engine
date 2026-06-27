# Rotina semanal: Eixo Social

> Prompt self-contained. Assuma que voce (agente de IA) acabou de clonar este repo e tem ZERO contexto.
> Execute os passos na ordem. Idioma de toda saida: PT-BR. NUNCA use travessao (use virgula, ponto, parenteses ou dois-pontos).

Voce e um agente que roda o eixo de monitoramento Social (intent marketing-led) por uma semana e produz um relatorio versionado.

## Passo 1: Resolva a semana

- Determine a ISO week atual no formato `AAAA-WXX` (ex: 2026-W24).
- Determine a janela: segunda a domingo (use o fuso da secao 9 do `MARKET.md`).
- Guarde `WEEK_ID` e a janela.

## Passo 2: Carregue o contexto

Leia, nesta ordem:
1. `MARKET.md` (raiz): foco no ICP (secao 4), personas (secao 5) e mapa sinal -> produto (secao 8).
2. `social/_targets.md`: os perfis/posts a ouvir, o filtro de insider e o que conta como sinal.
3. `social/_state.json`: a MEMORIA. Anote `last_run_date` e `themes[]`. Defina `startDate = last_run_date` (se null, 1o run).
4. `social/_status.md`: ultimo run no Weekly Run Log.

## Passo 3: Descoberta

Colete o engajamento dos seus posts na janela, desde `startDate`. De forma agnostica de ferramenta:

- **API da plataforma (se houver)**: puxe os posts da janela e quem reagiu/comentou/compartilhou.
- **Busca / leitura de paginas**: se nao houver API, use sua ferramenta de busca web (ex: um MCP de web search) e sua ferramenta de leitura/scrape de paginas pra abrir os posts recentes e extrair os engajadores (quem reagiu, quem comentou, o texto do comentario).
- **Filtre insiders**: remova sua equipe e perfis da propria empresa, conforme o `_targets.md`.
- **Identifique o engajador**: para cada um, descubra pessoa, empresa e cargo (pode enriquecer via busca web).
- **Classifique fit**: compare contra o ICP (secao 4 do `MARKET.md`). Descarte quem nao tem fit. Comentarios com contexto (mencionam uma dor) valem mais que reacao seca.

Junte os achados crus: engajador (pessoa/empresa/cargo), post engajado, tipo (reacao/comentario/compartilhamento), texto do comentario se houver, data, URL(s).

## Passo 4: Reconciliacao contra `_state.json`

Para cada achado, case semanticamente contra `themes[]` (chave tipica: engajador + handle):

- **Casou, sem novidade**: ONGOING. Atualize `last_seen_week`, append em `weeks_seen`, junte URLs. Nao reporte no resumo executivo.
- **Casou, com desdobramento novo** (ex: quem so reagia agora comentou, ou voltou a engajar mais uma semana): ESCALATING. Atualize campos e `summary`, `status = ESCALATING`. Reporte no resumo executivo. Engajamento repetido por varias semanas e o principal gatilho de ESCALATING aqui.
- **Nao casou**: NEW. Crie tema novo (shape no README do eixo), `first_seen_week = WEEK_ID`, `weeks_seen = [WEEK_ID]`, `status = NEW`. Reporte no resumo executivo.

Temas que nao reapareceram: 2 ou mais semanas sem ver = DORMANT; 4 ou mais = RESOLVED.

**Regra de ouro: NUNCA reporte ONGOING como novidade. So NEW e ESCALATING entram no resumo executivo.**

## Passo 5: Gere o relatorio

Escreva `social/weeks/<WEEK_ID>/social.md`:

1. **Header**: titulo, `WEEK_ID`, janela e data do run.
2. **Resumo executivo**: SO NEW e ESCALATING, uma linha por sinal, o que mudou vs a semana passada.
3. **Corpo por alvo**: subsecao por engajador com movimento, marcador de status por item (🆕 NEW, ⬆️ ESCALATING, ➡️ ONGOING compacto com contagem de semanas).
4. **"E dai? / So what"**: uma linha de implicacao por sinal (qual produto puxar, qual angulo de abordagem, ex: responder pelo comentario).
5. **Apendice de fontes**: URLs clicaveis (post e perfil).

## Passo 6: Atualize a memoria

- `social/_state.json`: `last_run_week`, `last_run_date`, e `themes[]` (NEW criados, ESCALATING/ONGOING atualizados, DORMANT/RESOLVED remarcados).
- `social/_themes.md`: tabela legivel atualizada (apague a linha de exemplo).
- `social/_status.md`: Dashboard + nova linha no Weekly Run Log.

## Passo 7: Commit e push

```
feat(social): weekly watch <WEEK_ID>
```

Lembrete final: idioma PT-BR, nunca usar travessao.
