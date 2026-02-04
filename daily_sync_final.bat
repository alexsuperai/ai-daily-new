@echo off
setlocal enabledelayedexpansion

cd /d "C:\Users\admin\.openclaw\workspace"

REM Add all changes
git add .

REM Capture git status output
for /f %%i in ('git status --porcelain ^| findstr "."') do set "changes=%%i"

if "!changes!"=="" (
    echo No changes found, skipping commit
    echo %date% %time% - No changes, sync skipped >> sync_log.txt
) else (
    echo Changes found, committing...
    git commit -m "Auto-sync: Daily memory update %date% %time%"
    echo Pushing changes to GitHub...
    git push origin master
    if !errorlevel! equ 0 (
        echo Successfully synced to GitHub!
        echo %date% %time% - Sync successful >> sync_log.txt
    ) else (
        echo Push failed, please check network connection or SSH keys
        echo %date% %time% - Sync failed >> sync_log.txt
    )
)

echo Sync operation completed