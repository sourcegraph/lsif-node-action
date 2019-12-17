#!/bin/sh

if [ -z "$OUT" ]; then
    echo '$OUT not supplied.'
    exit 1
fi

TSC_BIN="/lsif-node/tsc/bin/lsif-tsc"
NPM_BIN="/lsif-node/npm/bin/lsif-npm"

if [ ! -z "$VERBOSE" ]; then
    "${TSC_BIN}" --projectRoot "${PROJECT_ROOT}" --noContents --out temp.lsif -v
    "${NPM_BIN}" --in temp.lsif --out "$OUT" -v
    rm temp.lsif
else
    "${TSC_BIN}" --projectRoot "${PROJECT_ROOT}" --noContents --stdout | "${NPM_BIN}" --stdin --out "$OUT"
fi
