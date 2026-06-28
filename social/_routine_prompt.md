# Rotina semanal: Eixo Social

> Prompt self-contained. Assuma que você (agente de IA) acabou de clonar este repo e tem ZERO contexto.
> Execute os passos na ordem. Idioma de toda saída: PT-BR. NUNCA use travessão (use vírgula, ponto, parênteses ou dois-pontos).

Você é um agente que roda o eixo de monitoramento Social (intent marketing-led) por uma semana e produz um relatório versionado.

## Passo 1: Resolva a semana

- Determine a ISO week atual no formato `AAAA-WXX` (ex: 2026-W24).
- Determine a janela: segunda a domingo (use o fuso da seção 9 do `MARKET.md`).
- Guarde `WEEK_ID` e a janela.

## Passo 2: Carregue o contexto

Leia, nesta ordem:
1. `MARKET.md` (raiz): foco no ICP (seção 4), personas (seção 5) e mapa sinal -> produto (seção 8).
2. `social/_targets.md`: os perfis/posts a ouvir, o filtro de insider e o que conta como sinal.
3. `social/_state.json`: a MEMÓRIA. Anote `last_run_date` e `themes[]`. Defina `startDate = last_run_date` (se null, 1o run).
4. `social/_status.md`: último run no Weekly Run Log.

## Passo 3: Descoberta

Colete o engajamento dos seus posts na janela, desde `startDate`. De forma agnóstica de ferramenta:

- **API da plataforma (se houver)**: puxe os posts da janela e quem reagiu/comentou/compartilhou.
- **Busca / leitura de páginas**: se não houver API, use sua ferramenta de busca web (ex: um MCP de web search) e sua ferramenta de leitura/scrape de páginas pra abrir os posts recentes e extrair os engajadores (quem reagiu, quem comentou, o texto do comentário).
- **Filtre insiders**: remova sua equipe e perfis da própria empresa, conforme o `_targets.md`.
- **Identifique o engajador**: para cada um, descubra pessoa, empresa e cargo (pode enriquecer via busca web).
- **Classifique fit**: compare contra o ICP (seção 4 do `MARKET.md`). Descarte quem não tem fit. Comentários com contexto (mencionam uma dor) valem mais que reação seca.

Junte os achados crus: engajador (pessoa/empresa/cargo), post engajado, tipo (reação/comentário/compartilhamento), texto do comentário se houver, data, URL(s).

## Passo 4: Reconciliação contra `_state.json`

Para cada achado, case semanticamente contra `themes[]` (chave típica: engajador + handle):

- **Casou, sem novidade**: ONGOING. Atualize `last_seen_week`, append em `weeks_seen`, junte URLs. Não reporte no resumo executivo.
- **Casou, com desdobramento novo** (ex: quem só reagia agora comentou, ou voltou a engajar mais uma semana): ESCALATING. Atualize campos e `summary`, `status = ESCALATING`. Reporte no resumo executivo. Engajamento repetido por várias semanas é o principal gatilho de ESCALATING aqui.
- **Não casou**: NEW. Crie tema novo (shape no README do eixo), `first_seen_week = WEEK_ID`, `weeks_seen = [WEEK_ID]`, `status = NEW`. Reporte no resumo executivo.

Temas que não reapareceram: 2 ou mais semanas sem ver = DORMANT; 4 ou mais = RESOLVED.

**Regra de ouro: NUNCA reporte ONGOING como novidade. Só NEW e ESCALATING entram no resumo executivo.**

## Passo 5: Gere o relatório

Escreva `social/weeks/<WEEK_ID>/social.md`:

1. **Header**: título, `WEEK_ID`, janela e data do run.
2. **Resumo executivo**: SÓ NEW e ESCALATING, uma linha por sinal, o que mudou vs a semana passada.
3. **Corpo por alvo**: subseção por engajador com movimento, marcador de status por item (🆕 NEW, ⬆️ ESCALATING, ➡️ ONGOING compacto com contagem de semanas).
4. **"E daí? / So what"**: uma linha de implicação por sinal (qual produto puxar, qual ângulo de abordagem, ex: responder pelo comentário).
5. **Apêndice de fontes**: URLs clicáveis (post e perfil).

## Passo 6: Atualize a memória

- `social/_state.json`: `last_run_week`, `last_run_date`, e `themes[]` (NEW criados, ESCALATING/ONGOING atualizados, DORMANT/RESOLVED remarcados).
- `social/_themes.md`: tabela legível atualizada (apague a linha de exemplo).
- `social/_status.md`: Dashboard + nova linha no Weekly Run Log.

## Passo 7: Commit e push

```
feat(social): weekly watch <WEEK_ID>
```

Lembrete final: idioma PT-BR, nunca usar travessão.
