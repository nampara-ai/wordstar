#!/usr/bin/env python3
"""Build a js-dos v8 `.jsdos` bundle for WordStar.

A `.jsdos` bundle is just a ZIP containing the DOS program files at the
root plus a `.jsdos/` folder with `dosbox.conf` and `jsdos.json`. js-dos
reads `.jsdos/dosbox.conf` to know how to boot.

Usage:
    make_jsdos.py <program_dir> <conf_file> <out.jsdos> [extra_file ...]
"""
import sys
import zipfile
from pathlib import Path

JSDOS_VERSION = "js-dos-v8"


def main(argv):
    if len(argv) < 4:
        sys.exit(__doc__)
    program_dir = Path(argv[1])
    conf_file = Path(argv[2])
    out = Path(argv[3])
    extras = [Path(p) for p in argv[4:]]

    conf = conf_file.read_text()
    out.parent.mkdir(parents=True, exist_ok=True)

    with zipfile.ZipFile(out, "w", zipfile.ZIP_DEFLATED) as z:
        # Program files (WS.EXE + overlays) at the bundle root, uppercased
        # to match DOS 8.3 expectations.
        for f in sorted(program_dir.iterdir()):
            if f.is_file():
                z.write(f, f.name.upper())
        # Extra seed files (e.g. WELCOME.DOC).
        for f in extras:
            if f.is_file():
                z.write(f, f.name.upper())
        # js-dos metadata.
        z.writestr(".jsdos/dosbox.conf", conf)
        z.writestr(".jsdos/jsdos.json", '{"version":"%s"}' % JSDOS_VERSION)

    size = out.stat().st_size
    print(f"wrote {out} ({size/1024:.0f} KiB)")


if __name__ == "__main__":
    main(sys.argv)
