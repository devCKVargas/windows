# Define the path to the packages file
$packagesFilePath = ".\packages.txt"

# Read package names from the file
$packageNames = Get-Content $packagesFilePath | Where-Object { $_ -notmatch '^#' } | ForEach-Object { "`"$_`"" }

#  # Winget (Slow download fix)
#  # open settings using $ winget settings
Write-Host "
█░█░█ █ █▄░█ █▀▀ █▀▀ ▀█▀   █▀▀ █ ▀▄▀
▀▄▀▄▀ █ █░▀█ █▄█ ██▄ ░█░   █▀░ █ █░█
Set wininet as network downloader "

Copy-Item -Recurse -Force ".\conf\winget\settings.json" ~\Appdata\Local\Packages\Microsoft.DesktopAppInstaller_8wekyb3d8bbwe\LocalState\ #fix!: wrong dir

Write-Host -Foreground Green "
+-+-+-+-+-+
|D|o|n|e|!|
+-+-+-+-+-+ "

Write-Host "
█▀▀ █░█ █▀█ █▀▀ █▀█ █░░ ▄▀█ ▀█▀ █▀▀ █▄█
█▄▄ █▀█ █▄█ █▄▄ █▄█ █▄▄ █▀█ ░█░ ██▄ ░█░
Installing chocolatey "

Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

# ===============================================================
$updateChoco = Read-Host -Prompt "Update installed apps? (Y/n)"
if (-not $updateChoco) { $updateChoco = 'Y' }

if ($updateChoco -eq 'Y' -or $updateChoco -eq 'y') {
	Write-Host "
	+-+-+-+-+-+-+-+-+ +-+-+-+-+-+-+-+-+-+-+ +-+-+-+-+
	|U|p|d|a|t|i|n|g| |c|h|o|c|o|l|a|t|e|y| |a|p|p|s|
	+-+-+-+-+-+-+-+-+ +-+-+-+-+-+-+-+-+-+-+ +-+-+-+-+ "
		choco upgrade all -y
} else {
	Write-Host -ForegroundColor Yellow "Skipping updates."
}
	
# ===============================================================
$installChoco = Read-Host -Prompt "Install choco apps? (Y/n)"
if (-not $installChoco) { $installChoco = 'Y' }

if ($installChoco -eq 'Y' -or $installChoco -eq 'y') {
	Write-Host "
	+-+-+-+-+-+-+-+-+-+-+ +-+-+-+-+-+-+-+-+-+-+ +-+-+-+-+
	|I|n|s|t|a|l|l|i|n|g| |c|h|o|c|o|l|a|t|e|y| |a|p|p|s|
	+-+-+-+-+-+-+-+-+-+-+ +-+-+-+-+-+-+-+-+-+-+ +-+-+-+-+ "
		
	choco install winget eartrumpet traffic-monitor nerd-fonts-jetbrainsMono nerd-fonts-arimo nerd-fonts-meslo dotnet-all winfetch openal nilesoft-shell amd-ryzen-chipset realtek-hd-audio-driver -y
		
	Write-Host -Foreground Green "
	+-+-+-+-+-+
	|D|o|n|e|!|
	+-+-+-+-+-+ "
} else {
	Write-Host -ForegroundColor Yellow "Skipping apps."
}
	
# ===============================================================
$clearChocoCache = Read-Host -Prompt "Clear cache? (Y/n)"
if (-not $clearChocoCache) { $clearChocoCache = 'Y' }

if ($clearChocoCache -eq 'Y' -or $clearChocoCache -eq 'y') {
	choco cache remove -y
	Write-Host -Foreground Green "
	+-+-+-+-+-+-+-+-+-+-+ +-+-+-+-+-+ +-+-+-+-+-+-+-+
	|C|h|o|c|o|l|a|t|e|y| |c|a|c|h|e| |c|l|e|a|r|e|d|
	+-+-+-+-+-+-+-+-+-+-+ +-+-+-+-+-+ +-+-+-+-+-+-+-+ "

} else {
	Write-Host -Foreground Yellow "Cache not cleared."
}

Write-Host "
█░█░█ █ █▄░█ █▀▀ █▀▀ ▀█▀
▀▄▀▄▀ █ █░▀█ █▄█ ██▄ ░█░"

$updateWinget = Read-Host -Prompt "Update installed apps? (Y/n)"
if (-not $updateWinget) { $updateWinget = 'Y' }

if ($updateWinget -eq 'Y' -or $updateWinget -eq 'y') {
	Write-Host "
	+-+-+-+-+-+-+-+-+ +-+-+-+-+-+-+ +-+-+-+-+
	|U|p|d|a|t|i|n|g| |w|i|n|g|e|t| |a|p|p|s|
	+-+-+-+-+-+-+-+-+ +-+-+-+-+-+-+ +-+-+-+-+ "
	winget update --all -h --disable-interactivity ## --silent | -h

} else {
	Write-Host -ForegroundColor Yellow "Skipping updates."
}

# Build the winget command
$wingetCommand = "winget install $($packageNames -join ' ') -s winget --accept-package-agreements --accept-source-agreements -h"

# Output the winget command
Write-Host $wingetCommand

# Execute the winget command
Invoke-Expression $wingetCommand


Write-Host "
█▀█ █▀▀ █▀ ▀█▀ █▀█ █▀█ █▀▀   █▀▀ █▀█ █▄░█ █▀▀
█▀▄ ██▄ ▄█ ░█░ █▄█ █▀▄ ██▄   █▄▄ █▄█ █░▀█ █▀░"
$restoreConf = Read-Host -Prompt "Finishing setup. Would you like to restore available configurations? (Y/n)"
if (-not $restoreConf) { $restoreConf = 'Y' }

if ($restoreConf -eq 'Y' -or $restoreConf -eq 'y') {
	Write-Host -ForegroundColor Blue " 🔧 Restoring configs..."
	..\windows\scripts\restore_conf.ps1

	Write-Host -ForegroundColor Green "Setup done!"
} else {
	Write-Host -ForegroundColor Yellow "Skipping configs."
	Write-Host -ForegroundColor Green "Setup done!"
}

