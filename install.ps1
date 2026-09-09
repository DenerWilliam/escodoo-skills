# Escodoo Skills Installer for Windows

Write-Host "Installing @escodoo/skills..." -ForegroundColor Cyan

$InstallDir = "$env:USERPROFILE\.escodoo-skills"
$BinDir = "$env:USERPROFILE\AppData\Local\Microsoft\WindowsApps"

Write-Host "Install directory: $InstallDir" -ForegroundColor Gray
Write-Host "Bin directory: $BinDir" -ForegroundColor Gray

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

# Verify files exist
Write-Host ""
Write-Host "Checking installation files..." -ForegroundColor Gray
if (Test-Path "$InstallDir\src\skills") {
    Write-Host "  src/skills: OK" -ForegroundColor Green
    Get-ChildItem "$InstallDir\src\skills"
} else {
    Write-Host "  src/skills: MISSING!" -ForegroundColor Red
}

if (Test-Path "$InstallDir\dist\cli.js") {
    Write-Host "  dist/cli.js: OK" -ForegroundColor Green
} else {
    Write-Host "  dist/cli.js: MISSING!" -ForegroundColor Red
}

# Install dependencies and build
Write-Host ""
Write-Host "Installing dependencies..." -ForegroundColor Yellow
npm install
Write-Host "Building..." -ForegroundColor Yellow
npm run build

# Verify build output
if (Test-Path "$InstallDir\dist\cli.js") {
    Write-Host "Build successful!" -ForegroundColor Green
} else {
    Write-Host "Build FAILED!" -ForegroundColor Red
}

# Create a batch file launcher
Write-Host ""
Write-Host "Creating launcher..." -ForegroundColor Yellow
$BatchFile = "$BinDir\escodoo-skills.cmd"
@"
@echo off
node "%USERPROFILE%\.escodoo-skills\dist\cli.js" %*
"@ | Out-File -FilePath $BatchFile -Encoding ASCII

Write-Host "Batch file created at: $BatchFile" -ForegroundColor Gray

Write-Host ""
Write-Host "Installation complete!" -ForegroundColor Green
Write-Host ""
Write-Host "To use, run:" -ForegroundColor Yellow
Write-Host "  escodoo-skills opencode ."
Write-Host ""
Write-Host "To update later, run this script again." -ForegroundColor Yellow
Write-Host ""
Write-Host "To uninstall, run uninstall.ps1" -ForegroundColor Yellow
