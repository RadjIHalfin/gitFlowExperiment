@echo off
REM Здесь выполняется проверка, что пользователь установил персональные переменные окружения.
REM Если ошибка, то командна вернет ошибку.
REM Так же загружаются переменные окружения для инструментов Visual Studio.


REM Выходим если переменные уже загружены
if not "%VisualStudioVersion%"=="" exit /b

REM подчистим экран и фикс для красоты в Far.
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
echo ОШИБКА: Пользовательские переменные окружения не найдены
echo         Смотри файл: userDevVars.cmd.example
echo.
echo Ћ€ЃЉЂ: Џ®«м§®ў вҐ«мбЄЁҐ ЇҐаҐ¬Ґ­­лҐ ®Єаг¦Ґ­Ёп ­Ґ ­ ©¤Ґ­л
echo         ‘¬®ваЁ д ©«: userDevVars.cmd.example
echo.
echo РћРЁРР‘РљРђ: РџРѕР»СЊР·РѕРІР°С‚РµР»СЊСЃРєРёРµ РїРµСЂРµРјРµРЅРЅС‹Рµ РѕРєСЂСѓР¶РµРЅРёСЏ РЅРµ РЅР°Р№РґРµРЅС‹
echo         РЎРјРѕС‚СЂРё С„Р°Р№Р»: userDevVars.cmd.example

exit /b 1

:errorNoVsDevCmd.bat
echo ERROR:  File VsDevCmd.bat not found in VisualStudio tools.
echo.
echo ОШИБКА: Файл VsDevCmd.bat не найден в инструментах VisualStudio.
echo.
echo Ћ€ЃЉЂ: ” ©« VsDevCmd.bat ­Ґ ­ ©¤Ґ­ ў Ё­бваг¬Ґ­в е VisualStudio.
echo.
echo РћРЁРР‘РљРђ: Р¤Р°Р№Р» VsDevCmd.bat РЅРµ РЅР°Р№РґРµРЅ РІ РёРЅСЃС‚СЂСѓРјРµРЅС‚Р°С… VisualStudio.

exit /b 1