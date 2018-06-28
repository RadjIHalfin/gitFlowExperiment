goto eof
SET FILE_DIR=.\Program\CommandLine
::xsd.cmd %FILE_DIR%\ParametersSchema.xml /outputdir:%FILE_DIR%
xsd.cmd %FILE_DIR%\ParametersSchema_bak.xml /outputdir:%FILE_DIR%