@echo off
IF NOT EXIST %1\nul GOTO :INVALID 
SET drive=%1
SHIFT
IF (%1) == () GOTO :HELP
:: See if an outfile was specified:
IF (%2) == () GOTO :NOOUT

:: It wasn't...
dir %drive%\ /s/o/b | find /I "%1" > %2
GOTO :EXIT

:NOOUT
:: An outfile was specified, so output to that file.
dir %drive%\ /s/o/b | find /I "%1"
GOTO :EXIT

:ABEND
ECHO.
ECHO Temp file T&$h89! already exists. (This
ECHO suggests an abnormal end the last time 
ECHO findfile was run.)
ECHO.
ECHO Delete T&$h89! and start findfile again.
ECHO.
GOTO :EXIT

:HELP
:: Help file is shown if findfile is called without args.
IF EXIST T&$h89! GOTO ABEND

ECHO [1mfindfile 0.1[0m >T&$h89!
ECHO Copyright 2001, thorne - thorne@timbral.net>>T&$h89!
ECHO.>>T&$h89!
ECHO    [1mPURPOSE[0m>>T&$h89!
ECHO      Lists all files complete with full path whose path or file name>>T&$h89!
ECHO      contains a given string.>>T&$h89!
ECHO.>>T&$h89!
ECHO    [1mUSAGE[0m>>T&$h89!
ECHO                      [1mfindfile directory string [outfile][0m>>T&$h89!
ECHO.>>T&$h89!
ECHO     Where:>>T&$h89!
ECHO      --directory is the the directory to search>>T&$h89!
ECHO        (search will include all subdirectories.) >>T&$h89!
ECHO      --and string is the case insensitive string to search,>>T&$h89!
ECHO      --and outfile is a filespec to which to redirect output.>>T&$h89!
ECHO      [1mWarning:[0m outfile>>T&$h89! will automatically be overwritten if it already exists.>>T&$h89! 
ECHO.>>T&$h89!
ECHO    [1mEXAMPLE[0m (assuming your command prompt is: [1mC:\#[0m)>>T&$h89!
ECHO.>>T&$h89!
ECHO [1mC:\#findfile c: bat[0m>>T&$h89!
ECHO C:\AUTOEXEC.BAT>>T&$h89!
ECHO C:\DELETEME.BAT>>T&$h89!
ECHO C:\BATMENU.COM>>T&$h89!
ECHO C:\FINDFILE.BAT>>T&$h89!
ECHO C:\BATTLE\EST.TXT>>T&$h89!
ECHO C:\DOS\720ID01.BAT>>T&$h89!
ECHO C:\MOUSE\DOS.BAT>>T&$h89!
ECHO [1mC:\#[0m[5m_[0m>>T&$h89!
ECHO.>>T&$h89!
ECHO    [1mRETURNS[0m>>T&$h89!
ECHO      Returns the full path and filename of all matching files on the>>T&$h89!
ECHO      current drive, one per line, all uppercase. Files match if the>>T&$h89!
ECHO      search string is anywhere in its path or name. Does not append>>T&$h89!
ECHO      a line feed or other garbage to the start or end of output.>>T&$h89!
ECHO.>>T&$h89!
ECHO    [1mWARRANTY[0m>>T&$h89!
ECHO      FINDFILE is unsupported resume-ware. There is NO WARRANTY of any kind>>T&$h89!
ECHO      associated with it. If you wish to use it or copy it you may do so with>>T&$h89!
ECHO      no limitations except that you not modify it without permission from the>>T&$h89!
ECHO      author.>>T&$h89!
ECHO.>>T&$h89!
type T&$h89!|more
del T&$h89!
GOTO :EXIT

:INVALID
ECHO Invalid drive specification. Type: findfile
ECHO   --without any command arguments for help.
GOTO :EXIT

:EXIT
set outfile=
