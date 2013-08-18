@ECHO OFF

:: Make sure args are correct and parse them.
IF (%1) == (/v) GOTO :VERSION
IF (%1) == (/version) GOTO :VERSION
IF (%1) == (/license) GOTO :VERSION
IF (%1) == (/copying) GOTO :VERSION
IF (%1) == (/warranty) GOTO :VERSION

IF (%1) == (/a) set append=true
IF (%1) == (/append) set append=true

IF (%append%) == (true) SHIFT
IF (%append%) == (true) IF (%1) == (time) GOTO :USAGE
IF (%append%) == (true) IF (%1) == (date) GOTO :USAGE
IF (%append%) == (true) SET outfile=%1
IF (%append%) == (true) shift

IF NOT (%1) == (date) IF NOT (%1) == (time) GOTO :USAGE
IF (%2) == () GOTO :RUN
IF NOT (%2) == (date) IF NOT (%2) == (time) GOTO :USAGE

:RUN
:: The main bit. This creates a file with just a linefeed
:: and then pipes that to the input of the time or date command
:: (%1) and then pipes the output (by way of find) to another file
:: and give it a .bat extension. The output looks like: Current time is foo.
:: So then we make another file called current.bat that just puts
:: whatever it's 3rd and 4th args were into the envir var `just'
:: (this is because it's different between time and date.
:: Whew! What a kludge!) We execute the one that
:: calls current.bat and current.bat outputs the time or date.

:: Build the program to put whatever it is called with into the
:: environment variable `just'
ECHO set just=%%3 %%4>current.bat

:: make a file with just a line feed.
echo.>d86r4b

:: Call time (or date) with the linefeed file as input and
:: a temp file as output.
%1<d86r4b>v%&vv

:: Filter the temp file through DOS's `find' command
:: and send the rusulting single line to a temp batch file.
:: That batch file will look like: Current date is: foobar
type v%&vv|find /I "current">B&(54.bat 

:: Now we call that file. It in turn tries to execute an
:: executable called "Current" We have already made that file
:: and so it's 3rd and fourth args are put into the environment
:: variable: `just'
call B&(54.bat

IF NOT (%append%) == (true) echo %just%
IF NOT (%append%) == (true) GOTO :CLEANUP
IF NOT (%foo%) == (true) ECHO.>>%outfile%
echo %just%>>%outfile%

:: This is to see if it is the first or second pass.
SET foo=true

:CLEANUP
del d86r4b
del B&(54.bat
del v%&vv
del current.bat
shift
IF NOT (%1) == () GOTO :RUN

GOTO :EXIT

:USAGE
ECHO.
ECHO  just 0.1
ECHO  thorne@timbral.net
ECHO.
ECHO     PURPOSE
ECHO  Returns just the date and/or time.  Unlike the DOS `date' and `time' commands,
ECHO  just will not prompt for a new value and does not append an extra linefeed 
ECHO  to output unless output is to a file.
ECHO.
ECHO     USAGE
ECHO         just [/a OUTFILE] date (and/or) time  --Returns just the current
ECHO                                                 system date and/or time.
ECHO         just /v [/version /license /copying   --Print version, license info
ECHO                 /warranty]                      other notes and quit.
ECHO.
ECHO         just ANYTHING_ELSE                    --Print this help text and quit.
ECHO.
ECHO  Either `date' or `time' may be present and in either order.  just will return
ECHO  the current system date and/or time in the order specified on the command 
ECHO  line.  If /a (or /append) is used it must be the first command line argument,
ECHO  and must be followed by the name of the file to append.  If appending to a
ECHO  file (useful for logs, etc.), a blank line is appended to the file first.  If
ECHO  output is to the screen, no blank line is appended.  NOTE: This program
ECHO  creates temp files: current.bat, v%&vv, B&(54.bat, d86r4b in the current
ECHO  directory and immediately deletes them. 

GOTO :EXIT

:: Version information, copyright, licence and notes.
:VERSION
ECHO.
ECHO just 0.1
ECHO Copyright 2001, 2006 thorne@timbral.net
ECHO.
ECHO This program is whateverware.  It is not to be assumed proven stable, working,
ECHO useful or in any way clever.  There is NO WARRANTY of any kind associated
ECHO with it.  Use at your own risk.  This is a test version.  There is no support
ECHO of any kind for this program, but feel free to send questions, comments or
ECHO bug reports to thorne@timbral.net
ECHO.
ECHO You are hereby granted license to copy, modify and redistribute this program.
ECHO.
GOTO :EXIT

:EXIT
:: Release memory used by environment variables.
SET just=
SET append=
SET outfile=
SET foo=
