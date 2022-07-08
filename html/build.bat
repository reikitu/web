@echo off
chcp 65001 > nul
cd %~dp0 > nul

for %%f in (*.html) do call :MainFile %%f
del head.tmp body.tmp
exit /b

:MainFile
echo %1
type nul>head.tmp
type nul>body.tmp
type nul>../%1
for /f "delims=" %%t in (%1) do (
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
    echo "!dirFix!" | find "</body>" > nul
    if not ERRORLEVEL 1 type body.tmp>>../%1
    echo !dirFix!>>../%1
    echo "!dirFix!" | find "<head>" > nul
    if not ERRORLEVEL 1 type head.tmp>>../%1
    endlocal
    echo|set /p="."
  )
)
echo;
exit /b

:IncludeFile
echo #include %1
for /f "delims=" %%i in (%1) do (
  echo "%%i" | find "</head>" > nul
  if not ERRORLEVEL 1 set isHead=0
  echo "%%i" | find "</body>" > nul
  if not ERRORLEVEL 1 set isBody=0
  setlocal enabledelayedexpansion
  if !isHead! equ 1 echo %%i>>head.tmp
  if !isBody! equ 1 echo %%i>>body.tmp
  endlocal
  echo "%%i" | find "<head>" > nul
  if not ERRORLEVEL 1 set isHead=1
  echo "%%i" | find "<body>" > nul
  if not ERRORLEVEL 1 set isBody=1
)
exit /b
