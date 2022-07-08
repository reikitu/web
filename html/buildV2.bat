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
set isHead=false
set isBody=false
for /f "delims=" %%t in (%1) do (
  echo "%%t" | find "</head>" > nul
  if not ERRORLEVEL 1 (
    set isHead=false
  )
  echo "%%t" | find "</body>" > nul
  if not ERRORLEVEL 1 (
    set isBody=false
  )
  setlocal enabledelayedexpansion
  if !isHrad!==true (
    set head=!head!%%t
  ) else if !isBody!==true (
    set body=!body!%%t
  )
  endlocal
  echo "%%t" | find "<head>" > nul
  if not ERRORLEVEL 1 (
    set isHead=true
  )
  echo "%%t" | find "<body>" > nul
  if not ERRORLEVEL 1 (
    set isBody=true
  )
)
exit /b

:Include
type nul>../%mainFileName%
echo %1>>../%mainFileName%
echo "%%t" | find "<head>" > nul
if not ERRORLEVEL 1 (
  echo %head%>>../%mainFileName%
)
echo "%%t" | find "<body>" > nul
if not ERRORLEVEL 1 (
  echo %body%>>../%mainFileName%
)
exit /b
