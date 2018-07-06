@echo off
set "convert=C:\PROGRAMS\ImageMagick 7.0.8 Portable\convert"

set file=logo_leaf

REM �������� ������������������ ����� ��� ����� �������� � ������� ������
"%convert%" %file%_orange.svg -colorspace srgb -alpha off %file%_orange.png
"%convert%" %file%_black.svg -colorspace srgb -alpha off %file%_black.png
"%convert%" %file%_white.svg -colorspace srgb -alpha off %file%_white.png

"%convert%" %file%_orange.png %file%_white.png -compose difference -composite png32:%file%_white.diff.png
"%convert%" %file%_orange.png %file%_black.png -compose difference -composite png32:%file%_black.diff.png
"%convert%" %file%_white.diff.png %file%_black.diff.png -compose plus -composite -negate png32:%file%_alpha.png

REM �������� �������� � ���������� ����� � ������ ����� ������
"%convert%" %file%_orange.png %file%_alpha.png -alpha off -compose CopyOpacity -composite png32:%file%.png

REM �������� ����� � � ������ �������� 
"%convert%" %file%.png -resize 256x256 -alpha on %file%.icon.png
"%convert%" %file%.icon.png -transparent-color "#ffffff" %file%.icon.gif

REM ����������� ������ �������� ��� ������ � ��� ������� (�� 256) ������� ����� � ������ ����� �����
REM ���������������� ������ �������� �� ����������. ������� �������� � ���������� �����.
"%convert%" -density 384 %file%.png -colors 256 -alpha on png8:%file%.icon8.png
REM ����� -alpha on -channel RGBA ����������� ��� ��������� ���������� ������
"%convert%" %file%.icon8.png -alpha on -channel RGBA -define icon:auto-resize=256,128,64,48,32,16 %file%.icon.ico


::"%convert%" %file%.ico.png -transparent "#ffffff" %file%.ico
::"%convert%" %file%.ico.png -alpha off -fill 0 -opaque "#ffffff" %file%.ico


