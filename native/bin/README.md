# native/bin — bundled DOSBox lives here

This folder holds a private copy of **DOSBox Staging** for each platform, so
the desktop launchers run without you installing anything:

```
native/bin/linux/     dosbox-staging  + resources   (Linux x86_64)
native/bin/macos/     DOSBox Staging.app            (extracted on first run)
native/bin/windows/   dosbox.exe + DLLs             (Windows x64)
```

These binaries are **not committed to git** (they're large and platform
specific). They get here one of three ways:

1. **First run** — the launcher auto-downloads the copy it needs the first
   time you start WordStar (needs internet once; offline forever after).
2. **Pre-bundled** — run `scripts/fetch-dosbox.sh` (macOS/Linux) or
   `scripts/fetch-dosbox.ps1` (Windows) to stage it ahead of time.
3. **Release zip** — the `Build offline bundle` GitHub Action ships a
   `WordStar-4-portable.zip` with all three already inside.

If a system DOSBox is already installed (`dosbox-staging` or `dosbox` on your
PATH), the launcher just uses that and skips all of the above.
