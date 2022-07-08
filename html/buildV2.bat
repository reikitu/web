@echo off
chcp 65001 > nul
cd %~dp0 > nul

for %%f in (*.html) do call :main_file %%f
exit /b
:main_file
echo %1
type nul>../%1
for /f "delims=" %%t in (%1) do call :main_container %%t
exit /b

:main_container
echo "%1" | find "include" > nul
if not ERRORLEVEL 1 ( 
  set key=%1
  setlocal enabledelayedexpansion
  set key=!Key:^<^!--include =!
  set key=!key:--^>=!
  echo include !key! it
  for /f "delims=" %%i in (!key!) do (
    echo %%i>>../%%f
  )
  endlocal
) else (
  set dirfix=%%t
  setlocal enabledelayedexpansion
  set dirfix=!dirfix:../=!
  echo !dirfix!>>../%%f
  endlocal
)
exit /b
