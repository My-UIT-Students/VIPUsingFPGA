@echo off
pushd ..\database
if defined ProgramFiles(x86) (
  ..\framework\Python25_x64\python.exe .\txt2im.py
) else (
  ..\framework\Python27_x32\python.exe .\txt2im.py
)
popd
