#!/usr/bin/env bash
# ============================================================================
# Render do DIGEST: transforma o full.md da semana num PDF com acabamento alto.
# ============================================================================
# Pega digest/weeks/<WEEK_ID>/full.md, converte pra HTML com pandoc (formato
# gfm, preservando os divs do pagebreak) e renderiza esse HTML em PDF com
# weasyprint usando a folha de estilo neutra digest/_pdf.css.
#
# Visual NEUTRO de proposito: sem marca, sem cor de empresa. Quem usa pluga
# a propria identidade se quiser.
#
# Uso: WEEK_ID=2026-W24 ./digest/render.sh
# Sem WEEK_ID, usa a ISO week de hoje (UTC).
#
# Se pandoc ou weasyprint nao estiverem instalados, o script imprime uma
# instrucao clara e sai com codigo 0 (nao quebra): o markdown ja e o entregavel.
# Estilo: comentarios em PT-BR, sem travessao.
# ----------------------------------------------------------------------------
set -euo pipefail

WEEK_ID="${WEEK_ID:-$(date -u +%Y-W%V)}"
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

SRC="$ROOT/digest/weeks/$WEEK_ID/full.md"
OUT_PDF="$ROOT/digest/weeks/$WEEK_ID/full.pdf"
CSS="$ROOT/digest/_pdf.css"

# Confere que o markdown da semana existe (o build_digest.sh gera ele).
if [ ! -f "$SRC" ]; then
  echo "render: nao achei $SRC." >&2
  echo "render: rode antes 'WEEK_ID=$WEEK_ID ./digest/build_digest.sh' pra gerar o digest." >&2
  exit 0
fi

# Confere as ferramentas. Se faltar alguma, explica como instalar e sai sem quebrar.
missing=0
if ! command -v pandoc >/dev/null 2>&1; then
  echo "render: 'pandoc' nao encontrado." >&2
  missing=1
fi
if ! command -v weasyprint >/dev/null 2>&1; then
  echo "render: 'weasyprint' nao encontrado." >&2
  missing=1
fi
if [ "$missing" -ne 0 ]; then
  echo "render: o PDF e opcional. O digest em markdown ja esta pronto em:" >&2
  echo "        $SRC" >&2
  echo "render: pra gerar o PDF, instale as ferramentas, por exemplo:" >&2
  echo "        macOS:  brew install pandoc && pipx install weasyprint" >&2
  echo "        Linux:  sudo apt-get install -y pandoc && pipx install weasyprint" >&2
  exit 0
fi

# Converte markdown (gfm) -> HTML standalone, preservando HTML cru (os divs de
# pagebreak), e renderiza com weasyprint aplicando a folha de estilo neutra.
TMP_HTML="$(mktemp -t digest_XXXXXX).html"
trap 'rm -f "$TMP_HTML"' EXIT

pandoc "$SRC" \
  --from gfm \
  --to html5 \
  --standalone \
  --metadata title="Signal Engine, digest $WEEK_ID" \
  -o "$TMP_HTML"

weasyprint -s "$CSS" "$TMP_HTML" "$OUT_PDF"

echo "render: PDF gerado em $OUT_PDF" >&2
echo "$OUT_PDF"
