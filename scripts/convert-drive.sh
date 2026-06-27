#!/usr/bin/env bash
#
# convert-drive.sh — make your WordStar drafts readable outside WordStar.
#
# WordStar saves "document mode" .DOC files with the high bit (0x80) set on each
# word's final letter, high-bit soft returns for word-wrap, embedded print-control
# codes, and ^Z/NUL padding — so they look garbled in TextEdit, Notepad, etc.
#
# This clones every .DOC in your drive/ folder, cleans it to plain UTF-8 text
# (un-garbles words, reflows word-wrapped lines, keeps real paragraph breaks,
# strips formatting markers), and writes the results to:
#
#     drive/doc-to-txt conversions/
#
# Your original .DOC files are NEVER modified. Re-run any time; it just refreshes
# the conversions. Runs on macOS and Linux (uses perl, preinstalled on both).
# Windows: use scripts/convert-drive.ps1.
#
set -euo pipefail

REPO="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
DRIVE="$REPO/drive"
OUT="$DRIVE/doc-to-txt conversions"

say()  { printf '\033[36m%s\033[0m\n' "$*"; }
warn() { printf '\033[33m%s\033[0m\n' "$*" >&2; }

[ -d "$DRIVE" ] || { warn "No drive/ folder yet — launch WordStar once first."; exit 0; }
command -v perl >/dev/null 2>&1 || { warn "This helper needs perl (preinstalled on macOS/Linux)."; exit 1; }

# WordStar document-mode -> clean text. Order matters: detect soft vs hard
# returns BEFORE clearing the high bit, or the two become indistinguishable.
clean() {
    perl -0777 -pe '
        s/\x1a.*//s;                        # ^Z = DOS end-of-file: cut it and trailing padding
        s/\x00//g;                          # drop NUL padding
        s/\x8d[\x0a\x8a]?/ /g;              # SOFT (word-wrap) return -> single space (reflow)
        s/\x0d\x0a?/\n/g;                   # HARD return -> real newline
        tr/\x80-\xff/\x00-\x7f/;            # clear WordStar high-bit flag (letters, soft spaces)
        s/[\x00-\x08\x0b\x0c\x0e-\x1f]//g;  # drop leftover control / print-control codes (keep tab + LF)
        s/(?<=\S) {2,}/ /g;                 # collapse interior soft/justification spaces (keep indents)
        s/[ \t]+$//mg;                      # trim trailing spaces
    ' "$1"
}

mkdir -p "$OUT"
shopt -s nullglob nocaseglob
count=0
for f in "$DRIVE"/*.doc; do
    base="$(basename "$f")"
    clean "$f" > "$OUT/${base%.*}.txt"
    echo "  $base  ->  doc-to-txt conversions/${base%.*}.txt"
    count=$((count + 1))
done
shopt -u nullglob nocaseglob

if [ "$count" -eq 0 ]; then
    warn "No .DOC files found in drive/. Write something in WordStar (save with Ctrl-K S) and run me again."
    rmdir "$OUT" 2>/dev/null || true
    exit 0
fi
say "Converted $count file(s) into:  $OUT"
