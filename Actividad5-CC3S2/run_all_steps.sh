#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

ROOT="$(pwd)"
LOGDIR="$ROOT/Actividad5-CC3S2/logs"
EVIDIR="$ROOT/Actividad5-CC3S2/evidencia"
ARTDIR="$ROOT/Actividad5-CC3S2/artefactos"
METADIR="$ROOT/Actividad5-CC3S2/meta"

mkdir -p "$LOGDIR" "$EVIDIR" "$ARTDIR/out" "$ARTDIR/dist" "$METADIR"

# help
make help | tee "$LOGDIR/make-help.txt"

# build run1
rm -rf out dist || true
make build | tee "$LOGDIR/build-run1.txt"
cat out/hello.txt | tee "$EVIDIR/out-hello-run1.txt"

# build run2 + stat
make build | tee "$LOGDIR/build-run2.txt"
stat -c '%y %n' out/hello.txt | tee -a "$LOGDIR/build-run2.txt"

# fallo controlado
rm -f out/hello.txt || true
PYTHON=python4 make build 2>&1 | tee "$LOGDIR/fallo-python4.txt" || true
ls -l out/hello.txt >> "$LOGDIR/fallo-python4.txt" 2>&1 || echo "no existe (correcto)" | tee -a "$LOGDIR/fallo-python4.txt"

# dry run y make -d
make -n build | tee "$LOGDIR/dry-run-build.txt"
make -d build |& tee "$LOGDIR/make-d.txt"
grep -n "Considering target file 'out/hello.txt'" "$LOGDIR/make-d.txt" || true
grep -n "Considerando el archivo objetivo 'out/hello.txt'" "$LOGDIR/make-d.txt" || true

# reproducible tar (dos veces)
rm -rf dist || true
mkdir -p dist
tar --sort=name --mtime='UTC 1970-01-01' --owner=0 --group=0 --numeric-owner -cf dist/app.tar src/hello.py
gzip -n -9 -c dist/app.tar > dist/app.tar.gz
sha256sum dist/app.tar.gz | tee "$LOGDIR/sha256-1.txt"

rm -f dist/app.tar.gz dist/app.tar || true
mkdir -p dist
tar --sort=name --mtime='UTC 1970-01-01' --owner=0 --group=0 --numeric-owner -cf dist/app.tar src/hello.py
gzip -n -9 -c dist/app.tar > dist/app.tar.gz
sha256sum dist/app.tar.gz | tee "$LOGDIR/sha256-2.txt"

diff -u "$LOGDIR/sha256-1.txt" "$LOGDIR/sha256-2.txt" | tee "$LOGDIR/sha256-diff.txt" || true

# reproducir missing-separator
cp Makefile Makefile_bad || true
LINENUM=$(grep -nP '^\$\(OUT_DIR\)/hello.txt:' Makefile | cut -d: -f1 || echo "")
if [ -n "$LINENUM" ]; then
  sed -i "$((LINENUM+1))s/^\t/    /" Makefile_bad || true
fi
make -f Makefile_bad build 2>&1 | tee "$EVIDIR/missing-separator.txt" || true
rm -f Makefile_bad || true

# package final / copy artifacts
make package
cp out/hello.txt "$ARTDIR/out/"
cp dist/app.tar.gz "$ARTDIR/dist/"

# meta
uname -a > "$METADIR/entorno.txt" || true
make --version | head -n1 >> "$METADIR/entorno.txt" 2>/dev/null || true
bash --version | head -n1 >> "$METADIR/entorno.txt" 2>/dev/null || true
python3 --version >> "$METADIR/entorno.txt" 2>/dev/null || true
tar --version | head -n1 >> "$METADIR/entorno.txt" 2>/dev/null || true

if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then git rev-parse --short HEAD > "$METADIR/commit.txt" || true; else echo "N/A" > "$METADIR/commit.txt"; fi

echo "run_all_steps finalizado. Revisa Actividad5-CC3S2/"
