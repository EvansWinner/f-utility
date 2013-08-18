:: slide.bat
:: thorne
:: July 2001
:: Moves directly to a sibling directory.
@ECHO OFF

:: Parse command line.
if (%1) == () GOTO :HELP
if (%1) == (-?) GOTO :HELP
if (%1) == (-h) GOTO :HELP
if (%1) == (--help) GOTO :HELP

if (%1) == (-v) GOTO :VERSION
if (%1) == (--version) GOTO :VERSION
if (%1) == (--license) GOTO :VERSION
if (%1) == (--warranty) GOTO :VERSION
if (%1) == (--copying) GOTO :VERSION

if (%1) == (-l) GOTO :LIST
if (%1) == (--list) GOTO :LIST

:: Default is slide directory_name:
if exist ..\%1\nul cd ..\%1
GOTO :EXIT

:: We were asked to list the possible targets instead...
:LIST
IF EXIST ..\nul dir .. /ad /b /p
GOTO :EXIT

:: Help screen if no args, or if help args.
:HELP
ECHO.
ECHO  slide 0.1
ECHO  thorne
ECHO.
ECHO  PURPOSE: Change directory to another first-level subdirectory of the current
ECHO           parent directory (i.e. "sibling").  Doesn't work from root directory.
ECHO.
ECHO  USAGE
ECHO    slide SIBLING                  --Move to specified sibling name.
ECHO    slide -l [--list]              --List all siblings (including self).
ECHO    slide -? [-h --help]           --Print this info and quit.
ECHO    slide -v [--version --warranty
ECHO              --licence --copying] --Print version, copyright, notes and quit.
ECHO.
ECHO  EXAMPLES (Assuming `:' is your DOS prompt character.)
ECHO.    
ECHO               C:\WINDOWS\:slide -l
ECHO               acrobat3
ECHO               bat
ECHO               clarify
ECHO               TEMP
ECHO               WINDOWS
ECHO.    
ECHO               C\WINDOWS\:slide bat
ECHO               C:\BAT\:_

GOTO :EXIT

:: Version information, copyright, licence and notes.
:VERSION
ECHO.
ECHO slide 0.1
ECHO Copyright 2001, 2006 thorne - thorne@timbral.net
ECHO.
ECHO Not to be assumed proven stable, working, useful or in any way clever.
ECHO There is NO WARRANTY of any kind associated with it.  Use at your own risk.
ECHO This is a test version.  There is no support of any kind for this program,
ECHO but feel free to send questions, comments or bug reports to
ECHO thorne@timbral.net
ECHO.
GOTO :EXIT

:EXIT
