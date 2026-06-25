# native/bin — bundled DOSBox lives here

This folder holds a private copy of **DOSBox Staging** for each platform, so the
desktop launchers run without you installing anything:

```
native/bin/linux/     dosbox-staging  + resources   (Linux x86_64)
native/bin/macos/     dosbox-staging.dmg            (unpacked to a .app on first run, on a Mac)
native/bin/windows/   dosbox.exe + DLLs             (Windows x64)
```

**These binaries are committed to git and ship in‑repo**, so a fresh clone (or
the release zip) runs fully offline with zero downloads. The version is pinned
in [`scripts/fetch-dosbox.sh`](../../scripts/fetch-dosbox.sh).

### Refreshing or re‑staging them

If you ever need to re‑fetch (e.g. to bump the DOSBox version), run:

```
scripts/fetch-dosbox.sh linux      # or: macos / windows
scripts/fetch-dosbox.ps1           # on a Windows host
```

The `Build offline bundle` GitHub Action also re‑stages all three platforms when
it assembles `WordStar-4-portable.zip`.

### Using your own DOSBox instead

If `dosbox-staging` or `dosbox` is already on your `PATH`, the launcher prefers
that and ignores the bundled copy entirely — these files are just the
batteries‑included fallback so nobody *has* to install anything.

DOSBox Staging is GPL‑licensed and comes straight from its
[official releases](https://github.com/dosbox-staging/dosbox-staging/releases).
