#!/bin/sh

if [ -z "$OUT" ]; then
    echo '$OUT not supplied.'
    exit 1
fi

ABS_OUT=`realpath "$OUT"`
pushd "${PROJECT_ROOT}"
/lsif-node/tsc/bin/lsif-tsc -p . --noContents --stdout | /lsif-node/npm/bin/lsif-npm -p . --stdin --out "${ABS_OUT}"
popd
