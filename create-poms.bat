@echo off
:: this script assumes sed from Gnuwin32 is installed and is on the path
if exist .\version.txt goto checkversion
	echo "Version.txt does not exist"
	goto :EOF

:checkversion

setlocal
for /F "usebackq" %%I in (`type .\version.txt`) do set VERSION=%%I

if not "%VERSION%"=="" goto createpoms
	echo "Version.txt is empty"
	goto :EOF
fi

:createpoms

echo "Creating poms as version %VERSION%"

:: can't use for /R %%I in (pom-template.xml) since that recurses into .svn directories.  dir doesn't.
for /F "usebackq" %%I in (`dir /b /s pom-template.xml`) do sed -e "s/\${dejalu-version}/%VERSION%/" %%I > %%~dpIpom.xml
