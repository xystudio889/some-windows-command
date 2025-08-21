@ECHO OFF & CD /D "%~DP0"
>NUL 2>&1 reg.exe query "HKU\S-1-5-19" || (
    ECHO SET UAC = CreateObject^("Shell.Application"^) > "%TEMP%\Getadmin.vbs"
    ECHO UAC.ShellExecute "%~f0", "%1", "", "runas", 1 >> "%TEMP%\Getadmin.vbs"
    "%TEMP%\Getadmin.vbs"
    DEL /f /q "%TEMP%\Getadmin.vbs" 2>NUL
    Exit /b
)
title 系统策略禁止这个安装问题修复工具
setlocal EnableDelayedExpansion
echo 删除Installer组策略限制...
reg delete HKLM\SOFTWARE\Policies\Microsoft\Windows\Installer /f
echo.
echo 备份Products注册表...
echo n|reg export HKCR\Installer\Products products备份.reg
echo.
echo 正在检查Products注册表异常...
echo.
for /f %%i in ('reg query HKCR\Installer\Products') do (
reg query %%i\SourceList 1>nul 2>nul
if "!errorlevel!"=="1" (
echo 异常注册表：%%i
echo %%i>>error_reg.txt
reg delete %%i /f 1>nul
)
)
echo.&echo 检查完成！
echo.&pause