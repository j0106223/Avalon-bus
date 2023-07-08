@ REM ######################################
@ echo off
set project.sof=DE10_Standard_default.sof
set project.jic=DE10_Standard_default.jic
set device_sfl.sof=sfl_enhanced_01_02d020dd.sof
set fpga_device=5csxfc6d6 


@set QUARTUS_BIN=%QUARTUS_ROOTDIR%\\bin
@if exist %QUARTUS_BIN%\\quartus_pgm.exe (goto DownLoad)

@set QUARTUS_BIN=%QUARTUS_ROOTDIR%\\bin64
@if exist %QUARTUS_BIN%\\quartus_pgm.exe (goto DownLoad)


:DownLoad
%QUARTUS_BIN%\\jtagconfig.exe > %%JTAG_INFO
IF ERRORLEVEL 1 goto error
setlocal enableextensions

rem check DE-SoC Board
for /f "tokens=2" %%a in (
%%JTAG_INFO
) do (
if %%a == DE-SoC goto Board_Ready
)

echo Can not find DE-SoC board, please check the hardware.
goto end


:Board_Ready
rem Find out device index
set /a Index=0
for /f "tokens=1" %%a in (
%%JTAG_INFO) do (
if %%a == 02D020DD goto main
set /a Index+=1
)

echo Can not find 5CSXFC6 FPGA Device, please check the hardware.
goto end



:main
del %%JTAG_INFO
echo **********************************
echo Please choose your operation
echo "1" for programming .sof to FPGA.
echo "2" for converting .sof to .jic 
echo "3" for programming .jic to EPCS.
echo "4" for erasing .jic from EPCS.
echo "5" for EXIT batch.
echo **********************************
choice /C 12345 /M "Please enter your choise:" 
if errorlevel 5 goto exit 
if errorlevel 4 goto d 
if errorlevel 3 goto c  
if errorlevel 2 goto b  
if errorlevel 1 goto a 


:a
echo ===========================================================
echo "Progrming .sof to FPGA"
echo ===========================================================
%QUARTUS_BIN%\\quartus_pgm.exe -m jtag -c 1 -o "p;%project.sof%@%Index%""
@ set SOPC_BUILDER_PATH=%SOPC_KIT_NIOS2%+%SOPC_BUILDER_PATH%
goto end


:b 
echo ===========================================================
echo "Convert .sof to .jic"
echo ===========================================================
%QUARTUS_BIN%\\quartus_cpf -c -d epcs128 -s %fpga_device% %project.sof% %project.jic%
goto end

:c
echo ===========================================================
echo "Programming EPCS with .jic"
echo ===========================================================
%QUARTUS_BIN%\\quartus_pgm.exe -m jtag -c 1 -o "p;%device_sfl.sof%@%Index%""
%QUARTUS_BIN%\\quartus_pgm.exe -m jtag -c 1 -o "p;%project.jic%@%Index%""
goto end

:d
echo ===========================================================
echo "Erasing EPCS with .jic"
echo ===========================================================
%QUARTUS_BIN%\\quartus_pgm.exe -m jtag -c 1 -o "p;%device_sfl.sof%@%Index%""
%QUARTUS_BIN%\\quartus_pgm.exe -m jtag -c 1 -o "r;%project.jic%@%Index%""
goto end

:error
echo Please Check your USB Blaster!!


:end
echo Goodbye!!
goto main

:exit

endlocal



pause