#!/bin/zsh
## genera practice/proyecto_condor.zip a partir de _build/proyecto_condor/
## los CSV se copian de final_project/data/condor tras verificar (md5) que son
## identicos a los publicados en las URL de los lineamientos
set -e
ROOT="$(cd "$(dirname "$0")/../../.." && pwd)"       # 02_class
BUILD="$ROOT/lectures/week-08/input/_build/proyecto_condor"
DATA="$ROOT/final_project/data/condor"
DEST="$ROOT/lectures/week-08/practice/proyecto_condor.zip"
URL="https://eduard-martinez.github.io/teaching/ba/final_project/data"

for t in base_clientes anexo_transacciones anexo_creditos anexo_campanas; do
  L=$(md5 -q "$DATA/$t.csv")
  R=$(curl -sL "$URL/$t.csv" | md5 -q)
  if [ "$L" != "$R" ]; then
    echo "ERROR: $t.csv local difiere del publicado (local $L, remoto $R)" >&2; exit 1
  fi
  cp "$DATA/$t.csv" "$BUILD/input/$t.csv"
  echo "$t.csv verificado y copiado ($L)"
done

mkdir -p "$BUILD/scripts" "$BUILD/output"
cd "$BUILD/.."
rm -f "$DEST"
zip -rq "$DEST" proyecto_condor -x "*.DS_Store"
echo "zip -> $DEST"; unzip -l "$DEST"
