@echo off

cd %~dp0

for %%f in (*.html) do (
  echo %%f
  type nul > ../%%f
  for %%t in (%%f) do (
    echo %%t >> ../%%f
  )
)
