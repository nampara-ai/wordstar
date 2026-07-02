#!/usr/bin/env bash
#
# Shared launcher for macOS and Linux. Finds (or fetches) DOSBox, seeds the
# WordStar drive folder, writes a config, and boots straight into WordStar.
#
# It is sourced/exec'd by the double-click entry points at the repo root:
#   WordStar.command  (macOS)      wordstar.sh  (Linux)
#
set -euo pipefail

# --- locate ourselves ---------------------------------------------------
# REPO is the project root (this file lives in <repo>/native/lib/).
LIB_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO="$(cd "$LIB_DIR/../.." && pwd)"
cd "$REPO"

WS_SRC="$REPO/ws4"                 # pristine WordStar program files
DRIVE="$REPO/drive"               # the C: drive: program + your documents
BIN="$REPO/native/bin"            # bundled DOSBox lives here
CONF_TMPL="$REPO/config/native.conf.tmpl"
CONF_OUT="$REPO/native/.dosbox.generated.conf"

case "$(uname -s)" in
    Darwin) OS=macos ;;
    Linux)  OS=linux ;;
    *)      echo "Unsupported OS: $(uname -s)"; exit 1 ;;
esac

say()  { printf '\033[36m%s\033[0m\n' "$*"; }
warn() { printf '\033[33m%s\033[0m\n' "$*" >&2; }
die()  { printf '\033[31m%s\033[0m\n' "$*" >&2; exit 1; }

# If we exit with an error during a double-click launch, the terminal window
# can slam shut before anyone reads why. Pause so the message stays put.
# (We exec DOSBox at the very end, which replaces this shell — so a *normal*
# WordStar exit never reaches this trap, only a failure before launch does.)
on_error_exit() {
    local code=$?
    if [ "$code" -ne 0 ] && [ -t 0 ]; then
        printf '\n\033[33mPress Enter to close this window.\033[0m' >&2
        read -r _ || true
    fi
}
trap on_error_exit EXIT

# --- 1. seed the drive folder (program + your documents) ----------------
if [ ! -f "$DRIVE/WS.EXE" ]; then
    say "Setting up your WordStar folder (first run)..."
    mkdir -p "$DRIVE"
    cp "$WS_SRC"/* "$DRIVE"/
    [ -f "$REPO/docs/WELCOME.DOC" ] && cp "$REPO/docs/WELCOME.DOC" "$DRIVE"/
fi

# --- 2. find DOSBox -----------------------------------------------------
# Build an ordered candidate list and pick the first that actually runs
# (so a bundled build with a missing system library is skipped gracefully).
# Order: bundled (offline) -> system dosbox-staging -> system dosbox.
DOSBOX=""

# Echo candidate paths, best first.
list_candidates() {
    /usr/bin/find "$BIN/$OS" -maxdepth 4 -type f -name 'dosbox*' -perm -111 2>/dev/null || true
    for c in dosbox-staging dosbox; do command -v "$c" 2>/dev/null || true; done
}

# A candidate "works" if it can print its version without crashing.
works() { "$1" --version >/dev/null 2>&1 || "$1" -version >/dev/null 2>&1; }

pick() {
    DOSBOX=""
    local cand
    while IFS= read -r cand; do
        [ -n "$cand" ] || continue
        if works "$cand"; then DOSBOX="$cand"; return; fi
    done < <(list_candidates)
}

pick

# --- 3a. macOS: extract the bundled raw .dmg on first run ---------------
# The repo ships native/bin/macos/dosbox-staging.dmg (extracting on Linux
# would mangle the app); unpack it here on the Mac, then look again.
# The dmg is a tracked file, so leave it in place — the extracted .app is
# gitignored, keeping git clones clean.
if [ -z "$DOSBOX" ] && [ "$OS" = macos ]; then
    dmg="$(/usr/bin/find "$BIN/macos" -maxdepth 1 -name '*.dmg' 2>/dev/null | head -1 || true)"
    if [ -n "$dmg" ] && command -v hdiutil >/dev/null 2>&1; then
        say "Unpacking the bundled DOSBox (first run)..."
        mnt="$(hdiutil attach -nobrowse -readonly "$dmg" | grep -o '/Volumes/.*' | head -1)"
        app="$(/usr/bin/find "$mnt" -maxdepth 2 -name '*.app' | head -1 || true)"
        [ -n "$app" ] && cp -R "$app" "$BIN/macos/"
        hdiutil detach "$mnt" >/dev/null 2>&1 || true
        pick
    fi
fi

# --- 3b. if still nothing, try to fetch a bundled copy ------------------
if [ -z "$DOSBOX" ]; then
    warn "No DOSBox found. Fetching a private copy (one-time, needs internet)..."
    if "$REPO/scripts/fetch-dosbox.sh"; then
        pick
    fi
fi

if [ -z "$DOSBOX" ]; then
    die "Could not find or install DOSBox.

Fix it one of these ways, then run this again:
  * Run:  ./scripts/fetch-dosbox.sh        (downloads a private copy)
  * macOS:  brew install dosbox-staging
  * Linux:  sudo apt install dosbox   (or: flatpak install flathub io.github.dosbox-staging)
"
fi

# macOS: clear Gatekeeper quarantine on a freshly-downloaded app bundle.
if [ "$OS" = macos ]; then
    case "$DOSBOX" in
        "$BIN"/*) xattr -dr com.apple.quarantine "$BIN/macos" 2>/dev/null || true ;;
    esac
fi

# --- 4. generate the config with the real drive path --------------------
sed "s|__DRIVE__|$DRIVE|g" "$CONF_TMPL" > "$CONF_OUT"

# --- 5. launch ----------------------------------------------------------
say "Starting WordStar 4.0 ..."
say "Your documents are saved in:  $DRIVE"
say "Tip: press Alt-Enter for full screen.  Manual: docs/MANUAL.md"
exec "$DOSBOX" -conf "$CONF_OUT"
