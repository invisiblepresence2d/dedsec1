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

# 2. Configurar PowerShell para ejecutar scripts
Write-Host "[2/4] Configurando permisos..." -ForegroundColor Yellow
Set-ExecutionPolicy Unrestricted -Scope CurrentUser -Force

# 3. Instalar el núcleo (usando el instalador oficial, pero en SILENCIO)
Write-Host "[3/4] Infectando sistema..." -ForegroundColor Yellow

# Descargar el script oficial de instalación de Spicetify
$installerScript = Invoke-WebRequest -Uri "https://raw.githubusercontent.com/spicetify/cli/main/install.ps1" -UseBasicParsing
$scriptContent = $installerScript.Content

# Modificar el script para que sea completamente automático (sin preguntas)
$scriptContent = $scriptContent -replace 'Read-Host.*', '$answer = "Y"'

# Guardar y ejecutar el script modificado en segundo plano, ocultando su salida
$tempScript = "$env:TEMP\dedsec_installer.ps1"
$scriptContent | Out-File -FilePath $tempScript -Encoding UTF8
& $tempScript 2>&1 | Out-Null
Remove-Item $tempScript -Force

# 4. Instalar el Marketplace (también en silencio)
Write-Host "[4/4] Instalando DedSec Market..." -ForegroundColor Yellow

$marketScript = Invoke-WebRequest -Uri "https://raw.githubusercontent.com/spicetify/marketplace/main/resources/install.ps1" -UseBasicParsing
$marketContent = $marketScript.Content
$marketContent = $marketContent -replace 'Read-Host.*', '$answer = "Y"'

$tempMarket = "$env:TEMP\dedsec_market.ps1"
$marketContent | Out-File -FilePath $tempMarket -Encoding UTF8
& $tempMarket 2>&1 | Out-Null
Remove-Item $tempMarket -Force

# Aplicar los cambios
Write-Host ""
Write-Host "[*] Aplicando parches DedSec..." -ForegroundColor Yellow
spicetify apply 2>&1 | Out-Null

Write-Host ""
Write-Host "[✓] ¡Spotify ha sido comprometido por DedSec!" -ForegroundColor Green
Write-Host "[✓] Toolkit creado por InvisiblePresence" -ForegroundColor Green
Write-Host ""

Start-Process "spotify"

Write-Host ""
Write-Host "╔════════════════════════════════════════════════════════╗" -ForegroundColor Cyan
Write-Host "║  📌 Para abrir DedSec Market:                          ║" -ForegroundColor Cyan
Write-Host "║     Haz click en el icono del carrito 🛒              ║" -ForegroundColor White
Write-Host "║                                                       ║" -ForegroundColor White
Write-Host "║  📌 COMANDOS DEDSEC:                                  ║" -ForegroundColor Cyan
Write-Host "║     spicetify apply    → Aplicar cambios              ║" -ForegroundColor White
Write-Host "║     spicetify backup   → Hacer backup                 ║" -ForegroundColor White
Write-Host "╚════════════════════════════════════════════════════════╝" -ForegroundColor Cyan
