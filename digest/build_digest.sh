#!/usr/bin/env bash
# Monta o DIGEST: concatena o relatorio de cada eixo da semana num markdown so.
# Cada eixo vira uma secao H1. Corrige tabelas (linha em branco antes, GFM) e
# remove o H1 proprio de cada relatorio. Uso: WEEK_ID=2026-W24 ./digest/build_digest.sh
set -euo pipefail
WEEK_ID="${WEEK_ID:-$(date -u +%Y-W%V)}"
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
OUT="$ROOT/digest/weeks/$WEEK_ID/full.md"
mkdir -p "$(dirname "$OUT")"
AXES=(
  "competitors/weeks/$WEEK_ID/competitors.md|Concorrentes|Movimentos institucionais e de porta-vozes dos concorrentes"
  "community/weeks/$WEEK_ID/community.md|Comunidade|Intent dev-led/community-led: quem do seu ICP interage com seus projetos ou comunidade"
  "social/weeks/$WEEK_ID/social.md|Social|Intent marketing-led: quem do seu ICP engaja no seu conteudo social"
)
prep_axis() {
  sed '/^# /d' "$1" \
    | perl -CSD -pe 's/\s*\x{2014}\s*/, /g; s/\s*\x{2013}\s*/, /g' \
    | awk 'NR>1 && prev !~ /^[[:space:]]*$/ && prev !~ /^[[:space:]]*\|/ && $0 ~ /^[[:space:]]*\|/ { print "" } { print; prev=$0 }'
}
present=0
{
  for a in "${AXES[@]}"; do
    f="${a%%|*}"; rest="${a#*|}"; name="${rest%%|*}"; desc="${rest#*|}"
    printf '\n\n<div class="pagebreak"></div>\n\n# %s\n\n*%s*\n\n' "$name" "$desc"
    if [ -f "$ROOT/$f" ]; then prep_axis "$ROOT/$f"; present=$((present+1));
    else echo "_Sem relatorio para $WEEK_ID neste eixo (rotina nao rodou ou nao ha sinais)._"; fi
  done
} > "$OUT"
echo "digest: $present de ${#AXES[@]} eixos presentes em $WEEK_ID" >&2
echo "$OUT"
