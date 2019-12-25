@echo off 

if [%1]==[] goto usage

set filepath=
set filename=
set tracefile=

set filepath=%1
for /F "delims=" %%i in (%filepath%) do set filename=%%~nxi 2>NUL

if [%filename%]==[] set filename=%filepath%

set tracefile="%filename%.ttt.run"
echo [codecov] Launching target under Time Travel Tracer: %filepath%

del /Q "%filename%.ttt.run" 2>NUL
del /Q "%filename%.ttt.out" 2>NUL
del /Q "%filename%.ttt.idx" 2>NUL

c:\Windows\System32\tttracer.exe -out %tracefile% %*

echo [codecov] Time Travel Trace: %tracefile%

echo [codecov] Extracting code coverage from trace..

echo .scriptload codecov.js > codecov.windbg
echo !codecov "%filename%" >> codecov.windbg

windbgx -c "$<codecov.windbg" -c "q" %tracefile%

del /Q codecov.windbg 2>NUL

goto end 

:usage
echo codecov.bat [command line]

:end 
