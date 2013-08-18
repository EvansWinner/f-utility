@ECHO OFF
:: evac.bat
:: Copyright 2001 thorne - thorne@timbral.net
::
:: Evacuates contents of specified directory to its parent directory
:: and optionally deletes original directory.

:: Default is to not prompt before overwriting files...
SET prmpt=/Y

:: Parse command line
::First see if help was requested...
IF (%1) == () GOTO :HELP
IF (%1) == (/h) GOTO :HELP
IF (%1) == (/help) GOTO :HELP
IF (%1) == (/?) GOTO :HELP

:: Then see if user wants to delete the directory when done
:: and see if they want to be prompted before overwrite.
IF (%1) == (/d) SET delete=true
IF (%1) == (/delete) SET delete=true
IF (%1) == (/p) SET prmpt=/-Y
IF (%1) == (/prompt) SET prmpt=/-Y
IF (%delete%) == (true) SHIFT
IF (%prmpt%) == (/-Y) SHIFT

IF (%1) == (/d) SET delete=true
IF (%1) == (/d) SHIFT
IF (%1) == (/d) GOTO :RUN

IF (%1) == (/delete) SET delete=true
IF (%1) == (/delete) SHIFT
IF (%1) == (/delete) GOTO :RUN

IF (%1) == (/p) SET prmpt=/-Y
IF (%1) == (/p) SHIFT
IF (%1) == (/p) GOTO :RUN

IF (%1) == (/prompt) SET prmpt=/-Y
IF (%1) == (/prompt) SHIFT
IF (%1) == (/prompt) GOTO :RUN

:RUN
:: The actual work
move %prmpt% %1\*.* %1\.. > nul

IF (%delete%) == (true) rmdir %1
IF (%delete%) == (true) IF (%1) == (.) cd ..
GOTO :EXIT

:HELP
::Help text
ECHO.
ECHO  evac 0.1
ECHO  Copyright 2001, 2006 thorne - thorne@timbral.net
ECHO.
ECHO  PURPOSE
ECHO    "Evacuate" (move) all files from a specified directory to their parent
ECHO    directory and optionally delete their original directory
ECHO.
ECHO  USAGE
ECHO    evacuate /? [or /h or /help]      --Print this documentation and exit.
ECHO    evacuate [/d][/p] directory_spec
ECHO.
ECHO   Where directory_spec is whatever path information is required to pinpoint the
ECHO   directory (just the name of the directory if you are currently working in its
ECHO   parent directory, or just `.' (dot) if currently in the target directory.
ECHO   You must place either (or both) switches before directory_spec.  Use /d (or
ECHO   /delete) to delete the original directory after files have been evacuated
ECHO   from it.  Use /p (or /prompt) to prompt before overwriting files.
ECHO.
ECHO   !!! WARNING !!!  THE DEFAULT ACTION IS TO AUTOMATICALLY OVERWRITE ANY FILES 
ECHO   AND/OR DIRECTORIES THAT HAVE THE SAME FILE NAME IN THE PARENT DIRECTORY.
ECHO   USE /P OR /PROMPT TO OVERRIDE THIS BEHAVIOR.
ECHO.

GOTO :EXIT

:EXIT
SET delete=
SET prmpt=
