@echo off
title Git Tools By JHPatchouli
echo "����Git�Ƿ�װ."
goto checkdir
cls
echo "����Git�Ƿ�װ.."
cls
echo "����Git�Ƿ�װ..."
:ST
echo %version%
set version=%version:git version =%
cls
echo ------------------------------
echo -  Git Tools By JHPatchouli  -
echo -Version��1.0                -
echo -                            -
echo -        Git version         -
echo -%version%            -
echo ------------------------------
echo.
echo 1��clone
echo 2��pull
echo a��auto push
echo e��exit
choice /c 12ae /m "ENTER��"
if %errorlevel% EQU 1 goto clone
if %errorlevel% EQU 2 goto pull
if %errorlevel% EQU 3 goto auto
if %errorlevel% EQU 4 goto exit

goto ST
:clone
cls
set /p clone=����clone���ӣ�
if "%clone%"=="" goto clone
echo �������ʼclone 
pause
for %%a in (%clone%) do set cloneck=%%~nxa
set cloneck=%cloneck:.git=%
echo ��Ŀ%cloneck%
if 	exist %cloneck% (
	echo ��¡ʧ��
	echo ��Ŀ�ļ����Ѵ���,����
	echo ������������˵�
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
����echo OK����¡���
	cd %cloneck%
	dir
	cd ..
	echo ������������˵�
	pause
	goto ST
) else (
	echo ���ܴ����������������������
����echo ������������˵�
	pause
	goto ST
)
:pull
cls
echo ����������Ŀ
dir
set /p pull=������Ŀ���ƣ�
if "%pull%"=="" goto pull
if exist %pull% (
	cd %pull%
	echo ��ʼ��ȡ��Ŀ
	git pull
	if %errorlevel% == 0 (
����echo ��ȡ���
	cd ..
	echo ��������ز˵�
	pause
	goto ST ) else (
	echo ���ִ�������Git���
	cd ..
	echo ��������ز˵�
	goto ST )
) else (
	echo �㲻���ڸ���Ŀ
	echo ��������ز˵�
	pause
	goto ST )
pause
:auto
cls
echo ����������Ŀ
dir
set /p auto=������Ŀ���ƣ�
if "%auto%"=="" goto auto
if exist %auto% (
	cd %auto%
	pause
	echo ��ʼauto push
	goto add )

	echo �㲻���ڸ���Ŀ
	echo ��������ز˵�
	pause
	goto ST
:add
git add .	
if %errorlevel% == 0 (
	echo ����޸�OK
	goto commit )
	
	echo ���ִ�������Git���
	cd ..
	echo ���������
	pause
	goto add
:commit
set /p commit=�ύ��Ϣ(Ĭ��Ϊ��)��
if "%commit%"=="" set commit=push
git commit -m "%commit%"
	
if %errorlevel% == 0 (
	echo �ύ��֧OK
	goto push )
	
	echo ���ִ�������Git���
	cd ..
	echo ���������
	pause
	goto commit
:push
echo ������������ҪGithub�˺ź����룬��ȷ��������Ǹ���Ŀ�Ĺ������˺���Ϣ
git push
if %errorlevel% == 0 (
	echo �ϴ���ĿOK
	cd ..
	echo ������������˵�
	pause
	goto ST )

	echo ���ִ�������Git���
	cd ..
	echo ���������
	pause
	goto push
:checkdir
if exist project (
	echo ������Ŀ�ļ���
	goto check )
md project
goto check


:check
git --version > ./version.log
if %errorlevel% == 0 (
����echo OK
	for /f "delims=" %%a in (./version.log) do (set version=%%a)
	cd ./project
	goto ST
) else (
	cls
	echo δ��װ
����echo failed
	pause
	goto exit
)

:exit