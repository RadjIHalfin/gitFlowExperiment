@echo off
REM Рекурсивно ищет корень репозитория и сохраняет его в REPO_ROOT
if exist ..\repoRoot.cmd (pushd . & cd .. & call repoRoot.cmd & popd & exit /b)
set REPO_ROOT=%~dp0
set REPO_ROOT=%REPO_ROOT:~0,-1%

