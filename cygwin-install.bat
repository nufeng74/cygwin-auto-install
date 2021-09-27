@ECHO OFF
REM -- Automates cygwin installation
REM -- Source: https://github.com/rtwolf/cygwin-auto-install
REM -- Based on: https://gist.github.com/wjrogers/1016065
 
SETLOCAL
 
REM -- Change to the directory of the executing batch file
CD %~dp0

REM -- Download the Cygwin installer
IF NOT EXIST cygwin-setup.exe (
	ECHO cygwin-setup.exe NOT found! Downloading installer...
	bitsadmin /transfer cygwinDownloadJob /download /priority normal https://cygwin.com/setup-x86_64.exe %CD%\\cygwin-setup.exe
) ELSE (
	ECHO cygwin-setup.exe found! Skipping installer download...
)
 
REM -- Configure our paths
#SET SITE=https://mirrors.aliyun.com/cygwin
#SET SITE=http://mirrors.ucst.edu.cn/cygwin
SET SITE=http://mirrors.163.com/cygwin
SET LOCALDIR=%CD%
SET ROOTDIR=C:\\cygwin64
 
REM -- These are the packages we will install (in addition to the default packages)
SET PACKAGES=xorg-server
REM -- These are necessary for apt-cyg install, do not change. Any duplicates will be ignored.
SET PACKAGES=%PACKAGES%,xwinclip,run
 
REM -- More info on command line options at: https://cygwin.com/faq/faq.html#faq.setup.cli
REM -- Do it!
ECHO *** INSTALLING DEFAULT PACKAGES
cygwin-setup --quiet-mode --no-desktop --download --local-install --no-verify -s %SITE% -l "%LOCALDIR%" -R "%ROOTDIR%"
ECHO.
ECHO.
ECHO *** INSTALLING CUSTOM PACKAGES
cygwin-setup -q -d -D -L -X -s %SITE% -l "%LOCALDIR%" -R "%ROOTDIR%" -P %PACKAGES%
 
REM -- Show what we did
ECHO.
ECHO.
ECHO cygwin installation updated
ECHO  - %PACKAGES%
ECHO.

REM ECHO apt-cyg installing.
REM set PATH=%ROOTDIR%/bin;%PATH%
REM %ROOTDIR%/bin/bash.exe -c 'svn --force export http://apt-cyg.googlecode.com/svn/trunk/ /bin/'
REM %ROOTDIR%/bin/bash.exe -c 'chmod +x /bin/apt-cyg'
REM ECHO apt-cyg installed if it says somin like "A    /bin" and "A   /bin/apt-cyg" and "Exported revision 18" or some other number.

ENDLOCAL
 
REM PAUSE
EXIT /B 0
