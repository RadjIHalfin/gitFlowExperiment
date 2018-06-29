@rcho off
REM Рекурсивно запускает build.
if exist build.cmd (call build.cmd)

for /d %%i in (*) do (
   if exist %%i\buildAll.cmd (
	   echo run buildAll in %%i of %~dp0
	   pushd . & cd %%i & call buildAll.cmd & popd
   )
)
 
