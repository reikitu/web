@echo off
chcp 65001 > nul
cd %~dp0 > nul

for %%f in (*.html) do call :MainFile %%f
exit /b

:MainFile
echo %1
set mainFileName=%1
for /f "delims=" %%t in (%mainFileName%) do (
  echo "%%t" | find "include" > nul
  if not ERRORLEVEL 1 (
    set key=%%t
    setlocal enabledelayedexpansion
    set key=!key:^<^!--include =!
    set key=!key:--^>=!
    call :IncludeFile !key!
    endlocal
  ) else (
    set dirFix=%%t
    setlocal enabledelayedexpansion
    set dirFix=!dirFix:../=!
    call :Include !dirFix!
    endlocal
  )
)
exit /b

:IncludeFile
echo include %1
for /f "delims=" %%i in (%1) do (
    echo %%i>>../%mainFileName%
)
exit /b

:Include
type nul>../%mainFileName%
echo %1>>../%mainFileName%
exit /b
