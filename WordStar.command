#!/bin/bash
# Double-click me in Finder to launch WordStar 4.0 on macOS.
DIR="$(cd "$(dirname "$0")" && pwd)"
exec "$DIR/native/lib/launch.sh"
