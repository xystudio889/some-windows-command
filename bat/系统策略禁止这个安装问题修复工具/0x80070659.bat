@ECHO OFF & CD /D "%~DP0"
>NUL 2>&1 reg.exe query "HKU\S-1-5-19" || (
    ECHO SET UAC = CreateObject^("Shell.Application"^) > "%TEMP%\Getadmin.vbs"
    ECHO UAC.ShellExecute "%~f0", "%1", "", "runas", 1 >> "%TEMP%\Getadmin.vbs"
    "%TEMP%\Getadmin.vbs"
    DEL /f /q "%TEMP%\Getadmin.vbs" 2>NUL
    Exit /b
)
title ϵͳ���Խ�ֹ�����װ�����޸�����
setlocal EnableDelayedExpansion
echo ɾ��Installer���������...
reg delete HKLM\SOFTWARE\Policies\Microsoft\Windows\Installer /f
echo.
echo ����Productsע���...
echo n|reg export HKCR\Installer\Products products����.reg
echo.
echo ���ڼ��Productsע����쳣...
echo.
for /f %%i in ('reg query HKCR\Installer\Products') do (
reg query %%i\SourceList 1>nul 2>nul
if "!errorlevel!"=="1" (
echo �쳣ע���%%i
echo %%i>>error_reg.txt
reg delete %%i /f 1>nul
)
)
echo.&echo �����ɣ�
echo.&pause