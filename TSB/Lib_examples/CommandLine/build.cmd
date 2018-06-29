@echo off
call repoRoot.cmd || (echo. & echo File repoRoot.cmd not found in %~dp0 & exit 1)
call %REPO_ROOT%\build\common\loadDevVars.cmd || exit 1

REM ��������� ����������, ������� ���� �� ���, ���� �� ���������. � ����� ����� ����������� ��.
REM �������� ���������� ��������� ����������. ��� �������� ����� ����� �������� � ����������� � �����.
setlocal EnableDelayedExpansion

REM ������ ��������� ���� ��������.
REM ���� ���� �������� ������ ����� �� �� ���, ��� � ����������.
set solutionFile=
for /f "tokens=*" %%G in ('dir /b *.sln') do (
	set slnDirName=%%G
	set slnDirName=!slnDirName:~0,-4!
	if exist "..\!slnDirName!\%%G" (set solutionFile=..\!slnDirName!\%%G)
)
REM ����� ������ ���� �� ����� ����� ������� ������������ � �����������
REM ������ ��������� ��� �������� ����� ��������
if "%solutionFile%"=="" exit /b


REM �������-�� ������
echo Build solution: %solutionFile%
REM ||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
REM ********************************************************************************************************


set Configuration=Debug
if "%1"=="" set Configuration %1

MSBuild %solutionFile% /p:Configuration=%Configuration%



REM ********************************************************************************************************
REM ||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
REM ��������������� �� ����� ����������, ��� ��� ���� ������ ����� ���� ������ �������� ��������
endlocal 
