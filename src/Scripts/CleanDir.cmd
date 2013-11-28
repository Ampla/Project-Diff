set directory=%1

if !!%directory%!! == !!!! goto end

if EXIST %directory% goto directory_exists

echo == Creating %directory%
mkdir %directory%

:directory_exists

del %directory%\*.* /S /Q



:end
