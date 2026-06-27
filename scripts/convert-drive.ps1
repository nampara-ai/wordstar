# convert-drive.ps1 — make your WordStar drafts readable outside WordStar (Windows).
#
# WordStar saves "document mode" .DOC files with the high bit (0x80) set on each
# word's final letter, high-bit soft returns for word-wrap, embedded print-control
# codes, and ^Z/NUL padding — so they look garbled in Notepad, etc.
#
# This clones every .DOC in your drive\ folder, cleans it to plain UTF-8 text
# (un-garbles words, reflows word-wrapped lines, keeps real paragraph breaks,
# strips formatting markers), and writes the results to:
#
#     drive\doc-to-txt conversions\
#
# Your original .DOC files are NEVER modified. Re-run any time. (macOS/Linux: use
# scripts/convert-drive.sh.)
$ErrorActionPreference = "Stop"

$Repo  = Split-Path -Parent $PSScriptRoot
$Drive = Join-Path $Repo "drive"
$Out   = Join-Path $Drive "doc-to-txt conversions"

if (-not (Test-Path $Drive)) {
    Write-Host "No drive\ folder yet — launch WordStar once first." -ForegroundColor Yellow
    return
}

# WordStar document-mode bytes -> clean text. Single forward pass: detect soft vs
# hard returns BEFORE clearing the high bit, or the two become indistinguishable.
function Convert-WsDoc([string]$Path) {
    $bytes = [System.IO.File]::ReadAllBytes($Path)
    $sb = New-Object System.Text.StringBuilder
    for ($i = 0; $i -lt $bytes.Length; $i++) {
        $b = $bytes[$i]
        if ($b -eq 0x1A) { break }                       # ^Z = DOS end-of-file
        if ($b -eq 0x00) { continue }                    # NUL padding
        if ($b -eq 0x8D) {                               # SOFT (word-wrap) return -> space
            [void]$sb.Append(' ')
            if (($i + 1 -lt $bytes.Length) -and (($bytes[$i+1] -eq 0x0A) -or ($bytes[$i+1] -eq 0x8A))) { $i++ }
            continue
        }
        if ($b -eq 0x0D) {                               # HARD return -> newline
            [void]$sb.Append("`n")
            if (($i + 1 -lt $bytes.Length) -and ($bytes[$i+1] -eq 0x0A)) { $i++ }
            continue
        }
        if (($b -eq 0x0A) -or ($b -eq 0x8A)) { [void]$sb.Append("`n"); continue }
        $c = $b -band 0x7F                               # clear WordStar high-bit flag
        if ($c -eq 0x09) { [void]$sb.Append("`t"); continue }
        if ($c -lt 0x20) { continue }                    # drop other control / print-control codes
        [void]$sb.Append([char]$c)
    }
    $text = $sb.ToString()
    $text = [regex]::Replace($text, '(?<=\S) {2,}', ' ')  # collapse interior soft/justification spaces
    $text = [regex]::Replace($text, '[ \t]+(\r?\n)', '$1') # trim trailing spaces before newlines
    $text = [regex]::Replace($text, '[ \t]+$', '')         # trim trailing spaces at end
    return $text
}

$docs = Get-ChildItem -Path $Drive -Filter *.doc -File -ErrorAction SilentlyContinue
if (-not $docs) {
    Write-Host "No .DOC files found in drive\. Write something in WordStar (save with Ctrl-K S) and run me again." -ForegroundColor Yellow
    return
}

New-Item -ItemType Directory -Force -Path $Out | Out-Null
$count = 0
foreach ($doc in $docs) {
    $name = [System.IO.Path]::GetFileNameWithoutExtension($doc.Name) + ".txt"
    $dest = Join-Path $Out $name
    [System.IO.File]::WriteAllText($dest, (Convert-WsDoc $doc.FullName), (New-Object System.Text.UTF8Encoding($false)))
    Write-Host ("  {0}  ->  doc-to-txt conversions\{1}" -f $doc.Name, $name)
    $count++
}
Write-Host ("Converted {0} file(s) into:  {1}" -f $count, $Out) -ForegroundColor Cyan
