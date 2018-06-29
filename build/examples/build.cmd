@echo off
call repoRoot.cmd || (echo. & echo File repoRoot.cmd not found in %~dp0 & exit 1)
call %REPO_ROOT%\build\common\loadDevVars.cmd || exit 1

REM Сохраняем переменные, которые были до нас, чтоб не попортить. В конце файла восстановим их.
REM Включаем отложенную развертку переменных. Это позволит более гибко работать с переменными в цикле.
setlocal EnableDelayedExpansion

REM Найдем дефолтный файл солюшена.
REM Этот файл солюшена должен иметь то же имя, что и директория.
set solutionFile=
for /f "tokens=*" %%G in ('dir /b *.sln') do (
	set slnDirName=%%G
	set slnDirName=!slnDirName:~0,-4!
	if exist "..\!slnDirName!\%%G" (set solutionFile=..\!slnDirName!\%%G)
)
REM Молча выходи если не нашли файла солюшна одноименного с директорией
REM Лишние сообщения при массовом билде помешают
if "%solutionFile%"=="" exit /b


REM наконец-то билдим
echo Build solution: %solutionFile%
REM ||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
REM ********************************************************************************************************


set Configuration=Debug
if "%1"=="" set Configuration %1

MSBuild %solutionFile% /p:Configuration=%Configuration%



REM ********************************************************************************************************
REM ||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
REM восстанавливаем за собой переменные, так как этот скрипт может быть частью большого процесса
endlocal 
