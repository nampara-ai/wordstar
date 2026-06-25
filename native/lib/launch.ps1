# Windows launcher for WordStar 4.0.
# Finds (or fetches) DOSBox, seeds the drive folder, writes a config, runs.
$ErrorActionPreference = "Stop"

# native\lib -> native -> repo root
$Repo    = Split-Path -Parent (Split-Path -Parent $PSScriptRoot)
$WsSrc   = Join-Path $Repo "ws4"
$Drive   = Join-Path $Repo "drive"
$Bin     = Join-Path $Repo "native\bin\windows"
$Tmpl    = Join-Path $Repo "config\native.conf.tmpl"
$ConfOut = Join-Path $Repo "native\.dosbox.generated.conf"

# --- 1. seed the drive folder (program + your documents) ---
if (-not (Test-Path (Join-Path $Drive "WS.EXE"))) {
    Write-Host "Setting up your WordStar folder (first run)..." -ForegroundColor Cyan
    New-Item -ItemType Directory -Force -Path $Drive | Out-Null
    Copy-Item (Join-Path $WsSrc "*") $Drive -Force
    $welcome = Join-Path $Repo "docs\WELCOME.DOC"
    if (Test-Path $welcome) { Copy-Item $welcome $Drive -Force }
}

# --- 2. find DOSBox (bundled first, then system) ---
function Find-DosBox {
    $cands = @()
    if (Test-Path $Bin) {
        $cands += Get-ChildItem -Path $Bin -Recurse -Filter "dosbox*.exe" -ErrorAction SilentlyContinue |
                  Select-Object -ExpandProperty FullName
    }
    foreach ($n in @("dosbox-staging", "dosbox")) {
        $c = Get-Command $n -ErrorAction SilentlyContinue
        if ($c) { $cands += $c.Source }
    }
    # Prefer a plain "dosbox.exe" / "dosbox-staging.exe" over debugger builds.
    $cands | Sort-Object { (Split-Path $_ -Leaf).Length }
}

$dosbox = Find-DosBox | Select-Object -First 1

# --- 3. fetch a private copy if nothing is installed ---
if (-not $dosbox) {
    Write-Host "No DOSBox found. Fetching a private copy (one-time, needs internet)..." -ForegroundColor Yellow
    & (Join-Path $Repo "scripts\fetch-dosbox.ps1")
    $dosbox = Find-DosBox | Select-Object -First 1
}

if (-not $dosbox) {
    throw "Could not find or install DOSBox. Run scripts\fetch-dosbox.ps1, or install it with:  winget install dosbox-staging"
}

# --- 4. generate the config with the real drive path ---
(Get-Content $Tmpl -Raw).Replace("__DRIVE__", $Drive) |
    Set-Content -NoNewline -Encoding ASCII $ConfOut

# --- 5. launch ---
Write-Host "Starting WordStar 4.0 ..." -ForegroundColor Cyan
Write-Host "Your documents are saved in: $Drive" -ForegroundColor Cyan
Write-Host "Tip: press Alt-Enter for full screen.  Manual: docs\MANUAL.md" -ForegroundColor Cyan
& $dosbox -conf $ConfOut
