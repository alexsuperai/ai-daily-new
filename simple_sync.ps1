# Auto-sync OpenClaw memory files to GitHub

# Set the working directory to OpenClaw workspace
Set-Location -Path "C:\Users\admin\.openclaw\workspace"

# Add all changes including new files
git add .

# Check if there are any changes to commit
$status = git status --porcelain

if ($status) {
    Write-Host "发现更改，正在提交..."
    git commit -m "Auto-sync: Daily memory update"
    Write-Host "正在推送更改到GitHub..."
    git push origin master
    if ($LASTEXITCODE -eq 0) {
        Write-Host "成功同步到GitHub!"
    } else {
        Write-Host "推送失败"
    }
} else {
    Write-Host "没有发现更改，跳过同步"
}

Write-Host "同步操作完成"