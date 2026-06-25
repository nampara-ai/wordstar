# WordStar 4.0 — on a modern Mac, Windows, or Linux

The real MicroPro **WordStar Professional Release 4** (1987), running on
computers it was never meant to see — with zero setup.

WordStar is a 16‑bit MS‑DOS program. No modern OS can run it directly
(Apple dropped 32/16‑bit code entirely; 64‑bit Windows can't run DOS apps;
Linux never could). So this repo wraps the **original, unmodified** WordStar
binaries (`ws4/`) in DOSBox and gives you two ways in:

| | What it is | Best for |
|---|---|---|
| 🖥️ **Desktop** | Double‑click launcher → WordStar opens in a window. Your documents are real files in the `drive/` folder. | Actually writing. |
| 🌐 **Browser** | WordStar compiled to WebAssembly. Open a page, start typing. Nothing to install, ever. | Trying it instantly, any device. |

Both run the *same* WordStar binaries.

---

## 🌐 Browser — the truly zero‑install way

Open **`web/index.html`** through any web server and WordStar boots straight
into its opening menu. The quickest local way:

```bash
cd web && python3 -m http.server 8000
# now open http://localhost:8000
```

> It needs a server (not a `file://` double‑click) because browsers won't load
> WebAssembly off the local filesystem. The one‑liner above is all it takes —
> or publish it to the web for a permanent link (see *GitHub Pages* below).

Your work is saved automatically inside your browser. Use the floppy‑disk
button on the left edge to download your documents as files.

---

## 🖥️ Desktop — double‑click and write

Grab the repo (clone it, or download the ZIP and unzip), then:

| OS | Do this |
|---|---|
| **macOS** | Double‑click **`WordStar.command`** |
| **Windows** | Double‑click **`WordStar.bat`** |
| **Linux** | Run **`./wordstar.sh`** |

The first launch sets up a DOSBox (see *Zero dependencies* below) and creates
your **`drive/`** folder — that's your WordStar disk, holding the program and
every document you write. After that it just opens.

> **Already have DOSBox?** If `dosbox-staging` or `dosbox` is on your PATH, the
> launcher uses it and downloads nothing.

> **macOS Gatekeeper:** the first time, right‑click `WordStar.command` →
> **Open** to get past the "unidentified developer" prompt (once). The launcher
> clears the quarantine flag on its bundled DOSBox for you.

---

## Using WordStar (the 30‑second version)

WordStar is driven by **Ctrl‑key** commands. The essentials:

```
Ctrl‑K S    save, keep editing          Ctrl‑K X    save and exit
Ctrl‑K D    save, back to menu          Ctrl‑K Q    quit without saving
Ctrl‑J      help                        arrows      move (or Ctrl‑E/X/S/D)
```

From the opening menu press **D** to open or create a document, type a name
like `LETTER.DOC`, and go. The included **`WELCOME.DOC`** walks you through the
rest. (Yes, the Ctrl‑keys really do work in the browser — they're captured
before the browser sees them.)

---

## Zero dependencies, fully offline

The desktop launchers use **[DOSBox Staging](https://www.dosbox-staging.org/)**.
You never have to install it yourself — it arrives one of three ways:

1. **First run** downloads the build for your OS (one time, then offline forever).
2. **`scripts/fetch-dosbox.sh`** / **`scripts/fetch-dosbox.ps1`** stages it ahead of time.
3. The **`Build offline bundle`** GitHub Action produces
   **`WordStar-4-portable.zip`** with DOSBox for all three OSes already inside —
   download, unzip, double‑click, even with no internet at all.

See [`native/bin/README.md`](native/bin/README.md) for details.

---

## Publish the browser version (optional)

To get a permanent, shareable URL:

1. Push this repo to GitHub.
2. **Settings → Pages → Source: GitHub Actions.**
3. The included [`pages.yml`](.github/workflows/pages.yml) workflow deploys
   `web/` to `https://<you>.github.io/<repo>/`.

---

## What's in here

```
ws4/                     Original WordStar 4 binaries (the real thing)
docs/WELCOME.DOC         Sample document / quick tutorial
config/                  DOSBox configs (web + desktop)
web/                     Browser version (js-dos / DOSBox‑WASM) + index.html
  wordstar.jsdos         WordStar packaged as a js-dos bundle
WordStar.command         macOS launcher        (double‑click)
WordStar.bat             Windows launcher      (double‑click)
wordstar.sh              Linux launcher
native/lib/              Launcher internals (find/fetch DOSBox, boot WordStar)
native/bin/              Bundled DOSBox per OS (fetched, not committed)
scripts/                 fetch-dosbox.*, build-web.sh, make_jsdos.py
.github/workflows/       bundle.yml (offline zip) + pages.yml (browser site)
```

Rebuilt the browser bundle after changing `ws4/`? Run `scripts/build-web.sh`.

---

## Notes

- **WordStar** is the property of its respective rights holders. These binaries
  are widely distributed as abandonware; this project adds only the wrapping to
  run them and claims no ownership of WordStar itself.
- **DOSBox Staging** is GPL‑licensed and downloaded from its official releases.
- The browser version uses **[js-dos](https://js-dos.com)** (DOSBox compiled to
  WebAssembly), also GPL‑licensed; its files live under `web/`.
- The wrapper code in this repo (scripts, launchers, web glue) is free for you
  to use and adapt.
