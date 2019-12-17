#!/bin/sh

if [ -z "$OUT" ]; then
    echo '$OUT not supplied.'
    exit 1
fi

/lsif-node/tsc/bin/lsif-tsc -p "${PROJECT_ROOT}" --noContents --stdout | /lsif-node/npm/bin/lsif-npm -p "${PROJECT_ROOT}" --stdin --out "$OUT"
