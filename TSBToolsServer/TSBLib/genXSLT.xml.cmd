SET FILE_DIR=.\Program\CommandLine
::msxsl.cmd %FILE_DIR%\ParametersSchema.xml %FILE_DIR%\ParametersSchema.xslt -o %FILE_DIR%\ParametersSchema_xslt.xml
msxsl.cmd %FILE_DIR%\ParametersSchema.xml %FILE_DIR%\ParametersSchema.xslt -o %FILE_DIR%\ParametersSchema_xslt.txt commandName=help
