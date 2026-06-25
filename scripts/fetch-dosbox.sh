#!/usr/bin/env bash
#
# Download a private copy of DOSBox Staging into native/bin/<os>/ so the
# desktop launchers can run fully offline afterwards.
#
# Runs on macOS and Linux. (Windows uses scripts/fetch-dosbox.ps1.)
# Used both by the launchers (first-run auto-fetch) and by CI to pre-bundle.
#
#   Usage: scripts/fetch-dosbox.sh [macos|linux]   (defaults to current OS)
#
set -euo pipefail

DBS_VERSION="0.82.2"
BASE="https://github.com/dosbox-staging/dosbox-staging/releases/download/v${DBS_VERSION}"

REPO="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
BIN="$REPO/native/bin"

OS="${1:-}"
if [ -z "$OS" ]; then
    case "$(uname -s)" in
        Darwin) OS=macos ;;
        Linux)  OS=linux ;;
        *) echo "Unsupported OS: $(uname -s)" >&2; exit 1 ;;
    esac
fi

say()  { printf '\033[36m%s\033[0m\n' "$*"; }
die()  { printf '\033[31m%s\033[0m\n' "$*" >&2; exit 1; }

dl() { # url dest
    say "Downloading $(basename "$1")"
    if command -v curl >/dev/null 2>&1; then curl -fSL --retry 3 -o "$2" "$1"
    elif command -v wget >/dev/null 2>&1; then wget -O "$2" "$1"
    else die "Need curl or wget to download DOSBox."; fi
}

TMP="$(mktemp -d)"
trap 'rm -rf "$TMP"' EXIT

case "$OS" in
  linux)
    dest="$BIN/linux"
    rm -rf "$dest"; mkdir -p "$dest"
    arc="$TMP/dbs-linux.tar.xz"
    dl "$BASE/dosbox-staging-linux-x86_64-v${DBS_VERSION}.tar.xz" "$arc"
    tar -xJf "$arc" -C "$dest" --strip-components=1
    chmod +x "$(find "$dest" -type f -name 'dosbox*' | head -1)" 2>/dev/null || true
    say "DOSBox Staging staged in $dest"
    ;;

  macos)
    dest="$BIN/macos"
    mkdir -p "$dest"
    if command -v hdiutil >/dev/null 2>&1; then
        # Real macOS: mount the dmg and copy the .app out -> runnable offline.
        rm -rf "$dest"; mkdir -p "$dest"
        dmg="$TMP/dbs.dmg"
        dl "$BASE/dosbox-staging-macOS-v${DBS_VERSION}.dmg" "$dmg"
        mnt="$(hdiutil attach -nobrowse -readonly "$dmg" | grep -o '/Volumes/.*' | head -1)"
        app="$(find "$mnt" -maxdepth 2 -name '*.app' | head -1)"
        [ -n "$app" ] || { hdiutil detach "$mnt" >/dev/null 2>&1; die "No .app inside the dmg"; }
        cp -R "$app" "$dest/"
        hdiutil detach "$mnt" >/dev/null 2>&1 || true
        xattr -dr com.apple.quarantine "$dest" 2>/dev/null || true
        say "DOSBox Staging staged in $dest"
    else
        # CI / non-mac host: stash the raw .dmg. The macOS launcher mounts and
        # extracts it on first run (where hdiutil is reliable; 7z on Linux
        # mangles the .app's symlinks and code signature).
        dl "$BASE/dosbox-staging-macOS-v${DBS_VERSION}.dmg" "$dest/dosbox-staging.dmg"
        say "DOSBox Staging .dmg stashed in $dest (extracted on first run, on a Mac)"
    fi
    ;;

  windows)
    # Staged from a Linux/macOS host (used by CI) so the Windows launcher
    # can run offline. On Windows itself, the launcher uses fetch-dosbox.ps1.
    dest="$BIN/windows"
    rm -rf "$dest"; mkdir -p "$dest"
    zip="$TMP/dbs-win.zip"
    dl "$BASE/dosbox-staging-windows-x64-v${DBS_VERSION}.zip" "$zip"
    command -v unzip >/dev/null 2>&1 || die "Need unzip to stage the Windows build."
    unzip -q "$zip" -d "$TMP/winx"
    inner="$(find "$TMP/winx" -maxdepth 1 -mindepth 1 -type d | head -1)"
    if [ -n "$inner" ]; then cp -R "$inner"/. "$dest"/; else cp -R "$TMP/winx"/. "$dest"/; fi
    say "DOSBox Staging staged in $dest"
    ;;

  *) die "Unknown OS target: $OS" ;;
esac
