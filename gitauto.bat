@echo off
@chcp 852
set tmp=%~dp0
set workingDirectory=%tmp:~0,-1%
cd %workingDirectory%
title gitauto
cls
echo program uruchomiony z: %workingDirectory%
if "%1" EQU "pull" ( goto pull )
echo.
echo Chcesz pobra† najnowsze dane z repozytorium   (1)?
echo Czy wysˆa† wszystkie swoje pliki do niego     (2)?
choice /C 12 /N /M "[1/2]:"

if %ERRORLEVEL% EQU 1 goto pull
if %ERRORLEVEL% EQU 2 goto push_choice

:end
echo.
echo zakoäczono prace
echo.
pause
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
echo Chcesz wysˆa† WSZYSTKIE pliki kt¢re mog¥ zosta† zaktualizowane   (1)?
echo czy tylko te oznaczone oznaczone ju¾ jako do dodania             (2)?
echo czy wysˆa† ju¾ zapisane commit'y?                                (3)?
choice /C 12 /N /M "[1/2/3]:"
if %ERRORLEVEL% EQU 1 goto push_add
if %ERRORLEVEL% EQU 2 goto push_commit
if %ERRORLEVEL% EQU 3 goto push_only
goto end

:push_add
echo.
git add *
:push_commit
echo.
set /P commit=Podaj commit tej aktualizacji: 
git commit -m "%commit%"
:push_only
git push origin master
goto end
