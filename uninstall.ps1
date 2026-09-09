# Escodoo Skills Uninstaller for Windows

Write-Host "Uninstalling @escodoo/skills..." -ForegroundColor Cyan

$InstallDir = "$env:USERPROFILE\.escodoo-skills"
$BatchFile = "$env:USERPROFILE\AppData\Local\Microsoft\WindowsApps\escodoo-skills.cmd"

# Remove installation directory
if (Test-Path $InstallDir) {
    Remove-Item -Recurse -Force $InstallDir
    Write-Host "Removed $InstallDir" -ForegroundColor Green
}

# Remove launcher
if (Test-Path $BatchFile) {
    Remove-Item -Force $BatchFile
    Write-Host "Removed $BatchFile" -ForegroundColor Green
}

Write-Host ""
Write-Host "Uninstallation complete!" -ForegroundColor Green
