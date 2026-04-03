# dedsec.ps1 - DedSec Spotify Toolkit
# Creado por InvisiblePresence

Write-Host @"
╔══════════════════════════════════════════════════════════════════════╗
║                                                                      ║
║     ██████╗ ███████╗██████╗ ███████╗███████╗ ██████╗                 ║
║     ██╔══██╗██╔════╝██╔══██╗██╔════╝██╔════╝██╔════╝                 ║
║     ██║  ██║█████╗  ██║  ██║███████╗███████╗██║                      ║
║     ██║  ██║██╔══╝  ██║  ██║╚════██║╚════██║██║                      ║
║     ██████╔╝███████╗██████╔╝███████║███████║╚██████╗                 ║
║     ╚═════╝ ╚══════╝╚═════╝ ╚══════╝╚══════╝ ╚═════╝                 ║
║                                                                      ║
║                           D E D S E C                                ║
║                                                                      ║
║                      Spotify Toolkit by DedSec                       ║
║                                                                      ║
╚══════════════════════════════════════════════════════════════════════╝
"@ -ForegroundColor Cyan

Write-Host "[>] Iniciando intrusión en Spotify..." -ForegroundColor Green
Write-Host ""

# Cerrar Spotify
Write-Host "[1/6] Cerrando Spotify..." -ForegroundColor Yellow
Get-Process "Spotify" -ErrorAction SilentlyContinue | Stop-Process -Force
Start-Sleep -Seconds 1

# Instalar Spicetify (necesario)
Write-Host "[2/6] Instalando núcleo DedSec..." -ForegroundColor Yellow
Set-ExecutionPolicy Unrestricted -Scope CurrentUser -Force
iwr -useb https://raw.githubusercontent.com/spicetify/cli/main/install.ps1 | iex

# Crear carpetas
Write-Host "[3/6] Creando estructura DedSec..." -ForegroundColor Yellow
$dedsecAppDir = "$env:USERPROFILE\.spicetify\CustomApps\dedsec-market"
$extensionsDir = "$env:USERPROFILE\.spicetify\Extensions"
New-Item -ItemType Directory -Force -Path $dedsecAppDir | Out-Null
New-Item -ItemType Directory -Force -Path "$dedsecAppDir\icons" | Out-Null
New-Item -ItemType Directory -Force -Path $extensionsDir | Out-Null

# Descargar archivos del marketplace desde tu GitHub
Write-Host "[4/6] Descargando DedSec Market..." -ForegroundColor Yellow

# manifest.json
$manifestUrl = "https://raw.githubusercontent.com/invisiblepresence/dedsec/main/DedSecMarket/manifest.json"
Invoke-WebRequest -Uri $manifestUrl -OutFile "$dedsecAppDir\manifest.json"

# index.js
$indexUrl = "https://raw.githubusercontent.com/invisiblepresence/dedsec/main/DedSecMarket/index.js"
Invoke-WebRequest -Uri $indexUrl -OutFile "$dedsecAppDir\index.js"

# styles.css
$stylesUrl = "https://raw.githubusercontent.com/invisiblepresence/dedsec/main/DedSecMarket/styles.css"
Invoke-WebRequest -Uri $stylesUrl -OutFile "$dedsecAppDir\styles.css"

# Descargar extensiones
Write-Host "[5/6] Descargando extensiones DedSec..." -ForegroundColor Yellow

$extensions = @(
    "beautiful-lyrics",
    "adblocker", 
    "shuffle-plus",
    "dedsec-banner"
)

foreach ($ext in $extensions) {
    $extUrl = "https://raw.githubusercontent.com/invisiblepresence/dedsec/main/extensions/$ext.js"
    Invoke-WebRequest -Uri $extUrl -OutFile "$extensionsDir\$ext.js"
    Write-Host "    ✓ $ext.js" -ForegroundColor Green
}

# Configurar Spicetify
Write-Host "[6/6] Configurando DedSec en Spotify..." -ForegroundColor Yellow
$configFile = "$env:USERPROFILE\.spicetify\config.ini"
$configContent = Get-Content $configFile -Raw
if ($configContent -notmatch "custom_apps") {
    Add-Content $configFile "`ncustom_apps = dedsec-market"
}

# Aplicar cambios
spicetify apply

Write-Host ""
Write-Host "[✓] ¡Spotify ha sido comprometido por DedSec!" -ForegroundColor Green
Write-Host "[✓] Toolkit creado por InvisiblePresence" -ForegroundColor Green
Write-Host ""
Write-Host "[!] Abriendo Spotify..." -ForegroundColor Yellow
Start-Process "spotify"

Write-Host ""
Write-Host "╔════════════════════════════════════════════════════════╗" -ForegroundColor Cyan
Write-Host "║  📌 Para abrir DedSec Market:                          ║" -ForegroundColor Cyan
Write-Host "║     Haz click en el icono del carrito 🛒              ║" -ForegroundColor White
Write-Host "║                                                       ║" -ForegroundColor White
Write-Host "║  📌 Comandos útiles:                                  ║" -ForegroundColor Cyan
Write-Host "║     spicetify apply    → Aplicar cambios              ║" -ForegroundColor White
Write-Host "║     spicetify backup   → Hacer backup                 ║" -ForegroundColor White
Write-Host "╚════════════════════════════════════════════════════════╝" -ForegroundColor Cyan