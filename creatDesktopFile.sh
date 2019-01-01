#!/bin/bash

FileDir=$2


echo "CREATE DESKTOP LAUNCHER PROGRAMMES"
if [ $# -lt 1 ]; then
    echo "please use --help for information"
elif [ $1 = "--help" ] || [ $1 = "-h" ]; then
echo -e "       CREATE DESKTOP LAUNCHER PROGRAMMES :\nthis is script for create desktop entry for run programme\n easly and without show a terminal\n\n"
echo "Usage:"
echo "-h, --help                : display this help text and exit"
echo "-s, --script <file path>  :The file you want to create has a desktop"
echo "-i, --image <image path>  :Icon that you want to display in the Desktop Entry if not use this argument the desktop entry display without icon (default system icon)"
echo 
elif [ $1 = "-s" ] || [ $1 = "--script" ]; then
     if [ -e $2 ] && [ $# = 2 ];then
        FILE=$2
	f="$(basename -s .sh $FILE)"
	read -p "Name for your programme ": name
	echo "if name is empty there is no name display in menu bar for your programme"
	echo  "[Desktop Entry]
Encoding=UTF-8
Name=$name
Comment=
Exec=/bin/sh '"$2"'
Icon=
Categories=
Version=1.0
Type=Application
Terminal=0" > /$USER/Desktop/$f
mv /$USER/Desktop/$f /$USER/Desktop/$f.desktop
chmod +x /$USER/Desktop/$f.desktop
    fi

 
fi




