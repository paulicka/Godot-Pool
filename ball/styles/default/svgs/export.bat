@echo off

rem Clean old images
echo Cleaning old files...
forfiles /p ..\ /m "*.png" /c "cmd /c DEL @path"

rem create new images
FOR %%f IN (*.svg) DO (
	echo Exporting %%f
	"C:\Program Files\Inkscape\inkscape.exe" -z "%%~nf.svg" -e "../%%~nf.png"
)