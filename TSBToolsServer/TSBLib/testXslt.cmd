SET FILE_DIR=.\Program\CommandLine
msxsl.cmd %FILE_DIR%\ParametersSchema.xml %FILE_DIR%\ParametersSchema.xslt -o .\tmp\xsltOut.txt commandName=help
