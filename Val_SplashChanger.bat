@echo off
title VAL SplashChanger
chcp 65001>nul

echo    _____       __           __        ________                               
echo   / ___/____  / /___ ______/ /_      / ____/ /_  ____ _____  ____ ____  _____
echo   \__ \/ __ \/ / __ `/ ___/ __ \    / /   / __ \/ __ `/ __ \/ __ `/ _ \/ ___/
echo  ___/ / /_/ / / /_/ (__  ) / / /   / /___/ / / / /_/ / / / / /_/ /  __/ /    
echo /____/ .___/_/\__,_/____/_/ /_/    \____/_/ /_/\__,_/_/ /_/\__, /\___/_/     
echo     /_/                                                   /____/             
echo.
echo ==================================================================================
echo  SplashChanger 需要管理员权限方能运行。

echo  这是为了避免权限问题而不得不做的请求；

echo  同时，请不要从非 Github 渠道下载 SplashChanger ，因为这样做可能会对您的电脑造成危害。

echo.

echo    - https://github.com/rabvat/VAL-SplashChanger/

echo.

:admincheck
net session >nul 2>&1
if %errorlevel% neq 0 (
    PowerShell -Command "Start-Process '%~dpnx0' -Verb RunAs"
    exit /b
)



set /p path=<"%TEMP%\VAL_PATH.txt"
cls
REM 设置版本
set valversion1=13
set valversion2=00


echo    _____       __           __        ________                               
echo   / ___/____  / /___ ______/ /_      / ____/ /_  ____ _____  ____ ____  _____
echo   \__ \/ __ \/ / __ `/ ___/ __ \    / /   / __ \/ __ `/ __ \/ __ `/ _ \/ ___/
echo  ___/ / /_/ / / /_/ (__  ) / / /   / /___/ / / / /_/ / / / / /_/ /  __/ /    
echo /____/ .___/_/\__,_/____/_/ /_/    \____/_/ /_/\__,_/_/ /_/\__, /\___/_/     
echo     /_/                                                   /____/         v1.0-github-release
echo.
echo ==================================================================================
echo.
echo    - https://github.com/rabvat/VAL-SplashChanger/
echo.
echo [+]免责声明:
echo [+]本脚本仅用于学习与交流用途,由本脚本造成的任何后果(不仅限于账号封禁),作者概不负责！
echo [+]若使用时遇到问题，请在 Github 上提一个 Issue 。
echo.
echo ==================================================================================
echo.
:powershellcheck
where powershell|find "powershell.exe" >nul&&goto versioncheck||goto nopowershell
:versioncheck
ver|find "10.0." >nul&&goto pathcheck||goto winversion
:pathcheck
if not exist "%temp%\VAL_PATH.txt" goto askpath
REM 双重保险
if not exist "%path%\live\VALORANT.exe" goto askpath
:videocheck
if exist "%~dp0Splash.mp4" goto load
%pspath% -Command "& {Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.MessageBox]::Show('未找到替换所需视频！(与脚本同路径下的Splash.mp4)', '错误');}"
goto videocheck
:load
echo [+]无畏契约安装路径:%path%
echo [+]目标文件:%path%\live\ShooterGame\Content\Movies\Menu\%valversion1%_%valversion2%_Homescreen.mp4
echo [+]加载成功,正在寻找无畏契约进程...
echo.
:findprocess
tasklist|find "VALORANT-Win64-Shipping" >nul&&goto fail||goto next
:next
tasklist|find "AclosGameProxy.exe" >nul&&goto delete||goto next
:delete
echo [+]已找到无畏契约进程,正在删除主页面视频...
echo.
del /f /s /q "%path%\live\ShooterGame\Content\Movies\Menu\%valversion1%_%valversion2%_Homescreen.mp4"
echo.
echo [+]正在替换视频...
echo.
copy "%~dp0Splash.mp4" "%path%\live\ShooterGame\Content\Movies\Menu\"
rename "%path%\live\ShooterGame\Content\Movies\Menu\Splash.mp4" %valversion1%_%valversion2%_Homescreen.mp4
echo.
:done
echo [+]替换完毕,脚本将在10秒内自动退出...(按任意键也可以退出)
timeout 10>nul
exit
:fail
echo [+]替换失败,请在游戏启动之前使用本脚本！
echo [+]脚本将在10秒内自动退出...(按任意键也可以退出)
timeout 10>nuls
exit
:askpath
where powershell > "%TEMP%\POWERSHELL_PATH.txt"
set /p pspath=<"%TEMP%\POWERSHELL_PATH.txt"
del /f /s /q "%temp%\VAL_PATH.txt"
%pspath% -Command "& {Add-Type -AssemblyName Microsoft.VisualBasic; [Microsoft.VisualBasic.Interaction]::InputBox('请输入您的无畏契约安装路径,这在 SplashChanger 的首次启动是必要的。', 'SplashChanger')}" > "%TEMP%\VAL_PATH.txt"
set /p path=<"%TEMP%\VAL_PATH.txt"
if not exist "%path%\live\VALORANT.exe" goto pathfailed
echo [+]已保存路径,下一次启动将不会再次询问无畏契约路径。
echo.
goto load
:pathfailed
%pspath% -Command "& {Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.MessageBox]::Show('无法找到无畏契约执行文件！', '安装路径错误！');}"
goto askpath
:winversion
echo [+]何意味，您的系统版本甚至不是Windows 10/11...连无畏契约都启动不了...
echo [+]脚本将在10秒内自动退出...(按任意键也可以退出)
timeout 10>nul
exit
:nopowershell
set pspath=%systemdrive%\Windows\System32\WindowsPowerShell\v1.0\powershell.exe
echo [+]启动失败！未检测到Powershell！(怎么可能...)
echo [+]脚本将使用默认路径...(%pspath%)
if not exist "%pspath%" goto norealpowershell
echo.
echo [+]已找到默认路径下的Powershell!
echo.
goto versioncheck
:norealpowershell
echo.
echo [+]启动失败！您的电脑未安装Powershell！
echo [+]脚本将在10秒内自动退出...(按任意键也可以退出)
timeout 10>nul
exit

