#!/bin/sh

if [ -z "$OUT" ]; then
    echo 'file not supplied.'
    exit 1
fi

lsif-tsc --out "$OUT" -p "${PROJECT_ROOT}"
