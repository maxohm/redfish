@rem ***************************************************
@rem *** Copyright (c) 2017, maxohm [ at ] gmail.com ***
@rem ***************************************************

@echo off

:stage0
set xTASK=%0
set xOBJSKIP=0
set xHEAD="regedit.exe"
for /f %%I in ("%xTASK%") do (
	set xTSDISK=%%~dI
	set xTSPATH=%%~dpI
	set xTSNAME=%%~nI
)

:stage1
call %xTSPATH%\stage1.cmd %1 %2 %3 %4
if %ERRORLEVEL% NEQ 0 (
	set x > %xLOGFILE%
	echo ERROR %ERRORLEVEL% >> %xLOGFILE%
	exit /B %ERRORLEVEL%
)

:stage2
set xRESULT=%xOBJECT%\%UserName%\regshell.reg
if exist %xRESULT% goto stage4

:stage3
set xREG="Personal
set xREG=%xREG%"="
set xREG=%xREG%%xOBJECT:\=\\%\\%UserName%\\��� ���㬥���"

echo REGEDIT4 						 			> %xRESULT%
echo [HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders] >> %xRESULT%
echo %xREG% 									>> %xRESULT%

:stage4
if %xNULPRM4%==.nul (
	rem
) else (
	if exist %xTSPRM4% set %nCLUDE%=%xTSPRM4% 
	if exist %xOBJPATH%\%xTSPRM4% set %nCLUDE%=%xOBJPATH%\%xTSPRM4%
)

:stage5
set xPARAMS=/s %xRESULT%
set xCMD=%xSUBJECT% %xPARAMS%
set x > %xLOGFILE%

echo JOB STARTED %DATE% %TIME% >> %xLOGFILE%
start "%xTSNAME%" /b /wait %xCMD%
echo JOB FINISHED %DATE% %TIME% >> %xLOGFILE%

exit /B 0