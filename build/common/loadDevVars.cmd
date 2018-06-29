@echo off
REM ����� ����������� ��������, ��� ������������ ��������� ������������ ���������� ���������.
REM ���� ������, �� �������� ������ ������.
REM ��� �� ����������� ���������� ��������� ��� ������������ Visual Studio.


REM ������� ���� ���������� ��� ���������
if not "%VisualStudioVersion%"=="" exit /b

REM ��������� ����� � ���� ��� ������� � Far.
cls & echo.


if NOT EXIST %USERPROFILE%\userDevVars.cmd goto errorNoUserVars

call %USERPROFILE%\userDevVars.cmd 

if "%VS_TOOLS_ROOT%"=="" goto errorNoUserVars
if "%DEV_TOOLS_ROOT%"=="" goto errorNoUserVars

::echo VS_TOOLS_ROOT=%VS_TOOLS_ROOT%
::echo DEV_TOOLS_ROOT=%DEV_TOOLS_ROOT%
::echo User variables sucessfully loaded

PATH=%DEV_TOOLS_ROOT%;%PATH%

if NOT EXIST "%VS_TOOLS_ROOT%\vsdevcmd.bat" goto errorNoVsDevCmd.bat
call "%VS_TOOLS_ROOT%\vsdevcmd.bat"

exit /b 0
goto :eof


:errorNoUserVars
echo ERROR:  Development user environvent variables not found.
echo         See file: userDevVars.cmd.example
echo.
echo ������: ���������������� ���������� ��������� �� �������
echo         ������ ����: userDevVars.cmd.example
echo.
echo ������: ���짮��⥫�᪨� ��६���� ���㦥��� �� �������
echo         ����� 䠩�: userDevVars.cmd.example
echo.
echo ОШИБКА: Пользовательские переменные окружения не найдены
echo         Смотри файл: userDevVars.cmd.example

exit /b 1

:errorNoVsDevCmd.bat
echo ERROR:  File VsDevCmd.bat not found in VisualStudio tools.
echo.
echo ������: ���� VsDevCmd.bat �� ������ � ������������ VisualStudio.
echo.
echo ������: ���� VsDevCmd.bat �� ������ � �����㬥��� VisualStudio.
echo.
echo ОШИБКА: Файл VsDevCmd.bat не найден в инструментах VisualStudio.

exit /b 1