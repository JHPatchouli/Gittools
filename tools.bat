@echo off
title Git Tools By JHPatchouli
echo "测试Git是否安装."
goto checkdir
cls
echo "测试Git是否安装.."
cls
echo "测试Git是否安装..."
:ST
echo %version%
set version=%version:git version =%
cls
echo ------------------------------
echo -  Git Tools By JHPatchouli  -
echo -Version：1.0                -
echo -                            -
echo -        Git version         -
echo -%version%            -
echo ------------------------------
echo.
echo 1、clone
echo 2、pull
echo a、auto push
echo e、exit
choice /c 12ae /m "ENTER："
if %errorlevel% EQU 1 goto clone
if %errorlevel% EQU 2 goto pull
if %errorlevel% EQU 3 goto auto
if %errorlevel% EQU 4 goto exit

goto ST
:clone
cls
set /p clone=输入clone链接：
if "%clone%"=="" goto clone
echo 任意键开始clone 
pause
for %%a in (%clone%) do set cloneck=%%~nxa
set cloneck=%cloneck:.git=%
echo 项目%cloneck%
if 	exist %cloneck% (
	echo 克隆失败
	echo 项目文件夹已存在,请检查
	echo 任意键返回主菜单
	pause
	goto ST
) else (
	echo clone.
	cls
	echo clone..
	cls
	echo clone...
)
git clone %clone%
if %errorlevel% == 0 (
　　echo OK，克隆完成
	cd %cloneck%
	dir
	cd ..
	echo 任意键返回主菜单
	pause
	goto ST
) else (
	echo 可能存在网络问题或者其他错误
　　echo 任意键返回主菜单
	pause
	goto ST
)
:pull
cls
echo 你有如下项目
dir
set /p pull=输入项目名称：
if "%pull%"=="" goto pull
if exist %pull% (
	cd %pull%
	echo 开始拉取项目
	git pull
	if %errorlevel% == 0 (
　　echo 拉取完成
	cd ..
	echo 任意键返回菜单
	pause
	goto ST ) else (
	echo 出现错误，请检查Git输出
	cd ..
	echo 任意键返回菜单
	goto ST )
) else (
	echo 你不存在该项目
	echo 任意键返回菜单
	pause
	goto ST )
pause
:auto
cls
echo 你有如下项目
dir
set /p auto=输入项目名称：
if "%auto%"=="" goto auto
if exist %auto% (
	cd %auto%
	pause
	echo 开始auto push
	goto add )

	echo 你不存在该项目
	echo 任意键返回菜单
	pause
	goto ST
:add
git add .	
if %errorlevel% == 0 (
	echo 添加修改OK
	goto commit )
	
	echo 出现错误，请检查Git输出
	cd ..
	echo 任意键重试
	pause
	goto add
:commit
set /p commit=提交信息(默认为空)：
if "%commit%"=="" set commit=push
git commit -m "%commit%"
	
if %errorlevel% == 0 (
	echo 提交分支OK
	goto push )
	
	echo 出现错误，请检查Git输出
	cd ..
	echo 任意键重试
	pause
	goto commit
:push
echo 接下来可能需要Github账号和密码，请确保输入的是该项目的管理者账号信息
git push
if %errorlevel% == 0 (
	echo 上传项目OK
	cd ..
	echo 任意键返回主菜单
	pause
	goto ST )

	echo 出现错误，请检查Git输出
	cd ..
	echo 任意键重试
	pause
	goto push
:checkdir
if exist project (
	echo 存在项目文件夹
	goto check )
md project
goto check


:check
git --version > ./version.log
if %errorlevel% == 0 (
　　echo OK
	for /f "delims=" %%a in (./version.log) do (set version=%%a)
	cd ./project
	goto ST
) else (
	cls
	echo 未安装
　　echo failed
	pause
	goto exit
)

:exit