#!/usr/bin/env bash
# ============================================================================
# Monta o DIGEST da semana: concatena os relatorios ja prontos num markdown so.
# ============================================================================
# Ele descobre as secoes DINAMICAMENTE (nao tem lista fixa de eixos):
#   1. Cada mercado em markets/*/weeks/$WEEK_ID/consolidated.md vira uma secao
#      (PULA a pasta _TEMPLATE_MARKET, que e so molde).
#   2. Os eixos de fonte de eixo unico que existirem entram tambem:
#      competitors/ e official-records/.
# Para cada secao: abre um H1 com nome e descricao precedido de pagebreak,
# remove o H1 proprio do relatorio, troca em/en-dash por virgula e poe linha
# em branco antes de tabelas GFM (funcao prep_axis).
#
# Uso: WEEK_ID=2026-W24 ./digest/build_digest.sh
# Sem WEEK_ID, usa a ISO week de hoje (UTC).
# Estilo: comentarios em PT-BR, sem travessao.
# ----------------------------------------------------------------------------
set -euo pipefail

WEEK_ID="${WEEK_ID:-$(date -u +%Y-W%V)}"
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
OUT="$ROOT/digest/weeks/$WEEK_ID/full.md"
mkdir -p "$(dirname "$OUT")"

# prep_axis: limpa um relatorio de eixo pra entrar no digest.
#   1. remove o H1 proprio (a secao do digest ja poe o titulo);
#   2. troca em dash (U+2014) e en dash (U+2013) por virgula, por garantia de estilo;
#   3. poe uma linha em branco antes de tabelas GFM (linha que comeca com '|').
prep_axis() {
  sed '/^# /d' "$1" \
    | perl -CSD -pe 's/\s*\x{2014}\s*/, /g; s/\s*\x{2013}\s*/, /g' \
    | awk 'NR>1 && prev !~ /^[[:space:]]*$/ && prev !~ /^[[:space:]]*\|/ && $0 ~ /^[[:space:]]*\|/ { print "" } { print; prev=$0 }'
}

# Monta a lista de secoes dinamicamente: "caminho|Nome Exibido|Descricao".
SECTIONS=()

# 1) Mercados (modo descoberta): uma secao por mercado, pulando o _TEMPLATE_MARKET.
for d in "$ROOT"/markets/*/; do
  market="$(basename "$d")"
  [ "$market" = "_TEMPLATE_MARKET" ] && continue
  f="markets/$market/weeks/$WEEK_ID/consolidated.md"
  SECTIONS+=("$f|Mercado: $market|Descoberta de empresas no mercado $market (consolidado de todos os sinais)")
done

# 2) Eixos de fonte de eixo unico que existirem.
SECTIONS+=("competitors/weeks/$WEEK_ID/competitors.md|Concorrentes|Movimentos institucionais e de porta-vozes dos concorrentes")
SECTIONS+=("official-records/weeks/$WEEK_ID/official-records.md|Registros Oficiais|Novos registros/atos da fonte oficial deterministica")

expected="${#SECTIONS[@]}"
present=0
{
  for s in "${SECTIONS[@]}"; do
    f="${s%%|*}"; rest="${s#*|}"; name="${rest%%|*}"; desc="${rest#*|}"
    printf '\n\n<div class="pagebreak"></div>\n\n# %s\n\n*%s*\n\n' "$name" "$desc"
    if [ -f "$ROOT/$f" ]; then
      prep_axis "$ROOT/$f"; present=$((present+1))
    else
      echo "_Sem relatório para $WEEK_ID nesta seção (rotina não rodou ou não há sinais)._"
    fi
  done
} > "$OUT"

echo "digest: $present de $expected secoes presentes em $WEEK_ID" >&2
echo "$OUT"
