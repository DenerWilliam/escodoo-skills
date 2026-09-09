# Escodoo Skills Installer for Windows

Write-Host "Installing @escodoo/skills..." -ForegroundColor Cyan

$InstallDir = "$env:USERPROFILE\.escodoo-skills"
$BinDir = "$env:USERPROFILE\AppData\Local\Microsoft\WindowsApps"

# Clone or update the repo
if (Test-Path "$InstallDir\.git") {
    Write-Host "Updating existing installation..." -ForegroundColor Yellow
    Set-Location $InstallDir
    git pull
} else {
    Write-Host "Cloning repository..." -ForegroundColor Yellow
    git clone https://github.com/DenerWilliam/escodoo-skills.git $InstallDir
    Set-Location $InstallDir
}

# Install dependencies and build
Write-Host "Installing dependencies..." -ForegroundColor Yellow
npm install
Write-Host "Building..." -ForegroundColor Yellow
npm run build

# Create a batch file launcher
$BatchFile = "$BinDir\escodoo-skills.cmd"
@"
@echo off
node "%USERPROFILE%\.escodoo-skills\dist\cli.js" %*
"@ | Out-File -FilePath $BatchFile -Encoding ASCII

Write-Host ""
Write-Host "Installation complete!" -ForegroundColor Green
Write-Host ""
Write-Host "To use, run:" -ForegroundColor Yellow
Write-Host "  escodoo-skills opencode"
Write-Host ""
Write-Host "To update later, run this script again." -ForegroundColor Yellow
Write-Host ""
Write-Host "To uninstall, run uninstall.ps1" -ForegroundColor Yellow
