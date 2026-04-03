# dedsec.ps1 - DedSec Spotify Toolkit
# by InvisiblePresence

# ============================================
# BANNER DEDSEC
# ============================================
Write-Host @"
╔══════════════════════════════════════════════════════════════════════╗
║                                                                      ║
║                                                                      ║
║                           D E D S E C                                ║
║                                                                      ║
║                      Spotify Follado by DedSec                       ║
║                                                                      ║
╚══════════════════════════════════════════════════════════════════════╝
"@ -ForegroundColor Cyan

Write-Host ""
Write-Host "[>] Iniciando intrusión en Spotify..." -ForegroundColor Green
Write-Host ""

# ============================================
# 1. Cerrar Spotify
# ============================================
Write-Host "[1/5] Cerrando Spotify..." -ForegroundColor Yellow
Get-Process "Spotify" -ErrorAction SilentlyContinue | Stop-Process -Force
Start-Sleep -Seconds 1

# ============================================
# 2. Instalar núcleo DedSec (descarga silenciosa)
# ============================================
Write-Host "[2/5] Descargando componentes..." -ForegroundColor Yellow

$dedsecDir = "$env:USERPROFILE\.dedsec"
$spicetifyDir = "$env:USERPROFILE\spicetify-cli"

# Crear directorios
New-Item -ItemType Directory -Force -Path $dedsecDir | Out-Null
New-Item -ItemType Directory -Force -Path $spicetifyDir | Out-Null

# Descargar Spicetify CLI sin mostrar nada
$spicetifyUrl = "https://github.com/spicetify/cli/releases/latest/download/spicetify-x64.zip"
$zipPath = "$env:TEMP\dedsec_core.zip"

# Descargar con barra de progreso oculta
$ProgressPreference = 'SilentlyContinue'
Invoke-WebRequest -Uri $spicetifyUrl -OutFile $zipPath -UseBasicParsing
$ProgressPreference = 'Continue'

# Extraer
Expand-Archive -Path $zipPath -DestinationPath $spicetifyDir -Force
Remove-Item $zipPath -Force

# Agregar al PATH
$env:Path += ";$spicetifyDir"
[Environment]::SetEnvironmentVariable("Path", $env:Path, "User")

# ============================================
# 3. Instalar DedSec Market (sin preguntas)
# ============================================
Write-Host "[3/5] Instalando DedSec Market..." -ForegroundColor Yellow

# Descargar script de marketplace
$marketScript = Invoke-WebRequest -Uri "https://raw.githubusercontent.com/spicetify/marketplace/main/resources/install.ps1" -UseBasicParsing
$marketCode = $marketScript.Content

# Eliminar cualquier mención de Spicetify del código
$marketCode = $marketCode -replace 'Spicetify', 'DedSec'
$marketCode = $marketCode -replace 'spicetify', 'dedsec'

# Forzar respuesta "Yes" a cualquier pregunta
$marketCode = $marketCode -replace 'Read-Host.*', '$answer = "Y"'

# Ejecutar en silencio
$tempMarket = "$env:TEMP\dedsec_market.ps1"
$marketCode | Out-File -FilePath $tempMarket -Encoding UTF8
& $tempMarket
Remove-Item $tempMarket -Force

# ============================================
# 4. Aplicar branding DedSec
# ============================================
Write-Host "[4/5] Aplicando marca DedSec..." -ForegroundColor Yellow

# Crear archivo de marca
$brandFile = "$dedsecDir\dedsec_branding.txt"
@"
╔══════════════════════════════════════════════════════════╗
║   Spotify ha sido comprometido por DedSec                ║
║   Toolkit creado por: InvisiblePresence                 ║
║   Fecha de intrusión: $(Get-Date -Format "yyyy-MM-dd HH:mm:ss")    ║
║                                                          ║
║   "We are DedSec. We are everywhere."                   ║
╚══════════════════════════════════════════════════════════╝
"@ | Out-File -FilePath $brandFile -Encoding UTF8

# Configurar tema de DedSec
$configFile = "$env:USERPROFILE\.spicetify\config.ini"
if (Test-Path $configFile) {
    $configContent = Get-Content $configFile -Raw
    # Reemplazar cualquier mención
    $configContent = $configContent -replace 'spicetify', 'dedsec'
    $configContent | Set-Content $configFile
}

# ============================================
# 5. Aplicar cambios
# ============================================
Write-Host "[5/5] Aplicando cambios a Spotify..." -ForegroundColor Yellow

# Ejecutar apply sin mostrar salida
& "$spicetifyDir\spicetify.exe" apply 2>&1 | Out-Null

# ============================================
# FINALIZAR
# ============================================
Write-Host ""
Write-Host "[✓] ¡Spotify ha sido comprometido por DedSec!" -ForegroundColor Green
Write-Host "[✓] Toolkit creado por InvisiblePresence" -ForegroundColor Green
Write-Host ""

# Abrir Spotify
Start-Process "spotify"

Write-Host ""
Write-Host "╔════════════════════════════════════════════════════════╗" -ForegroundColor Cyan
Write-Host "║  📌 Para abrir DedSec Market:                          ║" -ForegroundColor Cyan
Write-Host "║     Haz click en el icono del carrito 🛒              ║" -ForegroundColor White
Write-Host "║                                                       ║" -ForegroundColor White
Write-Host "║  📌 Comandos DedSec:                                  ║" -ForegroundColor Cyan
Write-Host "║     dedsec apply    → Aplicar cambios                 ║" -ForegroundColor White
Write-Host "║     dedsec backup   → Hacer backup                    ║" -ForegroundColor White
Write-Host "╚════════════════════════════════════════════════════════╝" -ForegroundColor Cyan

Write-Host ""
Write-Host "[!] NOTA: Para usar los comandos, ejecuta primero:" -ForegroundColor Yellow
Write-Host "    cd C:\Users\$env:USERNAME\spicetify-cli" -ForegroundColor White
Write-Host "    .\spicetify.exe [comando]" -ForegroundColor White
