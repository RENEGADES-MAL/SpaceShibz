@echo off
@chcp 852
set tmp=%~dp0
set workingDirectory=%tmp:~0,-1%
cd %workingDirectory%
title gitauto
cls
echo program uruchomiony z: %workingDirectory%
echo.
echo Chcesz pobra† najnowsze dane z repozytorium   (1)?
echo Czy wysˆa† wszystkie swoje pliki do niego     (2)?
choice /C 12 /N /M "[1/2]:"

if %ERRORLEVEL% EQU 1 goto pull
if %ERRORLEVEL% EQU 2 goto push_choice

:end
echo.
echo zakoäczono prac©
echo.
pause
exit

:pull
echo.
git pull origin master | find /C "Already up-to-date"
if %ERRORLEVEL% EQU 0 goto not_needed
goto end

:not_needed
cls
echo Nie ma potrzeby aktualizacji, wszystko aktualne
goto end

:push_choice
echo.
echo Chcesz wysˆa† WSZYSTKIE pliki       (1)?
echo czy tylko te oznaczone do dodania   (2)?
choice /C 12 /N /M "[1/2]:"
if %ERRORLEVEL% EQU 1 goto push
if %ERRORLEVEL% EQU 2 goto push_only
goto end

:push
echo.
git add *
echo.
set /P commit=Podaj commit tej aktualizacji: 
git commit -m "%commit%"
:push_only
git push origin master
goto end