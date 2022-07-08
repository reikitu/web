@echo off
chcp 65001 > nul
cd %~dp0 > nul

for %%f in (*.html) do call :MainFile %%f
exit /b

:MainFile
echo %1
set mainFileName=%1
type nul>../%mainFileName%
for /f "delims=" %%t in (%mainFileName%) do (
  echo "%%t" | find "include" > nul
  if not ERRORLEVEL 1 (
    set key=%%t
    setlocal enabledelayedexpansion
    set key=!Key:^<^!--include =!
    set key=!key:--^>=!
    call :include_file !key!
    endlocal
  ) else (
  )
)
exit /b

:include_file
echo include %1
for /f "delims=" %%i in (%1) do (
    echo %%i>>../%mainFileName%
)
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
  set dirfix=%1
  setlocal enabledelayedexpansion
  set dirfix=!dirfix:../=!
  echo !dirfix!>>../%%f
  endlocal
)
exit /b
