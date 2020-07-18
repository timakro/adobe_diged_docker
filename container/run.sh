export DISPLAY=:1
Xvfb :1 -screen 0 1024x768x24 &
x11vnc -forever &

wine ".wine/drive_c/Program Files/Adobe/Adobe Digital Editions 2.0/DigitalEditions.exe" in.acsm &

n=0
while [ $n -lt 20 ]; do
    sleep 1
    book=$(find My\ Digital\ Editions/ -maxdepth 1 -type f ! -name welcome.epub | head -n 1)
    if [ -n "$book" ]; then
        while [ $(( $(date +%s) - $(stat -c %Y "$book") )) -lt 10 ]; do sleep 1; done
        mkdir out
        mv "$book" out
        exit 0
    fi
    n=$((n + 1))
done
exit 1
