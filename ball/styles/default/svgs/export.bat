@echo off
set "AllowExt=.jpg .png .bmp"
for %%a in (%AllowExt%) do (
	forfiles /p ..\ /m *%%a /c "cmd /c DEL @path"
)