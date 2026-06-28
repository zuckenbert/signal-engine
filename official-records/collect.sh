#!/usr/bin/env bash
#
# ============================================================================
# COLETOR DETERMINISTICO (eixo Registros Oficiais) -- arquivo de EXEMPLO
# ============================================================================
#
# Este e o padrao DETERMINISTICO. Roda no CI / GitHub Actions, SEM LLM.
# Ele so busca o dado cru e salva. Ele NAO interpreta, NAO classifica, NAO
# decide relevancia. Pensar e trabalho da rotina (a LLM), depois.
#
# Substitua a URL e a logica abaixo pela sua fonte real: uma API, um feed ou
# um endpoint que sempre devolve a mesma coisa do mesmo jeito (ex: um registro
# publico de licencas/autorizacoes, um feed de atos oficiais, um endpoint de
# dados abertos). Se a sua fonte exige JULGAMENTO (decidir o que buscar na web
# aberta, ler paginas e avaliar o que importa), entao ela NAO e deterministica:
# nesse caso nao use collect.sh, deixe a LLM coletar dentro do _routine_prompt.md
# (veja o eixo competitors/ ou o motor markets/).
#
# O que ele faz: chama a fonte e grava official-records/_raw/<AAAA-MM-DD>.json.
# Esse _raw e VERSIONADO (commitado no Git) e e o "bastao" que o Actions passa
# pra rotina ler depois. Por isso a pasta _raw/ NAO esta no .gitignore.
#
# Estilo: comentarios em PT-BR, sem travessao.
# ----------------------------------------------------------------------------

set -euo pipefail

# Diretorio deste eixo (funciona de qualquer lugar que voce chame o script).
AXIS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Data alvo da coleta. Default: hoje em UTC. Pode sobrescrever com DATE=AAAA-MM-DD.
DATE="${DATE:-$(date -u +%Y-%m-%d)}"

# Pasta de dados crus (versionada). Garante que existe.
RAW_DIR="$AXIS_DIR/_raw"
mkdir -p "$RAW_DIR"
OUT="$RAW_DIR/$DATE.json"

# ----------------------------------------------------------------------------
# CONFIGURE AQUI A SUA FONTE REAL
# ----------------------------------------------------------------------------
# Troque esta URL de exemplo pelo endpoint da sua fonte oficial deterministica.
SOURCE_URL="https://api.exemplo.com/registros"   # <- TROQUE pela sua fonte real

# Se a sua fonte exige autenticacao, configure o token como SECRET do repo
# (Settings -> Secrets and variables -> Actions) e exponha no workflow via env.
# Aqui o script so le a variavel de ambiente. Exemplo:
#   AUTH="Bearer ${MINHA_API_KEY:-}"   # configure MINHA_API_KEY como secret do repo
# E depois passe -H "Authorization: $AUTH" no curl abaixo.

echo "[collect official-records] data=$DATE fonte=$SOURCE_URL" >&2

# ----------------------------------------------------------------------------
# CHAMADA DA FONTE (com fallback de exemplo)
# ----------------------------------------------------------------------------
# Tenta buscar o dado cru. Se a URL de exemplo nao responder (o que e esperado
# neste template, ja que api.exemplo.com nao existe), grava um JSON de exemplo
# pra rotina nao quebrar. Quando voce plugar a sua fonte real, este fallback
# deixa de ser acionado.
if curl -fsS --max-time 30 "$SOURCE_URL?date=$DATE" -o "$OUT" 2>/dev/null; then
  echo "[collect official-records] dado cru salvo em $OUT" >&2
else
  echo "[collect official-records] fonte nao respondeu (esperado no template). Gravando exemplo." >&2
  cat > "$OUT" <<EOF
{
  "_nota": "JSON de EXEMPLO. Substitua SOURCE_URL pela sua fonte real pra este arquivo virar dado cru de verdade.",
  "collected_at": "$DATE",
  "source": "$SOURCE_URL",
  "records": [
    {
      "id": "exemplo-1",
      "type": "novo-registro",
      "actor": "trocar-pelo-ator-real",
      "title": "Trocar pelo titulo real do registro/ato",
      "published_at": "$DATE",
      "url": "https://exemplo.com/registro/1"
    }
  ]
}
EOF
fi

echo "$OUT"
