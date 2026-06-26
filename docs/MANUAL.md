# The WordStar 4 Manual

### MicroPro **WordStar Professional Release 4** — running on your modern Mac, Windows, or Linux

---

> *“I’m a writer, and I use WordStar 4.0… I’m perfectly happy with it.”*
> — **George R. R. Martin**, who wrote *A Song of Ice and Fire* in this exact program.

This is the **real** WordStar — the unmodified 1987 MS‑DOS binaries that wrote a
generation of novels, screenplays, and dissertations — wrapped just enough to
boot on a computer it was never meant to meet. Nothing has been re‑implemented,
emulated‑in‑spirit, or “modernized.” When you press `Ctrl‑K X`, the same machine
code that ran on a 1987 IBM PC saves your file.

This manual is a complete, modern rewrite of the original MicroPro user guide —
same lessons, same warmth, same command reference — but with the 1987 floppy‑disk
ceremony replaced by *“double‑click the icon.”*

---

## Table of Contents

**Getting Started**
- [Before you begin: how this works](#before-you-begin)
- [Start WordStar — pick your computer](#start-wordstar)
- [Where your writing lives](#where-your-writing-lives)
- [The browser version (zero install)](#the-browser-version)

**Learning WordStar**
- [The 60‑second tour](#the-60-second-tour)
- [Lesson 1 — The Basics](#lesson-1)
- [Lesson 2 — Editing](#lesson-2)
- [Lesson 3 — Formatting Your Document](#lesson-3)
- [Lesson 4 — Blocks of Text](#lesson-4)
- [Lesson 5 — Find and Replace](#lesson-5)
- [Lesson 6 — Printing](#lesson-6)
- [Lesson 7 — Shorthand, Markers & the Calculator](#lesson-7)
- [Lesson 8 — Checking Your Spelling](#lesson-8)
- [Lesson 9 — Merge Printing (form letters)](#lesson-9)

**Reference**
- [The screen, explained](#the-screen-explained)
- [Complete command reference](#complete-command-reference)
  - [Edit Menu (cursor, scroll, erase)](#edit-menu)
  - [`^Q` Quick Menu](#quick-menu)
  - [`^K` Block & Save Menu](#block-menu)
  - [`^O` Onscreen Format Menu](#onscreen-menu)
  - [`^P` Print Controls Menu](#print-menu)
  - [`^J` Help Menu](#help-menu)
- [Dot commands](#dot-commands)
- [Merge‑print variables](#merge-variables)

**When things go sideways**
- [Troubleshooting](#troubleshooting)
- [Frequently asked questions](#faq)
- [About this build & licensing](#about-this-build)

A one‑page printable cheat sheet lives next door in
[`QUICK-REFERENCE.md`](QUICK-REFERENCE.md).

---

# Getting Started

<a name="before-you-begin"></a>
## Before you begin: how this works

WordStar is a **16‑bit MS‑DOS program**. No modern operating system can run it
directly — Apple dropped 16/32‑bit code entirely, 64‑bit Windows refuses DOS
executables, and Linux never spoke DOS at all. So this project does the only
honest thing: it runs the original binaries inside
**[DOSBox Staging](https://www.dosbox-staging.org/)**, a tiny, fast, modern
DOS emulator, and hands you a single icon to click.

You do **not** need to install DOSBox, configure anything, or know what any of
the previous sentence meant. A private copy of DOSBox for your operating system
is already bundled inside this folder. The first time you launch, WordStar sets
up a personal **`drive/`** folder for your work and opens. After that it just
opens. **It works completely offline, forever.**

> **Three things, once:** the very first launch may ask your OS for permission
> to run a downloaded program (every OS does this). It’s a one‑time click —
> [Troubleshooting](#troubleshooting) has the exact steps per platform.

---

<a name="start-wordstar"></a>
## Start WordStar — pick your computer

| Your computer | What to do | What you’ll see |
|---|---|---|
| 🍎 **macOS** | Double‑click **`WordStar.command`** | A small terminal opens, then WordStar fills a window. |
| 🪟 **Windows** | Double‑click **`WordStar.bat`** | A console flashes, then WordStar fills a window. |
| 🐧 **Linux** | Double‑click **`WordStar.desktop`**, or run **`./wordstar.sh`** in a terminal | WordStar fills a window. |

That’s the whole installation. The first run prints a friendly line or two
(*“Setting up your WordStar folder…”*), then drops you at WordStar’s **Opening
Menu**. From there, press **`D`** to open or create a document and start typing.

**Handy from the first second:**
- **`Alt‑Enter`** toggles **full screen** — the proper way to write.
- The window is freely resizable; WordStar’s text scales to fit.
- To leave WordStar entirely: from the Opening Menu press **`X`** (exit to DOS),
  then close the window. From inside a document, press **`Ctrl‑K X`** first to
  save and exit to the menu.

> **Already a DOSBox user?** If `dosbox-staging` or `dosbox` is on your `PATH`,
> the launcher quietly uses your copy instead of the bundled one. Either way,
> WordStar behaves identically.

---

<a name="where-your-writing-lives"></a>
## Where your writing lives

Everything you write is an ordinary file on your real computer, inside the
**`drive/`** folder next to the launcher:

```
WordStar-4/
├── WordStar.command / .bat / .desktop   ← the icon you click
├── drive/                               ← YOUR WORK LIVES HERE
│   ├── WS.EXE  …                        ← the WordStar program (copied here on first run)
│   ├── WELCOME.DOC                      ← a friendly starter document
│   ├── LETTER.DOC                       ← (example) something you wrote
│   └── LETTER.BAK                       ← WordStar’s automatic backup of it
└── …
```

Inside WordStar this folder is **drive `C:`**. A file you save as `LETTER.DOC`
is really `drive/LETTER.DOC` — open it in any modern editor, email it, back it
up, sync it to the cloud. It’s just a text file.

**About `.BAK` files.** The moment you edit and re‑save a document, WordStar
keeps the previous version as a `.BAK` file. Deleted three paragraphs you
wanted? Your last save is sitting right there in `LETTER.BAK`. To recover it,
rename it (e.g. to `LETTER.DOC`) from your file manager, or from WordStar’s
Opening Menu use **`E`** (rename) — see the [Block menu](#block-menu).

> **File names are DOS‑style:** up to **8 characters**, a dot, then up to **3**
> (`CHAPTER1.DOC`, `NOTES.TXT`). Letters and numbers are safest. This is a 1987
> program; it is delightfully literal about this.

---

<a name="the-browser-version"></a>
## The browser version (zero install)

There’s a second way in that installs *nothing at all*: WordStar compiled to
WebAssembly, running in a web page.

```bash
cd web && python3 -m http.server 8000
# then open http://localhost:8000
```

It needs a tiny local web server (the one‑liner above) rather than a `file://`
double‑click, because browsers won’t load WebAssembly straight off disk. Your
work autosaves *inside the browser*. To save copies onto your computer, save in
WordStar first (`Ctrl‑K S`), then click **⬇ Download files** in the top bar and
choose the documents you want — they're handed back as clean, readable text
files.

> Note: the floppy‑disk icon in the emulator's own side‑rail only *persists your
> work to this browser* (so it survives a reload). Use the **⬇ Download files**
> button in the page's top bar to actually save files to your computer.

Every Ctrl‑key in this manual works in the browser too — they’re captured before
the browser sees them. This repo already publishes the browser edition at
**<https://nampara-ai.github.io/wordstar/>** — open it on any device, nothing to
install. (To host your own copy, see *Publish the browser version* in the
[README](../README.md).)

---

# Learning WordStar

<a name="the-60-second-tour"></a>
## The 60‑second tour

WordStar predates the mouse, so it’s driven from the keyboard with **`Ctrl`‑key
commands**. Hold **`Ctrl`** and tap a letter. Some commands are two letters: for
**`^K X`**, hold `Ctrl`, tap `K`, then tap `X` (you can keep holding `Ctrl` the
whole time). Throughout this manual, **`^`** means **`Ctrl`** — `^KX` is the
classic WordStar way to write `Ctrl‑K, X`.

The eight commands that get you writing today:

| Command | Does this |
|---|---|
| `D` (at the Opening Menu) | **Open or create** a document |
| *(just type)* | Insert text wherever the cursor is |
| **arrow keys** | Move around (or `^E`/`^X`/`^S`/`^D` — up/down/left/right) |
| `^Y` | Delete the whole line |
| `^T` | Delete the next word |
| `^KS` | **Save** and keep writing |
| `^KD` | **Save** and return to the menu |
| `^KX` | **Save** and exit WordStar |
| `^J` | **Help** |

> **The one rule that saves heartbreak:** WordStar does not auto‑save to disk.
> Press **`^KS`** every few minutes. It’s instant, and you’ll never lose a thing.

Now do the lessons — they take about half an hour total and you’ll come out
genuinely fluent.

---

<a name="lesson-1"></a>
## Lesson 1 — The Basics

**Goal:** create a file, type into it, save it, and reopen it.

1. **Launch WordStar** (double‑click your launcher). You’ll land at the
   **Opening Menu** — a list of single‑letter choices.
2. Press **`D`**. WordStar asks **`Document?`**.
3. Type a name — **`FIRST.DOC`** — and press **`Enter`**. Because the file
   doesn’t exist yet, WordStar creates it and opens a blank editing screen.
4. **Type a few sentences.** Don’t press Enter at the end of each line — like
   every word processor since, WordStar **wraps** words to the next line for you.
   Press `Enter` only to start a new paragraph.
5. **Save and keep editing:** press **`^KS`**. The disk light (metaphorically)
   blinks; you’re right back where you were.
6. **Save and exit to the menu:** press **`^KD`**. You’re at the Opening Menu,
   and `FIRST.DOC` now appears in the file list.
7. **Reopen it:** press **`D`**, type `FIRST.DOC`, `Enter`. There’s your text.

🎉 You just used WordStar exactly the way people used it for twenty years.

**If you make a mess and want to bail without saving:** press **`^KQ`**
(*Quit*), then `Y`. Nothing you did since the last save is written.

---

<a name="lesson-2"></a>
## Lesson 2 — Editing

Open `FIRST.DOC` again (`D`, name, `Enter`). The **Edit Menu** sits at the top
of the screen as a permanent cheat sheet.

### Moving the cursor

| Key(s) | Moves |
|---|---|
| Arrow keys | One character / line — always works |
| `^S` `^D` | Left / right one **character** |
| `^E` `^X` | Up / down one **line** |
| `^A` `^F` | Left / right one **word** |
| `^QS` `^QD` | Start / end of the **line** |
| `^QE` `^QX` | Top / bottom of the **screen** |
| `^QR` `^QC` | Top / bottom of the **whole file** |

(Notice the `^E ^S ^D ^X` diamond under your left hand — up, left, right, down.
That muscle memory is why touch‑typists loved WordStar: your hands never leave
home row.)

### Erasing and fixing

| Key(s) | Erases |
|---|---|
| `Del` / `Backspace` | One character |
| `^G` | Character **under** the cursor |
| `^T` | The next **word** |
| `^Y` | The **whole line** |
| `^QY` | From the cursor to the **end of the line** |
| `^U` | **Un‑erase** — undo your last deletion |

> **`^U` is your undo.** Deleted the wrong line with `^Y`? Press `^U` and it
> comes right back.

### Inserting vs. typing‑over

By default WordStar is in **Insert** mode: new text pushes existing text aside.
Press **`^V`** to toggle **Overtype** mode (the word `Insert` on the status line
disappears) — now you type *over* what’s there. Press `^V` again to switch back.

### Tidying a paragraph

Edited the middle of a paragraph and the right edge went ragged? Put the cursor
in it and press **`^B`** to **re‑align** (reflow) the paragraph to the current
margins. Save with `^KS` when you’re happy.

---

<a name="lesson-3"></a>
## Lesson 3 — Formatting Your Document

WordStar formats text two ways: live **Onscreen Format** commands (the `^O`
menu) and **dot commands** you type into the document itself.

### The ruler line and margins

The **ruler line** near the top shows your left margin (`L`), right margin
(`R`), and tab stops (`!`). To change margins on the fly:

| Command | Sets |
|---|---|
| `^OL` | **Left** margin to the current column |
| `^OR` | **Right** margin to the current column |
| `^OC` | **Center** the current line between the margins |
| `^OS` | Line **spacing** (1 = single, 2 = double, …) |
| `^OW` | **Word‑wrap** on/off |
| `^OJ` | **Justification** on/off (flush right edge vs. ragged) |

### Tabs

- `^OI` — set a tab stop at the current column
- `^ON` — clear the tab stop at the current column
- `^OG` — temporary paragraph indent (great for block quotes)

### Dot commands (page layout)

A **dot command** is a line that starts with a period in column 1, followed by
a two‑letter code. It controls the *printed* page and never prints itself. Type
them on their own line:

```
.lm 10        left margin = column 10
.rm 70        right margin = column 70
.pl 66        page length = 66 lines
.mt 6         top margin = 6 lines
.mb 6         bottom margin = 6 lines
.op           omit page numbers
.pa           start a new page here
.ls 2         double‑spacing from here on
```

The full list is in the [Dot commands](#dot-commands) reference. Lines that
begin with `..` (two dots) are **comments** — they neither print nor format.

---

<a name="lesson-4"></a>
## Lesson 4 — Blocks of Text

A **block** is any chunk of text you mark, then copy, move, delete, or save to
its own file. This is WordStar’s cut‑and‑paste.

1. Put the cursor at the **start** of the text and press **`^KB`** (block
   **begin**).
2. Move to the **end** of the text and press **`^KK`** (block end). The marked
   text highlights.
3. Now act on it:

| Command | Does |
|---|---|
| `^KC` | **Copy** the block to the cursor’s location |
| `^KV` | **Move** the block to the cursor’s location |
| `^KY` | **Delete** the block |
| `^KW` | **Write** the block out to a new file |
| `^KR` | **Read** another file in at the cursor |
| `^KH` | **Hide/show** the block highlighting |

To move a paragraph: mark it with `^KB`/`^KK`, put the cursor where it should
go, press `^KV`. Done.

> **Column mode.** Press **`^KN`** to toggle **column** blocks — now a block is a
> rectangle, perfect for editing a single column of a table without disturbing
> its neighbors. Press `^KN` again to return to normal.

### Place markers

Drop a numbered bookmark with **`^K0`** through **`^K9`**, then jump back to it
instantly from anywhere with **`^Q0`**–**`^Q9`**. Invaluable in a long chapter.

---

<a name="lesson-5"></a>
## Lesson 5 — Find and Replace

### Find

Press **`^QF`**, type the text you’re looking for, `Enter`. WordStar jumps to
the next occurrence. Press **`^L`** to find the **next** one, and the next.

### Find and replace

Press **`^QA`**, type the text to find, `Enter`, then the replacement, `Enter`.
WordStar then asks for **options** — type any combination and press `Enter`:

| Option | Meaning |
|---|---|
| `G` | **Global** — search the whole file, not just from here down |
| `N` | **No‑ask** — replace every match without confirming each |
| `B` | Search **backward** |
| `U` | Ignore **upper/lower case** |
| `W` | **Whole words** only |

Example: to change every “color” to “colour” in the whole document without being
asked each time, press `^QA`, type `color`, `Enter`, `colour`, `Enter`, then
`GN`, `Enter`.

> Without `N`, WordStar stops at each match and asks **`Y/N`**. Press `^L` to
> repeat the same find‑and‑replace after it pauses.

---

<a name="lesson-6"></a>
## Lesson 6 — Printing

### Formatting as you type

These **print controls** mark text for **bold**, *underline*, and more. They
insert a little `^B`‑style tag (shown on screen, not printed) around your text:

| Command | Effect when printed |
|---|---|
| `^PB` | **Bold** |
| `^PS` | Underline |
| `^PD` | Double‑strike (heavier bold) |
| `^PX` | ~~Strike‑through~~ |
| `^PV` | Sub­script |
| `^PT` | Super­script |
| `^PY` | Italic / alternate font |

Press the command once where the effect should **start**, type your text, press
it again where it should **stop**. Press **`^OD`** to toggle whether these tags
are shown on screen.

### Actually printing

1. From the **Opening Menu**, press **`P`**.
2. Type the file name and `Enter`.
3. Answer the print prompts (you can just press `Enter` through them to accept
   the defaults), and printing begins.

> **Printing in DOSBox → a real printer or PDF.** The bundled DOS environment
> doesn’t see your physical printer directly. The reliable, modern workflow is:
> open your `.DOC` file from `drive/` in any current editor or word processor and
> print/PDF from there — it’s plain text. For a faithful WordStar‑formatted
> rendering, “print to file” inside WordStar (choose a file name at the
> `PRN device?` prompt) and you’ll get a print‑image text file in `drive/`.

---

<a name="lesson-7"></a>
## Lesson 7 — Shorthand, Markers & the Calculator

### Shorthand (keyboard macros)

Tired of typing your name and address? Record it once. Press **`Esc`** to open
the **Shorthand** menu, assign your text to a key, and from then on `Esc` +
that key types the whole thing. Great for sign‑offs, legal boilerplate, or a
phrase you repeat a hundred times.

### The on‑screen calculator

WordStar has a built‑in calculator. From the Quick menu you can total numbers
and drop the result straight into your document — handy for invoices and
tables. (In a marked column block, **block math** can sum a column of figures.)

### Help levels

WordStar shows menus to help you learn. Once you’re fluent and want a cleaner
screen, lower the **help level**: press **`^JH`** and choose a number `0`–`4`
(`4` = full menus, `0` = expert mode, menus hidden, maximum writing space).
Raise it back any time the same way.

---

<a name="lesson-8"></a>
## Lesson 8 — Checking Your Spelling

WordStar 4 ships with a spelling checker (the `WSSPELL`/`SPELSTAR` overlays, both
already in your `drive/` folder).

- **`^QL`** checks spelling from the cursor to the end of the document.
- WordStar stops on each word it doesn’t recognize and offers choices: skip it,
  correct it, or add it to your personal dictionary.

It’s a 1987 dictionary, so it won’t know “blog” or “emoji” — but for prose,
proper nouns aside, it’s genuinely useful.

---

<a name="lesson-9"></a>
## Lesson 9 — Merge Printing (form letters)

**Merge printing** turns one master letter + a list of names into a stack of
personalized letters. It’s the great‑grandparent of mail‑merge. The engine is
the `MAILMRGE.OVR` overlay (already in `drive/`).

**The idea in three parts:**

1. **A data file** — one record per line, fields separated by commas:
   ```
   Mr. Gulliver,152 Lilliput Street,San Francisco,CA,94118
   Ms. Brobdingnag,4 Giant Way,Oakland,CA,94607
   ```
2. **A master document** with **variables** in `&ampersands&` where the data
   should drop in, plus dot commands that name the fields and the data file:
   ```
   .df NAMES.DAT
   .rv name,street,city,state,zip
   &name&
   &street&
   &city&, &state&  &zip&

   Dear &name&,
       Thank you for your interest in our European tour…
   ```
3. **Merge‑print it:** from the Opening Menu press **`M`** (merge print), give
   the master document’s name, and WordStar prints one finished letter per line
   of the data file.

See [Merge‑print variables](#merge-variables) for the full command set. This is
genuinely powerful — people ran entire small businesses on it.

---

# Reference

<a name="the-screen-explained"></a>
## The screen, explained

```
 ┌─ status line ──────────────────────────────────────────────┐
 │ C:FIRST.DOC      L14 C81   INSERT   ALIGN                   │
 ├─ Edit Menu (or whichever menu you’ve opened) ──────────────┤
 │   CURSOR     SCROLL     ERASE      OTHER MENUS              │
 │   ^E up      ^W up      ^G char    ^O onscreen format       │
 │   ^X down    ^Z down    ^T word    ^K block                 │
 │   ^S left    ^R up scrn ^Y line    ^P print controls        │
 │   ^D right   ^C dn scrn Del char   ^Q quick functions       │
 ├─ ruler line ───────────────────────────────────────────────┤
 │ L----!----!----!----!----!----!----!----------------------R │
 ├─ your text ────────────────────────────────────────────────┤
 │ Dear Mr. Gulliver,                                          │
 │     I saw your recent advertisement…                        │
 └─────────────────────────────────────────────────────────────┘
```

- **Status line** — file name; **L**ine and **C**olumn of the cursor; whether
  you’re in **INSERT** or overtype; and alignment state.
- **Menu** — the current command menu. It changes as you press `^K`, `^Q`,
  `^O`, `^P`, or `^J`. Lower the [help level](#help-menu) to hide it.
- **Ruler line** — left margin `L`, right margin `R`, tab stops `!`.
- **Flag column** (far right) — tiny symbols mark hard returns, continued
  lines, dot‑command lines, and page breaks.

---

<a name="complete-command-reference"></a>
## Complete command reference

Throughout, **`^` = `Ctrl`**. Two‑letter commands: hold `Ctrl`, tap the first
letter, tap the second (e.g. `^KX` = `Ctrl‑K` then `X`).

<a name="edit-menu"></a>
### Edit Menu — cursor, scroll, erase

| Cursor | | Scroll | | Erase | | Other |
|---|---|---|---|---|---|---|
| `^E` up | | `^W` up | | `^G` char | | `^I` tab |
| `^X` down | | `^Z` down | | `^T` word | | `^V` insert on/off |
| `^S` left | | `^R` up a screen | | `^Y` line | | `^B` align paragraph |
| `^D` right | | `^C` down a screen | | `Del` char | | `^M` split line / new line |
| `^A` word left | | | | `^U` un‑erase | | `^L` find/replace again |
| `^F` word right | | | | `^QY` to end of line | | `^J` help |

<a name="quick-menu"></a>
### `^Q` Quick Menu — fast moves & big erases

| Command | Action |
|---|---|
| `^QS` / `^QD` | Start / end of **line** |
| `^QE` / `^QX` | Top / bottom of **screen** |
| `^QR` / `^QC` | Top / bottom of **file** |
| `^QB` / `^QK` | Jump to block **begin** / **end** marker |
| `^QF` | **Find** text |
| `^QA` | Find **and replace** |
| `^QL` | **Spell‑check** to end of file |
| `^QY` | Delete to **end** of line |
| `^QDel` | Delete to **start** of line |
| `^QV` | Jump to the **last** find / block edit |
| `^QP` | Jump back to the **previous** cursor position |
| `^Q0`–`^Q9` | Jump to **place marker** 0–9 |
| `^QW` / `^QZ` | Continuous scroll up / down (any key stops it) |

<a name="block-menu"></a>
### `^K` Block & Save Menu — blocks, files, saving

| Saving / leaving | | Blocks | | Files |
|---|---|---|---|---|
| `^KS` save, keep editing | | `^KB` mark block **begin** | | `^KR` **read** a file in |
| `^KD` save, back to menu | | `^KK` mark block **end** | | `^KW` **write** block to a file |
| `^KX` save **and exit** | | `^KC` **copy** block | | `^KO` copy a file |
| `^KQ` **quit**, abandon changes | | `^KV` **move** block | | `^KE` rename a file |
| | | `^KY` **delete** block | | `^KJ` delete a file |
| `^K0`–`^K9` set place marker | | `^KN` **column** mode on/off | | `^KP` print a file |
| | | `^KH` hide/show block | | `^KL` change logged drive |

<a name="onscreen-menu"></a>
### `^O` Onscreen Format Menu — margins, tabs, spacing

| Command | Sets |
|---|---|
| `^OL` / `^OR` | Left / right **margin** to current column |
| `^OC` | **Center** the current line |
| `^OS` | Line **spacing** |
| `^OW` | **Word‑wrap** on/off |
| `^OJ` | **Justification** on/off |
| `^OI` / `^ON` | Set / clear a **tab** stop |
| `^OG` | Temporary paragraph **indent** |
| `^OX` | Margin **release** (type past the margin once) |
| `^OF` | Set the **ruler** from the current line |
| `^OD` | Show/hide **print‑control tags** on screen |

<a name="print-menu"></a>
### `^P` Print Controls Menu — bold, underline, etc.

| Command | Prints as | | Command | Prints as |
|---|---|---|---|---|
| `^PB` | **Bold** | | `^PT` | Super­script |
| `^PS` | Underline | | `^PV` | Sub­script |
| `^PD` | Double‑strike | | `^PY` | Italic / alternate |
| `^PX` | Strike‑through | | `^PH` | Overprint a character |
| `^PC` | Pause the printer | | `^PO` | Non‑break space |

Toggle each effect on, type, toggle off. `^OD` shows/hides these tags on screen.

<a name="help-menu"></a>
### `^J` Help Menu

| Command | Shows |
|---|---|
| `^JH` | Change the **help level** (`0` expert … `4` full menus) |
| `^JD` | Dot‑command help |
| `^JI` | Index / paragraph reform help |
| `^JS` | Status‑line help |
| `^JR` | Ruler & margins help |
| `^JM` | Margins & tabs help |

> **Tip:** press `^J` alone, then pause — WordStar shows the help menu and waits.

---

<a name="dot-commands"></a>
## Dot commands

Type these on their own line, starting with a period in **column 1**. They shape
the printed page and never print themselves.

| Command | Meaning |
|---|---|
| `.lm n` | Left margin = column *n* |
| `.rm n` | Right margin = column *n* |
| `.pl n` | Page length = *n* lines (66 for US Letter) |
| `.mt n` / `.mb n` | Top / bottom margin = *n* lines |
| `.po n` | Page offset (shift everything *n* columns right) |
| `.ls n` | Line spacing (1, 2, 3 …) |
| `.lh n` | Line height (fine vertical spacing) |
| `.cw n` | Character width (horizontal pitch) |
| `.he text` | Running **header** on every page |
| `.fo text` | Running **footer** on every page |
| `.pn n` | Start **page numbering** at *n* |
| `.op` | **Omit** page numbers |
| `.pa` | Start a **new page** here |
| `.cp n` | Conditional page — keep the next *n* lines together |
| `.pa`, `.pn`, `.op` | (page control, above) |
| `.ig text` or `..text` | A **comment** — ignored entirely |
| `.cs` | Clear the screen (merge printing) |

<a name="merge-variables"></a>
## Merge‑print variables

Used in master documents for [merge printing](#lesson-9):

| Command | Meaning |
|---|---|
| `.df file` | **Data file** to read records from |
| `.rv a,b,c` | **Read variables** — name the comma‑separated fields |
| `.av "prompt",x` | **Ask** for variable *x* at print time |
| `&name&` | Insert the value of variable *name* here |
| `.dm text` | Display a message on screen during the merge |
| `.fi file` | **File insert** — chain/include another document |
| `.cs` | Clear the screen between letters |

---

# When things go sideways

<a name="troubleshooting"></a>
## Troubleshooting

**“Unidentified developer” / “unknown developer” (macOS).**
The first time only: **right‑click** `WordStar.command` → **Open** → **Open**.
After that, double‑click works normally. The launcher automatically clears the
quarantine flag on its bundled DOSBox for you.

**Windows SmartScreen blue box.**
Click **More info → Run anyway** (once). Nothing here phones home; SmartScreen
just flags any program it hasn’t seen before. The launcher unblocks the bundled
DOSBox files for you.

**Double‑clicking `wordstar.sh` opens a text editor (Linux).**
File managers vary. Use **`WordStar.desktop`** instead (you may need to
right‑click → *Allow Launching* / *Trust* the first time), or open a terminal in
this folder and run `./wordstar.sh`. If it says *permission denied*, run
`chmod +x wordstar.sh native/lib/launch.sh` once.

**“Could not find or install DOSBox.”**
A DOSBox copy is bundled, so this is rare. It can happen if the bundled binary
is missing a system library. Fixes, any one of them:
- macOS: `brew install dosbox-staging`
- Linux: `sudo apt install dosbox` *(or `flatpak install flathub io.github.dosbox-staging`)*
- Windows: `winget install dosbox-staging`
- Or run `scripts/fetch-dosbox.sh` (macOS/Linux) / `scripts/fetch-dosbox.ps1`
  (Windows) to re‑stage a fresh copy.
The launcher automatically prefers a working system DOSBox if one is installed.

**A blank or black window, or it closes instantly.**
Resize the window, or press `Alt‑Enter` for full screen. If the window vanishes
the instant it opens, launch from a terminal so the error text stays visible
(`./wordstar.sh`), and check the message.

**I don’t see my file in the Opening Menu.**
The list shows the current drive (`C:`). Make sure you saved it (`^KS`/`^KD`) and
that the name fits **8.3** (e.g. `CHAPTER1.DOC`). Your files are physically in
the `drive/` folder — open it in your file manager to confirm.

**I lost my latest edits.**
Look for a `.BAK` file of the same name in `drive/` — it’s your previous saved
version. Rename it to recover. And going forward: `^KS` early, `^KS` often.

**The Ctrl‑keys don’t seem to do anything.**
Make sure the WordStar window has focus (click it). In the browser version,
click inside the WordStar screen first. `Alt‑Enter` (full screen) helps the
emulator capture every key.

---

<a name="faq"></a>
## Frequently asked questions

**Is this really WordStar, or a clone?**
Really WordStar. The files in `ws4/` are the original 1987 MicroPro binaries,
byte‑for‑byte. We only added the wrapper that boots them.

**Will my files work in modern programs?**
Yes — they’re plain text. WordStar may add a few formatting markers; any modern
editor opens them fine. For a perfectly clean text file, save (or “print to
file”) and the result is portable everywhere.

**Do I need the internet?**
No. DOSBox is bundled in this folder. Everything runs fully offline, forever.

**Can I use my own DOSBox?**
Yes. If `dosbox-staging` or `dosbox` is on your `PATH`, the launcher uses it.

**Where’s the autosave?**
There isn’t one — this is 1987. Press **`^KS`** regularly. It’s instant.

**How do I get a clean, distraction‑free screen?**
`^JH` → `0` hides the menus (expert mode), and `Alt‑Enter` goes full screen.
That’s the famous WordStar writing experience — just you and the text.

---

<a name="about-this-build"></a>
## About this build & licensing

- **WordStar** is the property of its respective rights holders. These binaries
  are widely distributed as abandonware; this project adds only the wrapping
  needed to run them and claims no ownership of WordStar itself.
- **DOSBox Staging** is GPL‑licensed; the copies bundled in `native/bin/` come
  straight from its [official releases](https://github.com/dosbox-staging/dosbox-staging/releases)
  (version pinned in `scripts/fetch-dosbox.sh`).
- The **browser** edition uses [js‑dos](https://js-dos.com) (DOSBox compiled to
  WebAssembly), also GPL‑licensed; its files live under `web/`.
- The **wrapper** in this repo — launchers, scripts, configs, this manual — is
  free for you to use and adapt.

---

*“It is 1987 again. Have fun.”* — Now go write something.
