@echo off
setlocal

:: Create .ssh directory if it doesn't exist
if not exist "%USERPROFILE%\.ssh" mkdir "%USERPROFILE%\.ssh"

:: Generate SSH key with empty passphrase
"C:\Program Files\Git\usr\bin\ssh-keygen.exe" -t rsa -b 4096 -C "openclaw-agent@workspace" -f "%USERPROFILE%\.ssh\id_rsa" -N "" -q

echo SSH key generation completed.