@ECHO OFF
:: join.bat
:: Copyright 2001 thorne - thorne@timbral.net
::
:: Concatenates text files to stdout or to specified file.

:: Parse command line...
:: Looking for help...
IF (%1) == () GOTO :HELP
IF (%1) == (/h) GOTO :HELP
IF (%1) == (/help) GOTO :HELP
IF (%1) == (/?) GOTO :HELP 

:: Append newline to each file?
IF (%1) == (/n) SET newline=true
IF (%1) == (/newline) SET newline=true
IF (%newline%) == (true) SHIFT

:: Outfile? If so, should we append or delete?
IF (%1) == (/oa) SET out=true
IF (%1) == (/oa) SHIFT
IF (%out%) == (true) SET outfile=%1
IF (%out%) == (true) SHIFT
IF (%out%) == (true) GOTO :STARTOUT

IF (%1) == (/od) SET out=true
IF (%1) == (/od) SET delete=true
IF (%1) == (/od) SHIFT
IF (%out%) == (true) SET outfile=%1
IF (%out%) == (true) SHIFT
IF (%out%) == (true) GOTO :STARTOUT

:: Here's what to do if we are sending output to stdout
:START
type %1
IF (%newline%) == (true) ECHO.
SHIFT
IF NOT (%1) == () GOTO :START
GOTO :EXIT

:: Here's what to do if we are outputting to a file.
:STARTOUT
IF (%delete%) == (true) quote "Jezus Chreeeeiest!"
IF (%delete%) == (true) type %1 > %outfile%
IF (%delete%) == () type %1 >> %outfile%
GOTO :SKIPPREV
:STARTSUB
type %1 >> %outfile%
:SKIPPREV
IF (%newline%) == (true) ECHO. >> %outfile%
SHIFT
IF NOT (%1) == () GOTO :STARTSUB
GOTO :EXIT

:: Here's the text for the help page.
:HELP
ECHO.
ECHO  join 0.1
ECHO  thorne@timbral.net
ECHO.
ECHO  PURPOSE: Similar to UNIX's 'cat' command.  Output several text files to the
ECHO           screen one after the other, or redirect to a file. 
ECHO.
ECHO  USAGE: join /? [or /h or /help]  --Prints this page and exists.
ECHO         join [/n] [/oa or /od outfile] filename1 [filename2...]
ECHO.
ECHO  Use /n (or /newline) to append an extra carrage return to the end of
ECHO  each file's output (will not effect the file itself).  Use /oa or /od
ECHO  followed by a filename to specify an output file.  Use /oa to append
ECHO  to the end of that file if it already exists.  Use /od to delete first
ECHO  if it already exists.  If using both /n and output to a file, /n must
ECHO  come first on the command line, followed by /oa or /od.

GOTO :EXIT

:: Everything ends up here.
:: Do some environment variable cleanup before exiting.
:EXIT
SET newline=
SET out=
SET outfile=
SET delete=
