#!/usr/bin/env bash
# Run me to launch WordStar 4.0 on Linux:  ./wordstar.sh
DIR="$(cd "$(dirname "$0")" && pwd)"
exec "$DIR/native/lib/launch.sh"
