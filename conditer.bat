@echo off


set systemDir=%~dp0
set problemDir=%~dp0sampleProblem\
set workareaDir=%~dp0workarea\

set PATH=%PATH%;"D:\Contester\compilers\MinGW\bin\"


if not exist "%systemDir%system_make.json" (
    echo Error: system_make.json does not exist
    exit /b 1
)

if not exist "%systemDir%ujs_ci.exe" (
    echo Error: ujs_ci.exe does not exist
    exit /b 1
)

for /d %%i in ("%workareaDir%") do rmdir /s /q "%%i"

rem ----------------------------------------------------------------------------
echo.
<nul set /p msg=Step 1.1: Ensure checker compilability... 

if not exist "%problemDir%checker\source.*" (
    echo FAIL
    echo Error: checker source does not exist
    exit /b 1
)

if not exist "%problemDir%checker\make.json" (
    echo FAIL
    echo Error: checker make.json does not exist
    exit /b 1
)

mkdir %workareaDir%checker
copy %problemDir%checker\*.* %workareaDir%checker\*.* > nul

%systemDir%ujs_ci -sm "%systemDir%system_make.json"       ^
                  -m  "%workareaDir%checker\make.json"    ^
                  -rc "%workareaDir%checker\compile.bat"  ^
                  -rr "%workareaDir%checker\run.bat"

if errorlevel 1 (
    echo FAIL
    echo Error: bad ujs_ci usage
    exit /b 1
)

if errorlevel 2 (
    echo FAIL
    echo Error: there are no appliable compilers
    exit /b 1
)

echo OK



rem ----------------------------------------------------------------------------
echo.
<nul set /p msg=Step 1.2: Compile checker...

cd %workareaDir%checker\

echo. >> compile.bat
echo if  errorlevel 0 ( >> compile.bat
echo echo !!! >> compile.bat
echo exit /b 1 >> compile.bat
echo ) >> compile.bat

pause

call compile.bat
cd %~dp0

if not errorlevel 0 (
    echo FAIL
    echo Error: compilation error
    exit /b 1
)

rem del /q make.json, compile.bat

echo OK

pause
