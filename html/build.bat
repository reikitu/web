@echo off
cd %~dp0

setlocal enabledelayedexpansion
for %%f in (*.html) do (
  echo %%f
  type nul > ../%%f
  for /f "delims=" %%t in (%%f) do (
    echo "%%t" | find "include" > nul
    if not ERRORLEVEL 1 ( 
      set key=%%t
      set key=!Key:*include(=!
      set key=!key:^);*=!
      echo include !key!
      type !key! >> ../%%f
rem      for /f "delims=" %%i in (!key!) do (
rem        echo %%i >> ../%%f
rem      )
    ) else (
      echo %%t >> ../%%f
    )
  )
)
endlocal
