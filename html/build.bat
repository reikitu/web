@echo off

cd %~dp0

for %%f in (*.html) do (
  echo %%f
  type nul > ../%%f
  for %%t in (%%f) do (
    echo "%%t" | find "include" > nul
    if not ERRORLEVEL 1 (
      set key=%%t
      set key=!Key:*include(=!
      set key=!key:);*=!
      echo include !key!
      for %%i in (!key!) do (
        echo %%i >> ../%%f
      )
    ) else (
      echo %%t >> ../%%f
    )
  )
)
