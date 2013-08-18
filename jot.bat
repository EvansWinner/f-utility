:: jot.bat
:: thorne - thorne@timbral.net
:: July 2001
:: Uses copy con filenale technique to take quick notes and place in a text file.
:: Mainly it is about offering options to make it usefull to quickly append to
:: existing files, or get input from another batch file into a file, etc.
@ECHO OFF

:: Init all vars.
SET quiet=
SET help=
SET delete=
SET append=
SET bool1=
set bool2=

:: Parse input args and shift filename arg to %1
IF (%1) == () GOTO :QUICKHELP

IF (%1) == (/?) SET help=true
IF (%1) == (/h) SET help=true
IF (%1) == (/help) SET help=true
IF (%2) == (/?) SET help=true
IF (%2) == (/h) SET help=true
IF (%2) == (/help) SET help=true
IF (%3) == (/?) SET help=true
IF (%3) == (/h) SET help=true
IF (%3) == (/help) SET help=true
IF (%4) == (/?) SET help=true
IF (%4) == (/h) SET help=true
IF (%4) == (/help) SET help=true
IF (%5) == (/?) SET help=true
IF (%5) == (/h) SET help=true
IF (%5) == (/help) SET help=true
IF (%6) == (/?) SET help=true
IF (%6) == (/h) SET help=true
IF (%6) == (/help) SET help=true

IF (%help%) == (true) GOTO :HELP

IF (%1) == (/v) GOTO :VERSION
IF (%1) == (/version) GOTO :VERSION
IF (%1) == (/warranty) GOTO :VERSION
IF (%1) == (/license) GOTO :VERSION
IF (%1) == (/copying) GOTO :VERSION

IF (%1) == (/q) SET quiet=true
IF (%1) == (/quiet) SET quiet=true
IF (%1) == (/d) SET delete=true
IF (%1) == (/delete) SET delete=true
IF (%1) == (/a) SET append=true
IF (%1) == (/append) SET append=true
IF (%quiet%) == (true) SHIFT
IF (%delete%) == (true) SHIFT
IF (%append%) == (true) SHIFT

IF (%1) == (/q) SET quiet=true
IF (%1) == (/quiet) SET quiet=true
IF (%1) == (/d) SET delete=true
IF (%1) == (/delete) SET delete=true
IF (%1) == (/a) SET append=true
IF (%1) == (/append) SET append=true
IF (%1) == (/q) SHIFT
IF (%1) == (/quiet) SHIFT
IF (%1) == (/d) SHIFT
IF (%1) == (/delete) SHIFT
IF (%1) == (/a) SHIFT
IF (%1) == (/append) SHIFT

IF (%delete%) == (true) IF (%append%) == (true) GOTO :QUICKHELP

IF EXIST %1 GOTO :EXIST 
GOTO :NOEXIST

:EXIST
IF (%delete%) == (true) GOTO :NOEXIST
IF (%append%) == (true) GOTO :NOEXIST
ECHO.
ECHO The file: %1 already exists. Use:
ECHO jot /d filename to delete
ECHO jot /a filename to append.
ECHO.
ECHO Aborting.
GOTO :EXIT
:NOEXIST
IF (%quiet%) == (true) GOTO :RUN

ECHO.
ECHO JOT 0.1 Quick note taker.
ECHO.
ECHO  * Use the left arrow for backspace. (Works only for the current line.)
ECHO  * Use ctrl^break (or ctrl^C) and then: 'y' to cancel without saving.
ECHO  * Use F6 (or ctrl^Z) and then [ENTER] to save and end.
ECHO  * If appending to a file you may want to start or end with a blank line.
ECHO.

:RUN
IF NOT EXIST %1 SET delete=true
IF (%delete%) == (true) copy con %1 /Y
IF (%delete%) == (true) GOTO :EXIT

copy con a9nh0 /Y
type a9nh0 >> %1
del a9nh0
GOTO :EXIT

:ABEND
ECHO.
ECHO JOT: temp file G78g8#& already exists. (This
ECHO      suggests an abnormal end the last time 
ECHO      jot was run.)
ECHO.
ECHO      Delete G78g8#& and start jot again.
ECHO.
GOTO :EXIT

:HELP
:: Help file is shown if JOT is called without args.
IF EXIST G78g8#& GOTO ABEND

ECHO jot 0.1>G78g8#&
ECHO thorne - thorne@timbral.net>>G78g8#&
ECHO.>>G78g8#&
ECHO    PURPOSE>>G78g8#&
ECHO      Quick note taker for DOS.>>G78g8#&
ECHO.>>G78g8#&
ECHO    USAGE>>G78g8#&
ECHO                      jot [/q] [/d or /a] FILESPEC>>G78g8#&
ECHO                      jot /?>>G78g8#&
ECHO                      jot /v>>G78g8#&
ECHO.>>G78g8#&
ECHO      /? [/h /help]           --Show this page.  Overrides any other args.>>G78g8#&
ECHO      /q [/quiet  ]           --Supress introductory message when starting.>>G78g8#&
ECHO      /d [/delete ]           --Delete file first if it already exists.>>G78g8#&
ECHO      /a [/append ]           --Append to end of file.  (Usefull for>>G78g8#&
ECHO                                keeping logs, etc.)>>G78g8#&
ECHO      /v [/version /warranty>>G78g8#&
ECHO          /license /copying]  --Print version, copyright, notes and quit.>>G78g8#&
ECHO.>>G78g8#&
ECHO    NOTES>>G78g8#&
ECHO      JOT can be used to send text data to any port with a default DOS file>>G78g8#&
ECHO      alias, such as com1, lpt1, etc. You must use the /d switch for this to>>G78g8#&
ECHO      work. For instance, use jot /d com1, then type:>>G78g8#&
ECHO      atdt 8888888[ENTER] F6 [ENTER]>>G78g8#&
ECHO      to dial 888-8888 on your modem (if it is configured, etc.).>>G78g8#&
ECHO      Use the /q switch to use jot to get input into a file from another>>G78g8#&
ECHO      batch file.>>G78g8#&
ECHO.>>G78g8#&
type G78g8#&|more
del G78g8#&
GOTO :EXIT

:QUICKHELP
ECHO.
ECHO JOT: Use jot /? for help.
GOTO :EXIT

:: Version information, copyright, licence and notes.
:VERSION
ECHO.
ECHO jot 0.1
ECHO Copyright 2001, 2006 thorne - thorne@timbral.net
ECHO.
ECHO This program is resumeware... or used to be when i still thought DOS-batch
ECHO programming was cool.  
ECHO.
ECHO It is not to be assumed proven stable, working,
ECHO useful or in any way clever.  There is NO WARRANTY of any kind associated
ECHO with it.  Use at your own risk.  This is a test version.  There is no support
ECHO of any kind for this program, but feel free to send questions, comments or
ECHO bug reports to thorne@timbral.net
ECHO.
ECHO.
GOTO :EXIT

:EXIT
SET quiet=
SET help=
SET delete=
SET append=
SET bool1=
set bool2=
