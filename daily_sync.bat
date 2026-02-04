@echo off
setlocal

cd /d "C:\Users\admin\.openclaw\workspace"

REM 检查是否有任何更改
git add .

REM 检查是否有任何文件需要提交
git status --porcelain > temp_status.txt
set /p status_var=<temp_status.txt

if "%status_var%"=="" (
    REM 没有任何更改，跳过提交
    echo 没有发现更改，跳过提交
    echo %date% %time% - No changes, sync skipped >> sync_log.txt
) else (
    echo 发现更改，正在提交...
    git commit -m "Auto-sync: Daily memory update %date% %time%"
    echo 正在推送更改到GitHub...
    git push origin master
    if errorlevel 1 (
        echo 推送出错，请检查网络连接或SSH密钥配置
        echo %date% %time% - Sync failed >> sync_log.txt
    ) else (
        echo 成功同步到GitHub!
        echo %date% %time% - Sync successful >> sync_log.txt
    )
)

REM 清理临时文件
if exist temp_status.txt del temp_status.txt

echo 同步操作完成