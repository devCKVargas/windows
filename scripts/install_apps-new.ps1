# Define the path to the packages file
$packagesFilePath = ".\packages.txt"

# Check if the file exists
if (-not (Test-Path $packagesFilePath -PathType Leaf)) {
    $packagesFilePath = "..\packages.txt"
    exit
}

# Initialize $readingPackages
$readingPackages = $false

# Read package names from the file, starting from the line that contains "## Winget"
$packagesToInstall = Get-Content $packagesFilePath | ForEach-Object {
    if ($_ -match '^## (.+)$' -and $Matches[1].ToLower() -eq 'winget') {
        $readingPackages = $true
        continue
    }

    if ($readingPackages -and $_ -notmatch '^#') {
        $_.Trim()
    }
}

# Build the winget command
if ($null -ne $packagesToInstall) {
    $wingetCommand = "winget install $($packagesToInstall -join ' ') -s winget --accept-package-agreements --accept-source-agreements -h"

    # Output the winget command
    Write-Host $wingetCommand

    # Execute the winget command
    Invoke-Expression $wingetCommand
} else {
    Write-Host "No packages to install."
}

