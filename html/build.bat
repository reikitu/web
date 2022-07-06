@echo off
chcp 65001 > nul
cd %~dp0 > nul

for %%f in (*.html) do (
  echo %%f
  type nul > ../%%f
  for /f "delims=" %%t in (%%f) do (
    echo "%%t" | find "include" > nul
    if not ERRORLEVEL 1 ( 
      set key=%%t
      setlocal enabledelayedexpansion
      set key=!Key:^<^!--include =!
      set key=!key:--^>=!
      echo include !key!
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
  )
)