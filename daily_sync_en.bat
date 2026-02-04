@echo off
setlocal

cd /d "C:\Users\admin\.openclaw\workspace"

REM Check for changes
git add .

REM Check if there are any files to commit
git status --porcelain > temp_status.txt
set /p status_var=<temp_status.txt

if "%status_var%"=="" (
    REM No changes detected
    echo No changes found, skipping commit
    echo %date% %time% - No changes, sync skipped >> sync_log.txt
) else (
    echo Changes found, committing...
    git commit -m "Auto-sync: Daily memory update %date% %time%"
    echo Pushing changes to GitHub...
    git push origin master
    if errorlevel 1 (
        echo Push failed, please check network connection or SSH keys
        echo %date% %time% - Sync failed >> sync_log.txt
    ) else (
        echo Successfully synced to GitHub!
        echo %date% %time% - Sync successful >> sync_log.txt
    )
)

REM Cleanup
if exist temp_status.txt del temp_status.txt

echo Sync operation completed