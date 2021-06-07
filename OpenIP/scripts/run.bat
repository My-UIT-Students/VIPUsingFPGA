@echo off
if "%~1" equ "" (
  setlocal TESTNAME=test
) else (
  setlocal TESTNAME=%1%
)
if "%~2" equ "" (
  setlocal SEED=%RANDOM%
) else (
  setlocal SEED=%2%
)
call clean.bat
call compile.bat
call simulate.bat %TESTNAME% %SEED%

