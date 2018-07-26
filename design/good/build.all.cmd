@echo off

set logo_dir=..\logo\img\ 

goto x

call flower\bin\_gen_ico.cmd
call flower_clock\bin\_gen_anim_gif.cmd
call flower_rotate\bin\_gen_anim_gif.cmd
call leaf\bin\_gen_ico.cmd
call leaf_rotate\bin\_gen_anim_gif.cmd

:x

copy flower\out\*.ico %logo_dir% >nul
copy flower_clock\out\*.gif %logo_dir% >nul
copy flower_rotate\out\*.gif %logo_dir% >nul
copy leaf\out\*.ico %logo_dir% >nul
copy leaf_rotate\out\*.gif %logo_dir% >nul
 