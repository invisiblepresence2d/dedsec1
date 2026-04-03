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
Write-Host "[1/3] Cerrando Spotify..." -ForegroundColor Yellow
Get-Process "Spotify" -ErrorAction SilentlyContinue | Stop-Process -Force
Start-Sleep -Seconds 1

# 2. Instalar Spicetify (el instalador oficial)
Write-Host "[2/3] Infectando sistema..." -ForegroundColor Yellow
Set-ExecutionPolicy Unrestricted -Scope CurrentUser -Force

# Descargar y ejecutar el instalador de Spicetify
$spicetifyInstaller = Invoke-WebRequest -Uri "https://raw.githubusercontent.com/spicetify/cli/main/install.ps1" -UseBasicParsing
$spicetifyCode = $spicetifyInstaller.Content
$tempSpice = "$env:TEMP\spice_install.ps1"
$spicetifyCode | Out-File -FilePath $tempSpice -Encoding UTF8
& $tempSpice
Remove-Item $tempSpice -Force

# 3. Instalar Marketplace (automáticamente sin preguntas)
Write-Host "[3/3] Instalando DedSec Market..." -ForegroundColor Yellow

# Este es el comando que instala el Marketplace sin preguntar
# Primero aseguramos que spicetify está en el PATH
$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")

# Instalar Marketplace directamente
& spicetify config custom_apps marketplace https://github.com/spicetify/marketplace
& spicetify apply

Write-Host ""
Write-Host "[✓] ¡Spotify ha sido comprometido por DedSec!" -ForegroundColor Green
Write-Host "[✓] Toolkit creado por InvisiblePresence" -ForegroundColor Green
Write-Host ""

Start-Process "spotify"

Write-Host ""
Write-Host "╔════════════════════════════════════════════════════════╗" -ForegroundColor Cyan
Write-Host "║  📌 Para abrir DedSec Market:                          ║" -ForegroundColor Cyan
Write-Host "║     Haz click en el icono del carrito 🛒              ║" -ForegroundColor White
Write-Host "╚════════════════════════════════════════════════════════╝" -ForegroundColor Cyan
