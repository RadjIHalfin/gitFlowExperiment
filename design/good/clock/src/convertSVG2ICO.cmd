@echo off
set "convert=C:\PROGRAMS\ImageMagick 7.0.8 Portable\convert"

set file=logo_clock

REM ѕолучаем высококачественную маску дл€ одной картинки с разными фонами
"%convert%" %file%_orange.svg -colorspace srgb -alpha off %file%_orange.png
"%convert%" %file%_black.svg -colorspace srgb -alpha off %file%_black.png
"%convert%" %file%_white.svg -colorspace srgb -alpha off %file%_white.png

"%convert%" %file%_orange.png %file%_white.png -compose difference -composite png32:%file%_white.diff.png
"%convert%" %file%_orange.png %file%_black.png -compose difference -composite png32:%file%_black.diff.png
"%convert%" %file%_white.diff.png %file%_black.diff.png -compose plus -composite -negate png32:%file%_alpha.png

REM ѕолучаем картинку с прозрачным фоном и чистым краем обреза
"%convert%" %file%_orange.png %file%_alpha.png -alpha off -compose CopyOpacity -composite png32:%file%.png

REM ѕолучаем иконки под разными углами
"%convert%" %file%.png -resize 64x64 -alpha on %file%.icon.png
REM ...крутим

::goto x

"%convert%" %file%.icon.png -distort ScaleRotateTranslate 0 %file%.1.icon.png
"%convert%" %file%.icon.png -distort ScaleRotateTranslate 45 %file%.2.icon.png
"%convert%" %file%.icon.png -distort ScaleRotateTranslate 90 %file%.3.icon.png
"%convert%" %file%.icon.png -distort ScaleRotateTranslate 135 %file%.4.icon.png
"%convert%" %file%.icon.png -distort ScaleRotateTranslate 180 %file%.5.icon.png
"%convert%" %file%.icon.png -distort ScaleRotateTranslate 225 %file%.6.icon.png
"%convert%" %file%.icon.png -distort ScaleRotateTranslate 270 %file%.7.icon.png
"%convert%" %file%.icon.png -distort ScaleRotateTranslate 315 %file%.8.icon.png

REM ...дизеринг дл€ прозрачности на каждом отдельном кадре
"%convert%" %file%.1.icon.png -channel RGBA -separate ( +clone -remap pattern:gray50 ) +swap -combine -transparent-color "#ffffff" %file%.1.icon.gif
"%convert%" %file%.2.icon.png -channel RGBA -separate ( +clone -remap pattern:gray50 ) +swap -combine -transparent-color "#ffffff" %file%.2.icon.gif
"%convert%" %file%.3.icon.png -channel RGBA -separate ( +clone -remap pattern:gray50 ) +swap -combine -transparent-color "#ffffff" %file%.3.icon.gif
"%convert%" %file%.4.icon.png -channel RGBA -separate ( +clone -remap pattern:gray50 ) +swap -combine -transparent-color "#ffffff" %file%.4.icon.gif
"%convert%" %file%.5.icon.png -channel RGBA -separate ( +clone -remap pattern:gray50 ) +swap -combine -transparent-color "#ffffff" %file%.5.icon.gif
"%convert%" %file%.6.icon.png -channel RGBA -separate ( +clone -remap pattern:gray50 ) +swap -combine -transparent-color "#ffffff" %file%.6.icon.gif
"%convert%" %file%.7.icon.png -channel RGBA -separate ( +clone -remap pattern:gray50 ) +swap -combine -transparent-color "#ffffff" %file%.7.icon.gif
"%convert%" %file%.8.icon.png -channel RGBA -separate ( +clone -remap pattern:gray50 ) +swap -combine -transparent-color "#ffffff" %file%.8.icon.gif

REM ...собираем в анимашку
::"%convert%" -delay 15 -loop 0 -dispose previous -transparent-color "#ffffff" *.icon.gif %file%.gif
"%convert%" -loop 0 -dispose previous -transparent-color "#ffffff" ^
	-delay 8 %file%.1.icon.gif ^
	-delay 8 %file%.2.icon.gif ^
	-delay 8 %file%.3.icon.gif ^
	-delay 8 %file%.4.icon.gif ^
	-delay 8 %file%.5.icon.gif ^
	-delay 8 %file%.6.icon.gif ^
	-delay 8 %file%.7.icon.gif ^
	-delay 8 %file%.8.icon.gif ^
	%file%.gif
:x
goto y
::REM јльтернативна€ кркутилка
"%convert%" %file%.icon.png -channel RGBA -separate ( +clone -remap pattern:gray50 ) +swap -combine -transparent-color "#ffffff" %file%.icon.gif
::"%convert%" -dispose previous %file%.icon.gif -duplicate 29 -virtual-pixel none -distort SRT '%%[fx:360*t/n]' -set delay '%%[fx:t==0?240:10]' -loop 0 -transparent-color "#ffffff" %file%.gif
"%convert%" -dispose previous %file%.icon.gif -duplicate 7 -virtual-pixel none -distort SRT '%%[fx:360*t/n]' -set delay 15 -loop 0 -transparent-color "#ffffff" %file%.gif
:y

