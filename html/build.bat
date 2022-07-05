@echo off

cd %~dp0

for %%f in (*.html) do (
  echo %%f
  type nul > ../%%f
  for %%t in (%%f) do (
    echo "%%t" | find "include " > nul
    if not ERRORLEVEL 1 (
      echo includeする
    ) else (
      echo %%t >> ../%%f
    )
  )
)
