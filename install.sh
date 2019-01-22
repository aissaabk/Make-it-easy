#!/bin/sh

if [ $(id -u) -ne 0 ];then
echo "please run this script as root"
echo "for installation instructions, please read file readme.rm"
exit 1
fi
echo "start install the programe please wait a few time"
#init

DESKTOPENRTRY_DIR=/opt/desktop-entry
ls DESKTOPENRTRY_DIR >/dev/null 2>&1
if [ -d $DESKTOPENRTRY_DIR ];then
rm -d $DESKTOPENRTRY_DIR >/dev/null 2>&1
	if [ $? -ne 0 ];then
        echo -e "\033[1;31mWarning 1 Exist directory with same name\033[0;39m"
	echo "the directory of the instalation not empty do you remove it yes/no"
	read reponse
		if [ $reponse = "yes" ] || [ $reponse = "y" ];then
		rm -r $DESKTOPENRTRY_DIR
		else
		echo "cannot install programme into this directory ..?"
		exit 1
		fi
	fi
fi

mkdir $DESKTOPENRTRY_DIR
echo "create directory successfully"
echo "create script programme ..."
echo '
#!$SHELL

#check permission 
if [ $(id -u) -ne 0 ];then
echo "please run this script as root"
echo "for installation instructions, please read file readme.rm"
exit 1
fi
#thisscript for create desktop entry
#check if argument it empty

if [ $# = 0 ];then 
echo "please type :desktop [--help/-h]
for more information"
exit 0
#help usage
elif [ $1 = "--help" ] || [ $1 = "-h" ];then

echo "Usage :desktop [arg1] [value1] [arg2] [value2] ....
create desktop for shell file

option :
-s ,--script    <application path>          for specifed the full path to the application file
-i ,--icon      <icon path       >          for specifed the full path to the icon
                                            null if not specifed
-c,--categories <category        >          the category for the appliction example for browser 
                                            Network or internet

-h,--help                                   for display this usage

"
echo -e "for help to  developed this application please donate my \033[0;36mhttp://www.google.com"
echo -e "\033[0;39for more help send myby email at  \033[0;36mbelmelahmed@gmail.com"
echo -e "\033[0;39mfor how do use this script please type :desktop --help"
echo -e "for \033[1;31muninstall do:desktop --uninstall"
exit 0
fi

if [ $1 = "--uninstall" ] && [ $# = 1 ];then
echo "remove directory and her contents"
rm -f $DESKTOPENRTRY_DIR
echo "remove shurt link"
rm /usr/bin/desktop
echo "Done End uninstall"
echo "check if programme uninstall correctly run"
echo "#command -V desktop"
exit 0
fi


#and uninstall
#chack all argument the parametres and the values

for (( i=1 ; i<=$# ; i++ ))
do
if [ ${!i} = "--script" ] || [ ${!i} = "-s" ];then
	script=${!i}
	j=$((i+1))
	value_script=${!j}
elif [ ${!i} = "--icon" ] || [ ${!i} = "-i" ];then
	icon=${!i}
	z=$((i+1))
	value_icon=${!z}
elif [ ${!i} = "--categories" ] || [ ${!i} = "-c" ];then
	category=${!i}
	k=$((i+1))
	category_value=${!k}
fi
done
if [ -z $script ];then
echo "messing argument --script/-s please type
desktop [--help/-h] for more information"
exit 1
elif [ -z $value_script ];then
echo "the path not exist check it and run again"
exit 1
elif [ ! -f $value_script ];then
echo "is Derictory but require file type desktop --help/-h for help "
exit 1
fi
ls $value_script >/dev/null 2>&1
if [ $? -ne 0 ];then
echo "the path for application not correct please check it and run again"
exit 1
fi
if [ -z $icon ];then
echo "you dont specife icon "
fi
#get the absulte name file
f="$(basename -s .* $value_script)"
echo -e "write name for your application in desktop"
read name
echo -e "write a comment for your application"
read comment
echo "[Desktop Entry]
Encoding=UTF-8
Name=$name
Comment=$comment
Exec=/bin/sh $value_script
Icon=$value_icon
Categories=Application;$category_value
Version=1.0
Type=Application
Terminal=0" > "/usr/share/applications/$f"
mv "/usr/share/applications/$f" "/usr/share/applications/$f.desktop"
cp "/usr/share/applications/$f.desktop" "/home/$USERNAME/Desktop/"
chmod +x "/usr/share/applications/$f.desktop"
chmod +x "/home/$USERNAME/Desktop/$f.desktop"
echo "the Desktop Entry Create succefully"
echo "Finish installation thank you for using my programme"
echo "-----------------------------------------------------------------------"
exit 0' >  $DESKTOPENRTRY_DIR/desktop
if [ -f "iconDesktop.png" ];then
cp "iconDesktop.png" $DESKTOPENRTRY_DIR/
fi
echo "[Desktop Entry]
Encoding=UTF-8
Name=Desktop Entry
Comment=for create desktop entry from terminal
Exec=/bin/sh $DESKTOPENRTRY_DIR/desktop
Icon=$DESKTOPENRTRY_DIR/iconDesktop.png
Categories=Application;Utility;
Version=1.0
Type=Application
Terminal=true" > /usr/share/applications/desktop.desktop
echo "create desktop Entry successfully"
chmod 777 "/usr/share/applications/desktop.desktop"
xdg-desktop-menu forceupdate
chmod 777 $DESKTOPENRTRY_DIR/desktop
if [ -f /usr/bin/desktop ];then
echo -e "\033[1;31mWarning 2 create shortlink\033[0;39m"
echo "you have a short link with same name for this programme if it because 
older installation for this programme please 
reponse with yes otherwise no yes/no"
read reponse
	if [ $reponse = "yes" ] || [ $reponse = "y" ];then
	rm -r /usr/bin/desktop
	else
	echo "cannot remove link short programme sorry aborted instalation"
	exit 1
	fi 
fi
ln -s $DESKTOPENRTRY_DIR/desktop /usr/bin/desktop
echo "Finish installation thank you for using my programme"
echo -e "if you can buy my from paypal visit this link please \033[0;36mhttp://www.google.com\033[0;39m"
echo -e "for more help send myby email at  \033[0;36mbelmelahmed@gmail.com"
echo -e "\033[0;39mfor how do use this script please type :desktop --help"
echo -e "for \033[1;31muninstall do:desktop --uninstall

\033[0;035mgood usage"
exit 0
