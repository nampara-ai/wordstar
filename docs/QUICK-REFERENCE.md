# WordStar 4 — One‑Page Cheat Sheet

> Print me and tape me next to your screen. **`^` means `Ctrl`.**
> Two‑letter commands: hold `Ctrl`, tap the first letter, tap the second
> (`^KX` = `Ctrl‑K` then `X`).

---

## Start & quit

| | |
|---|---|
| Open / create a document | `D` (at the Opening Menu), type a name, `Enter` |
| **Save**, keep writing | `^KS` |
| Save, back to the menu | `^KD` |
| Save **and exit** | `^KX` |
| **Quit without saving** | `^KQ` then `Y` |
| Full screen on/off | `Alt‑Enter` |
| Help / change help level | `^J` / `^JH` |

> **Golden rule:** WordStar does **not** autosave. Press `^KS` every few minutes.

---

## Move the cursor

| | | | |
|---|---|---|---|
| Up / down / left / right | arrows, or `^E` `^X` `^S` `^D` | Word left / right | `^A` / `^F` |
| Start / end of line | `^QS` / `^QD` | Top / bottom of screen | `^QE` / `^QX` |
| Top / bottom of file | `^QR` / `^QC` | Previous position | `^QP` |
| Set bookmark 0–9 | `^K0`…`^K9` | Jump to bookmark | `^Q0`…`^Q9` |

---

## Edit

| | | | |
|---|---|---|---|
| Delete character | `Del` / `^G` | Delete word | `^T` |
| Delete line | `^Y` | Delete to end of line | `^QY` |
| **Un‑erase (undo)** | `^U` | Insert / overtype toggle | `^V` |
| Re‑align paragraph | `^B` | Split line / new line | `^M` |

---

## Blocks (cut, copy, paste)

| | | | |
|---|---|---|---|
| Mark **begin** / **end** | `^KB` / `^KK` | **Copy** to cursor | `^KC` |
| **Move** to cursor | `^KV` | **Delete** block | `^KY` |
| Write block → file | `^KW` | Read file → cursor | `^KR` |
| Column (rectangle) mode | `^KN` | Hide / show block | `^KH` |

---

## Find & replace

| | |
|---|---|
| Find | `^QF`, type text, `Enter` |
| Find **again** | `^L` |
| Find **and replace** | `^QA`, find, `Enter`, replace, `Enter`, options |
| Options | `G` whole file · `N` no‑ask · `U` ignore case · `W` whole words · `B` backward |

---

## Format

| | | | |
|---|---|---|---|
| Left / right margin | `^OL` / `^OR` | Center line | `^OC` |
| Line spacing | `^OS` | Justify on/off | `^OJ` |
| Word‑wrap on/off | `^OW` | Set / clear tab | `^OI` / `^ON` |

**Dot commands** (start of line, column 1): `.lm`/`.rm` margins · `.ls` spacing ·
`.pa` new page · `.he`/`.fo` header/footer · `.op` no page numbers · `..` comment

---

## Print formatting (toggle on, type, toggle off)

| | | | |
|---|---|---|---|
| **Bold** | `^PB` | Underline | `^PS` |
| Italic / alt | `^PY` | Strike‑through | `^PX` |
| Super / sub‑script | `^PT` / `^PV` | Show/hide tags on screen | `^OD` |

Print a file: from the Opening Menu press **`P`**, name the file, `Enter`.

---

Full details & lessons: [`MANUAL.md`](MANUAL.md)
