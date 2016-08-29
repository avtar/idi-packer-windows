echo "Building DoIt client for Windows"
call "C:\Program Files (x86)\Microsoft Visual C++ Build Tools\vcbuildtools_msbuild.bat"
cd c:\vagrant\doit\client
msbuild doitclient.sln
copy x64\Release\doitclient.exe C:\Windows

echo "Building DoIt server"
call "C:\Program Files (x86)\Microsoft Visual C++ Build Tools\vcbuildtools.bat" amd64
cd c:\vagrant\doit\server
nmake /f Makefile.vc
copy doit.exe C:\Windows

echo "Copying DoIt secret"
cd c:\vagrant\doit
copy doit-secret C:\Windows

echo "Creating DoIt Task (runs on startup)"
schtasks /create /tn "doit" /tr "C:\Windows\doit.exe C:\Windows\doit-secret" /sc ONSTART /ru vagrant /rp vagrant 

echo "Setting required environment varialbes"
setx DOIT_SERVER 127.0.0.1
setx HOME C:\Users\vagrant