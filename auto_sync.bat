@echo off
echo Running automated sync of OpenClaw memory files...

REM Change to the workspace directory
cd /d "C:\Users\admin\.openclaw\workspace"

REM Add all changes
git add .

REM Check if there are any changes
git status --porcelain > temp_status.txt
set /p status_var=<temp_status.txt

if defined status_var (
    echo 发现更改，正在提交...
    git commit -m "Auto-sync: Daily memory update %date% %time%"
    
    echo 正在推送更改到GitHub...
    git push origin master
    
    if %errorlevel% == 0 (
        echo 成功同步到GitHub!
        echo %date% %time% - Sync successful >> sync_log.txt
    ) else (
        echo 推送失败，请检查网络连接或SSH密钥配置
        echo %date% %time% - Sync failed >> sync_log.txt
    )
) else (
    echo 没有发现更改，跳过同步
    echo %date% %time% - No changes, sync skipped >> sync_log.txt
)

REM Clean up
del temp_status.txt

echo 同步操作完成
pause