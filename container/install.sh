export DISPLAY=:0
Xvfb :0 -screen 0 1024x768x24 &
x11vnc -forever &

export WINEARCH=win32

winetricks -q corefonts
winetricks -q windowscodecs
winetricks -q dotnet35sp1
winetricks -q python27

wine pycrypto-2.6.1.win32-py2.7.exe
wine ADE_2.0_Installer.exe

while pgrep DigitalEditions >/dev/null; do sleep 1; done
wineserver --kill
