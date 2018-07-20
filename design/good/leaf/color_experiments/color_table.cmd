@echo off
set "convert=C:\PROGRAMS\ImageMagick 7.0.8 Portable\convert"
echo %convert%
set file=logo_leaf


"%convert%" %file%.png -format %%c -depth 8 histogram:info:color_table_%file%.png.txt
"%convert%" %file%.icon8.png -format %%c -depth 8 histogram:info:color_table_%file%.icon8.png.txt
"%convert%" %file%.icon.gif -format %%c -depth 8 histogram:info:color_table_%file%.icon.gif.txt

REM [0] - индекс картинки 256х256 
"%convert%" %file%.icon.ico[0] -format %%c -depth 8 histogram:info:color_table_%file%.icon.ico.txt


REM тест результата для разных источников иконки
"%convert%" %file%.icon.gif -alpha on -channel RGBA -define icon:auto-resize=256 %file%.icon_from_gif.ico
"%convert%" %file%.icon.png -alpha on -channel RGBA -define icon:auto-resize=256 %file%.icon_from_png.ico

"%convert%" %file%.icon_from_gif.ico -format %%c -depth 8 histogram:info:color_table_%file%.icon_from_gif.ico.txt
"%convert%" %file%.icon_from_png.ico -format %%c -depth 8 histogram:info:color_table_%file%.icon_from_png.ico.txt

