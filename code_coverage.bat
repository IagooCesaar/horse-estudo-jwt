@echo off

CodeCoverage.exe ^
  -e .\Win64\Debug\ValidaPermissaoJWT_Test.exe ^
  -m .\Win64\Debug\ValidaPermissaoJWT_Test.map ^
  -dproj ValidaPermissaoJWT.dproj ^
  -od .\Win64\Debug ^
  -emma ^
  -meta ^
  -xml ^
  -html
  
timeout /t -1