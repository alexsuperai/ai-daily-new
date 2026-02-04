# daily_sync.ps1
# 设置工作目录
Set-Location -Path "C:\Users\admin\.openclaw\workspace"

# 添加所有更改
git add .

# 检查是否有暂存的更改
$hasChanges = git diff --cached --quiet
if ($LASTEXITCODE -ne 0) {
    Write-Host "发现更改，正在提交..."
    git commit -m "Auto-sync: Daily memory update $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')"
    
    Write-Host "正在推送更改到GitHub..."
    git push origin master
    
    if ($LASTEXITCODE -eq 0) {
        Write-Host "成功同步到GitHub!"
    } else {
        Write-Host "推送出错，请检查网络连接或SSH密钥配置"
    }
} else {
    Write-Host "没有发现更改，跳过提交"
}

Write-Host "同步操作完成"