# GitHub 同步设置指南

由于当前环境无法处理SSH密钥生成的交互式过程，以下是手动设置GitHub同步的步骤：

## 方法1：使用Personal Access Token (推荐)

1. 在GitHub上创建Personal Access Token：
   - 访问 https://github.com/settings/tokens
   - 点击 "Generate new token"
   - 选择适当的权限（至少需要repo权限）
   - 复制生成的token

2. 使用HTTPS推送（首次推送时会提示输入用户名和token）：
   ```
   git remote set-url origin https://github.com/alexsuperai/saibozhangyu-memory.git
   git push -u origin master
   ```
   当提示用户名时，输入：alexsuperai
   当提示密码时，输入上面生成的Personal Access Token

## 方法2：手动设置SSH密钥

如果要使用SSH方式，请按以下步骤操作：

1. 打开命令提示符或Git Bash
2. 运行以下命令生成SSH密钥：
   ```
   ssh-keygen -t rsa -b 4096 -C "openclaw-agent@workspace"
   ```
   按回车键接受默认文件位置
   按两次回车键设置空密码短语

3. 启动ssh-agent：
   ```
   eval "$(ssh-agent -s)"
   ```

4. 添加SSH密钥到ssh-agent：
   ```
   ssh-add ~/.ssh/id_rsa
   ```

5. 复制SSH公钥：
   ```
   cat ~/.ssh/id_rsa.pub
   ```
   复制输出的内容

6. 在GitHub上添加SSH密钥：
   - 访问 https://github.com/settings/ssh/new
   - 粘贴刚才复制的公钥
   - 点击 "Add SSH Key"

7. 测试SSH连接：
   ```
   ssh -T git@github.com
   ```

8. 设置远程仓库为SSH：
   ```
   git remote set-url origin git@github.com:alexsuperai/saibozhangyu-memory.git
   ```

9. 推送内容：
   ```
   git push -u origin master
   ```

## 自动同步设置

要在以后自动同步更改，可以创建一个简单的脚本：

```bash
#!/bin/bash
# git_sync.sh
cd C:\Users\admin\.openclaw\workspace
git add .
git commit -m "Auto-sync: $(date)"
git push origin master
```

然后可以定期运行此脚本或设置计划任务。