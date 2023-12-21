Write-Host "
█░█░█ █ █▄░█ █▀▄ █▀█ █░█░█ █▀  ▀█▀ █▀▀ █▀█ █▀▄▀█ █ █▄░█ ▄▀█ █░░
▀▄▀▄▀ █ █░▀█ █▄▀ █▄█ ▀▄▀▄▀ ▄█  ░█░ ██▄ █▀▄ █░▀░█ █ █░▀█ █▀█ █▄▄ "
Write-Host -ForegroundColor Blue "👨‍💻Creating Windows Terminal directory..."
# Check if the folder already exists
if (-not (Test-Path ~\Appdata\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\)) {
    # Create Windows terminal directory
    Write-Host -ForegroundColor Yellow " ⚠️ Windows terminal directory not found.."
    Write-Host -ForegroundColor Blue " Creating directory..."
    mkdir ~\Appdata\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\

    if ($?) {
        Write-Host -ForegroundColor Green " ✅ Success!"
        Write-Host -ForegroundColor Blue " Restoring settings..."

        # Restore settings
        Copy-Item -Recurse -Force .\conf\terminal\settings.json ~\Appdata\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\

        if ($?) {
            Write-Host -ForegroundColor Green " ✅ Success!"
        } else {
            Write-Host -ForegroundColor Red " ❌ Couldn't copy Windows Terminal settings. 📖 Read 👆"
        }
    } else {
        Write-Host -ForegroundColor Red " ❌ Couldn't create Windows terminal settings directory. 📖 Read 👆"
    }
} else {
    Write-Host -ForegroundColor Yellow " ⚠️ Directory already exists. Skipping creation."
    Write-Host -ForegroundColor Blue " Restoring settings..."

    # Restore settings
    Copy-Item -Recurse -Force .\conf\terminal\settings.json ~\Appdata\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\

    if ($?) {
        Write-Host -ForegroundColor Green " ✅ Success!"
    } else {
        Write-Host -ForegroundColor Red " ❌ Couldn't copy Windows Terminal settings. 📖 Read 👆"
    }
}


Write-Host "
█▀█ █▀█ █░█░█ █▀▀ █▀█ █▀ █░█ █▀▀ █░░ █░░
█▀▀ █▄█ ▀▄▀▄▀ ██▄ █▀▄ ▄█ █▀█ ██▄ █▄▄ █▄▄ "
if (-not (Test-Path ~\Documents\PowerShell\)) {
    Write-Host -ForegroundColor Yellow " ⚠️ PowerShell directory not found.."
    Write-Host -ForegroundColor Blue " Creating directory..."
    mkdir ~\Documents\PowerShell\
    if ($?) {
        Write-Host -ForegroundColor Green " ✅ Success!"
        Write-Host -ForegroundColor Blue " Restoring profile..."
        Copy-Item -Recurse -Force .\conf\PowerShell\* ~\Documents\PowerShell\
        if ($?) {
            Write-Host -ForegroundColor Green " ✅ Success!"
        } else {
            Write-Host -ForegroundColor Red " ❌ Couldn't restore PowerShell profile. 📖 Read 👆"
        }
    } else { 
        Write-Host -ForegroundColor Red " ❌ Couldn't create PowerShell profile directory. 📖 Read 👆"
    }
} else {
    Write-Host -ForegroundColor Yellow " ⚠️ Directory already exists. Skipping creation."
    Write-Host -ForegroundColor Blue " Restoring profile..."
    Copy-Item -Recurse -Force .\conf\PowerShell\* ~\Documents\PowerShell\
    if ($?) {
        Write-Host -ForegroundColor Green " ✅ Success!"
        Write-Host -ForegroundColor Blue " Restoring oh-my-posh themes conf..."
        Copy-Item -Recurse -Force .\conf\oh-my-posh\themes\* $env:POSH_THEMES_PATH\
        if ($?) {
            Write-Host -ForegroundColor Green " ✅ Success!"
        } else {
            Write-Host -ForegroundColor Red " ❌ Couldn't restore oh-my-posh theme. 📖 Read 👆"
        }
    } else {
        Write-Host -ForegroundColor Red " ❌ Couldn't restore PowerShell profile. 📖 Read 👆"
        Write-Host -ForegroundColor Yellow " ⚠️ Skipping oh-my-posh themes conf..."
    }
}

Write-Host "
▄▀█ █░█ █▄▀
█▀█ █▀█ █░█ "

# Todo 
# fix!: elevation

if (-not (Test-Path ~\Documents\AHK\)) {
    Write-Host -ForegroundColor Yellow " ⚠️ AHK directory not found.."
    Write-Host -ForegroundColor Blue " Creating directory..."
    mkdir ~\Documents\AHK\

    if ($?) {
        Write-Host -ForegroundColor Blue " Restoring AHK to startup..."
        Copy-Item -Recurse -Force ".\conf\AHK\hotkey.ahk" ~\Documents\AHK\

        if ($?) {
            Write-Host -ForegroundColor Green " ✅ Success!"
        }
    }
} else {
    Write-Host -ForegroundColor Yellow " ⚠️ Directory already exists. Skipping creation."
    Write-Host -ForegroundColor Blue " Restoring settings..."

    Copy-Item -Recurse -Force ".\conf\terminal\settings.json" ~\Documents\AHK\

    if ($?) {
        Write-Host -ForegroundColor Green " ✅ Success!"
    }
}


Write-Host "
▀█▀ ▄▀█ █▀ █▄▀  █▀ █▀▀ █░█ █▀▀ █▀▄ █░█ █░░ █▀▀ █▀█
░█░ █▀█ ▄█ █░█  ▄█ █▄▄ █▀█ ██▄ █▄▀ █▄█ █▄▄ ██▄ █▀▄ "
if ($?) {
    $openTaskScheduler = Read-Host -Prompt "Do you want to open Task Scheduler? (Y/n)"
    if (-not $openTaskScheduler) { $openTaskScheduler = 'Y' }

    if ($openTaskScheduler -eq 'Y' -or $openTaskScheduler -eq 'y') {
        Write-Host -ForegroundColor Blue "Opening Task Scheduler..."
        Write-Host -ForegroundColor Yellow "`n`nHOW: Click Action > Import Task"
        Write-Host -ForegroundColor Yellow "HOW: Import from <repoDir>\conf\task-scheduler\<filename>.xml`n`n"
        taskschd.msc
    }
}
