#!/bin/bash

mkdir -p Actividad5-CC3S2/logs

if command -v shellcheck >/dev/null 2>&1; then
  shellcheck scripts/run_tests.sh | tee Actividad5-CC3S2/logs/lint-shellcheck.txt || true
else
  echo "shellcheck no instalado" | tee Actividad5-CC3S2/logs/lint-shellcheck.txt
fi

if command -v shfmt >/dev/null 2>&1; then
  shfmt -d scripts/run_tests.sh | tee Actividad5-CC3S2/logs/format-shfmt.txt || true
else
  echo "shfmt no instalado" | tee Actividad5-CC3S2/logs/format-shfmt.txt
fi
