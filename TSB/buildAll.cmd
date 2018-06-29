@echo off
REM Рекурсивно запускает build.

@if exist build.cmd (call build.cmd)

for /d %%i in (*) do (
   echo build: %%i
)
 
