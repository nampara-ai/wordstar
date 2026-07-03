# Download a private copy of DOSBox Staging into native\bin\windows so the
# Windows launcher can run fully offline afterwards. Used by the launcher's
# first-run auto-fetch and by CI to pre-bundle.
$ErrorActionPreference = "Stop"

$Version = "0.82.2"
$Base    = "https://github.com/dosbox-staging/dosbox-staging/releases/download/v$Version"

$Repo = Split-Path -Parent $PSScriptRoot
$Dest = Join-Path $Repo "native\bin\windows"

if (Test-Path $Dest) { Remove-Item -Recurse -Force $Dest }
New-Item -ItemType Directory -Force -Path $Dest | Out-Null

$zip = Join-Path $env:TEMP "dbs-win.zip"
Write-Host "Downloading DOSBox Staging $Version ..." -ForegroundColor Cyan
Invoke-WebRequest -Uri "$Base/dosbox-staging-windows-x64-v$Version.zip" -OutFile $zip

$tmp = Join-Path $env:TEMP ("dbsx_" + [guid]::NewGuid().ToString("N"))
Expand-Archive -Path $zip -DestinationPath $tmp -Force

# The zip contains a top-level folder; flatten its contents into $Dest.
$inner = Get-ChildItem -Path $tmp -Directory | Select-Object -First 1
if ($inner) { Copy-Item (Join-Path $inner.FullName "*") $Dest -Recurse -Force }
else        { Copy-Item (Join-Path $tmp "*")          $Dest -Recurse -Force }

# Drop the debugger build; the launcher never uses it and it's ~5 MB.
Remove-Item (Join-Path $Dest "dosbox_with_debugger.exe") -Force -ErrorAction SilentlyContinue

# Clear "downloaded from the internet" marks so SmartScreen stays quiet.
Get-ChildItem $Dest -Recurse -Include *.exe, *.dll | Unblock-File -ErrorAction SilentlyContinue

Remove-Item -Recurse -Force $tmp, $zip -ErrorAction SilentlyContinue
Write-Host "DOSBox Staging staged in $Dest" -ForegroundColor Green
