@echo off
REM –екурсивно ищет корень решени€ и сохран€ет его в SOLUTION_ROOT
if exist ..\solutionRoot.cmd (pushd . & cd .. & call solutionRoot.cmd & popd & exit /b)
set SOLUTION_ROOT=%~dp0
set SOLUTION_ROOT=%SOLUTION_ROOT:~0,-1%