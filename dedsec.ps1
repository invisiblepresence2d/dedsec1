# dedsec.ps1 - DedSec Spotify Toolkit
# by InvisiblePresence

# ============================================
# BANNER DEDSEC
# ============================================
Write-Host @"

                                                                      
                                                                   
                             D E D S E C                                
                                                                      
                      Spotify Follado by DedSec       

                      Porgramado Por invisiblepresence

"@ -ForegroundColor Cyan

Write-Host ""
Write-Host "[>] Iniciando intrusión en Spotify..." -ForegroundColor Green
Write-Host ""

# 1. Cerrar Spotify
Write-Host "[1/4] Cerrando Spotify..." -ForegroundColor Yellow
Get-Process "Spotify" -ErrorAction SilentlyContinue | Stop-Process -Force
Start-Sleep -Seconds 1

# 2. Crear directorios
Write-Host "[2/4] Creando directorios DedSec..." -ForegroundColor Yellow
$dedsecDir = "$env:USERPROFILE\.dedsec"
$dedsecBin = "$dedsecDir\bin"
New-Item -ItemType Directory -Force -Path $dedsecBin | Out-Null

# 3. Descargar archivos (usando URLs que funcionan)
Write-Host "[3/4] Descargando componentes DedSec..." -ForegroundColor Yellow

$ProgressPreference = 'SilentlyContinue'

# Descargar Spicetify CLI desde la URL correcta
$zipUrl = "https://github.com/spicetify/cli/releases/download/v2.43.1/spicetify-2.43.1-windows-x64.zip"
$zipPath = "$env:TEMP\dedsec.zip"

try {
    Invoke-WebRequest -Uri $zipUrl -OutFile $zipPath -UseBasicParsing
    Expand-Archive -Path $zipPath -DestinationPath $dedsecBin -Force
    Remove-Item $zipPath -Force
} catch {
    Write-Host "[!] Error al descargar componentes" -ForegroundColor Red
    exit 1
}

# 4. Aplicar cambios
Write-Host "[4/4] Aplicando parches DedSec..." -ForegroundColor Yellow

# Ejecutar el comando sin mostrar nada
& "$dedsecBin\spicetify.exe" apply 2>&1 | Out-Null

# Crear archivo de marca
$brandFile = "$dedsecDir\dedsec_branding.txt"
@"
DEDSEC SPOTIFY TOOLKIT
Comprometido por DedSec
Creado por InvisiblePresence
Fecha: $(Get-Date)
"@ | Out-File -FilePath $brandFile -Encoding UTF8

Write-Host ""
Write-Host "[✓] ¡Spotify ha sido comprometido por DedSec!" -ForegroundColor Green
Write-Host ""

Start-Process "spotify"

Write-Host ""
Write-Host "╔════════════════════════════════════════════════════════╗" -ForegroundColor Cyan
Write-Host "║  📌 Para abrir DedSec Market:                          ║" -ForegroundColor Cyan
Write-Host "║     Haz click en el icono del carrito 🛒              ║" -ForegroundColor White
Write-Host "╚════════════════════════════════════════════════════════╝" -ForegroundColor Cyan
