#!/usr/bin/env bash
# Rebuild the browser bundle (web/wordstar.jsdos) from the pristine
# WordStar binaries in ws4/ and the config in config/web.conf.
#
# Run this whenever you change ws4/, config/web.conf, or docs/WELCOME.DOC.
set -euo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

python3 scripts/make_jsdos.py \
    ws4 \
    config/web.conf \
    web/wordstar.jsdos \
    docs/WELCOME.DOC

echo "Browser bundle ready: web/wordstar.jsdos"
