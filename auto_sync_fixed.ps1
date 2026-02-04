# Auto-sync OpenClaw memory files to GitHub
# This script can be called by Windows Task Scheduler

# Set the working directory to OpenClaw workspace
Set-Location -Path "C:\Users\admin\.openclaw\workspace"

# Add all changes including new files
git add .

# Check if there are any changes to commit
$status = git status --porcelain

if ($status) {
    Write-Host "发现更改，正在提交..."
    
    # Create a commit with timestamp
    git commit -m "Auto-sync: Daily memory update $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')"
    
    # Push changes to GitHub
    Write-Host "正在推送更改到GitHub..."
    git push origin master
    
    if ($LASTEXITCODE -eq 0) {
        Write-Host "成功同步到GitHub!" -ForegroundColor Green
        
        # Log success
        $logEntry = "$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss') - Sync successful`n"
        Add-Content -Path "sync_log.txt" -Value $logEntry
    } else {
        Write-Host "推送失败，请检查网络连接或SSH密钥配置" -ForegroundColor Red
        
        # Log failure
        $logEntry = "$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss') - Sync failed`n"
        Add-Content -Path "sync_log.txt" -Value $logEntry
    }
} else {
    Write-Host "没有发现更改，跳过同步"
    
    # Log skipped
    $logEntry = "$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss') - No changes, sync skipped`n"
    Add-Content -Path "sync_log.txt" -Value $logEntry
}

Write-Host "同步操作完成" -ForegroundColor Cyan