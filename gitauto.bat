@echo off
@chcp 852
set tmp=%~dp0
set workingDirectory=%tmp:~0,-1%
cd /D %workingDirectory%
title gitauto
cls
echo program uruchomiony z: %workingDirectory%
set pulledFromCMD=false
if "%1" EQU "pull" ( goto pulled_from_cmd )
set fileName=*
echo.
echo Chcesz pobra† najnowsze dane z repozytorium   (1)?
echo Czy wysˆa† swoje pliki do niego               (2)?
choice /C 12 /N /M "[1/2]:"

if %ERRORLEVEL% EQU 1 goto pull
if %ERRORLEVEL% EQU 2 goto push_choice

:end
echo.
echo zakoäczono prace
echo.
if pulledFromCMD EQU true ( goto timed_exit )
pause
exit

:timed_exit
ping 127.0.0.1 -n 3 > nul
exit

:pull
echo.
echo pobieram najnowsze wersje plik¢w...
echo.
git pull origin master
goto end

:not_needed
cls
echo Nie ma potrzeby aktualizacji, wszystko aktualne
goto end

:push_choice
echo.
echo Chcesz wysˆa†:
echo WSZYSTKIE pliki kt¢re mog¥ zosta† zaktualizowane   (1)?
echo jeden plik                                         (2)?
echo tylko te oznaczone ju¾ jako do dodania             (3)?
echo ju¾ zapisane commit'y                              (4)?
choice /C 1234 /N /M "[1/2/3/4]:"
if %ERRORLEVEL% EQU 1 goto push_add
if %ERRORLEVEL% EQU 2 goto push_file
if %ERRORLEVEL% EQU 3 goto push_commit
if %ERRORLEVEL% EQU 4 goto push_only
goto end

:push_file
echo.
set /P fileName=Podaj nazw© pliku, Je¾eli zawiera spacje podaj nazw© w cudzysˆowie: 
goto push_add

:push_add
echo.
git add %fileName%
:push_commit
echo.
set /P commit=Podaj commit tej aktualizacji: 
git commit -m "%commit%"
:push_only
git push origin master
goto end

:pulled_from_cmd
echo.
echo pobieram najnowsze wersje plik¢w...
echo.
git pull origin master