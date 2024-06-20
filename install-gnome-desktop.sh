#!/bin/bash

R="$(printf '\033[1;31m')"
G="$(printf '\033[1;32m')"
Y="$(printf '\033[1;33m')"
W="$(printf '\033[1;37m')"
C="$(printf '\033[1;36m')"

function banner() {
    clear
	
printf "\033[33m╭━━━╮╱╱╱╱╱╱╱╱╱╱╱╱╭━━╮╱╱╱╭━━━━╮\033[0m\n"
printf "\033[33m┃╭━╮┃╱╱╱╱╱╱╱╱╱╱╱╱╰┫┣╯╱╱╱┃╭╮╭╮┃\033[0m\n"
printf "\033[33m┃┃╱╰╋━╮╭━━┳╮╭┳━━╮╱┃┃╭━╮╱╰╯┃┃┣┻━┳━┳╮╭┳╮╭┳╮╭╮\033[0m\n"
printf "\033[33m┃┃╭━┫╭╮┫╭╮┃╰╯┃┃━┫╱┃┃┃╭╮╮╱╱┃┃┃┃━┫╭┫╰╯┃┃┃┣╋╋╯\033[0m\n"
printf "\033[33m┃╰┻━┃┃┃┃╰╯┃┃┃┃┃━┫╭┫┣┫┃┃┃╱╱┃┃┃┃━┫┃┃┃┃┃╰╯┣╋╋╮\033[0m\n"
printf "\033[33m╰━━━┻╯╰┻━━┻┻┻┻━━╯╰━━┻╯╰╯╱╱╰╯╰━━┻╯╰┻┻┻━━┻╯╰╯\033[0m\n"
echo "${C}${BOLD} Install Gnome Desktop In Termux ${W}"
echo                                                    
}

function package_install_and_check() {
	packs_list=($@)
	for package_name in "${packs_list[@]}"; do
    echo "${R}[${W}-${R}]${G}${BOLD} Installing package: ${C}$package_name "${W}
    apt install "$package_name" -y
	if [ $? -ne 0 ]; then
    apt --fix-broken install -y
	dpkg --Configuring -a
    fi
	if dpkg -s "$package_name" >/dev/null 2>&1; then
    echo "${R}[${W}-${R}]${G} $package_name installed successfully "${W}
	else
	if
    type -p "$package_name" &>/dev/null || [ -e "$PREFIX/bin/$package_name"* ] || [ -e "$PREFIX/bin/"*"$package_name" ]; then
        echo "${R}[${W}-${R}]${C} $package_name ${G}installed successfully "${W}
	fi
    fi
done

}

function check_root(){
	if [ $EUID -ne 0 ]; then
		echo -ne " ${R}Please Login Into Root User Then Run it Again!\n\n"${W}
		exit 1
	fi
}

function questions() {
	banner
	echo 
	echo "${R} [${W}-${R}]${G}Select the Gnome Desktop type"${W}
	echo
	echo "${Y}1. Full (~3.5Gb of space)"${W}
	echo
	echo "${Y}2. Core (~1.5GB of space)"${W}
	echo
	read -p "${Y}select an option (Default 1): "${W} answer_desktop
	banner
	echo 
	echo "${R} [${W}-${R}]${G}Select browser you want to install"${W}
	echo
	echo "${Y}1. firefox"${W}
	echo
	echo "${Y}2. chromium"${W}
	echo 
	echo "${Y}3. firefox & chromium (both)"${W}
	echo
	read -p "${Y}select an option (Default 1): "${W} answer_browser
	banner
	read -p "${R} [${W}-${R}]${Y}Do you want to install VLC (y/n) "${W} vlc_answer
    banner
    read -p "${R} [${W}-${R}]${Y}Do you want to create a normal user account (y/n) "${W} useradd_answer
    useradd_answer="${useradd_answer:-y}"
    banner
    if [[ "$useradd_answer" == "n" ]]; then
    banner
    echo "${R} [${W}-${R}]${G}Skiping User Account Setup"${W}
    else
    echo "${R} [${W}-${R}]${G}Create user account"${W}
    echo
    while true; do
    read -p "${R} [${W}-${R}]${G}Input username [Lowercase]: "${W} user_name
    echo
    read -p "${R} [${W}-${R}]${G}Input Password: "${W} pass
    echo
    read -p "${R} [${W}-${R}]${Y}Do you want to continue with username ${C}$user_name ${Y}and password ${C}$pass${Y} ? (y/n) : " choice
	choice="${choice:-y}"
    case $choice in
        [yY]* )
            echo "${R} [${W}-${R}]${G}Continuing with username ${C}$user_name ${G}and password ${C}$pass"
            sleep 0.3
            break;;
        [nN]* )
            echo "${G}Skipping useradd step"${W}
            sleep 0.3
            break;;
        * )
            echo "${R}Invalid input. Please enter 'y' or 'n'."${W}
            ;;
    esac
done
    fi
}

function get_sys_info() {
	if [ -f /etc/os-release ]; then
    . /etc/os-release
	if [[ -e "/data/data/com.termux/files/usr/bin/$ID" ]]; then
        rm -rf /data/data/com.termux/files/usr/bin/$ID
    fi
	fi
}

function update_sys() {
	banner
	echo "${R} [${W}-${R}]${G}Updating ${ID}'s System..."
	apt update && apt-get update 
}

function setup_tx11() {
    tx11_answer="tx11_setup_answer"
    if [ "$useradd_answer" = "y" ]; then
    final_user="$user_name"
    else
    final_user="root"
    fi
    if [ "$tx11_answer" == "y" ]; then
cat <<EOF >> "/data/data/com.termux/files/usr/bin/$ID"
termux_x11_pid=\$(pgrep -f /system/bin/app_process.*com.termux.x11.Loader)
xfce_pid=\$(pgrep -f "xfce4-session")
if [ -n "\$termux_x11_pid" ] || [ -n "\$xfce_pid" ]; then
  kill -9 "\$termux_x11_pid" "\$xfce_pid" > /dev/null 2>&1
fi
session_dir="$HOME/.cache/sessions"
if [ -d "\$session_dir" ]; then
    files_to_remove=\$(find "\$session_dir" -type f -name 'x*')
    if [ -n "\$files_to_remove" ]; then
        rm "\$session_dir"/x*
    fi
fi
if [ "\$1" = "-tx11" ]; then
    kill -9 \$(pgrep -f "termux.x11") 2>/dev/null
termux-x11 :0 >/dev/null &
sleep 3
am start --user 0 -n com.termux.x11/com.termux.x11.MainActivity > /dev/null 2>&1
sleep 1
proot-distro login $ID --user $final_user --shared-tmp -- /bin/bash -c "sudo service dbus start && export XDG_CURRENT_DESKTOP="GNOME" && env DISPLAY=:0 gnome-shell --x11"
exit 0
fi
EOF
fi
}

function login() {
	banner
	if [ "$useradd_answer" = "y" ]; then
	useradd -m -s $(which bash) ${user_name}
    echo "${user_name}:${pass}" | chpasswd
	apt install sudo -y
	echo "$user_name ALL=(ALL:ALL) ALL" >> /etc/sudoers
fi
cat <<EOF >> "/data/data/com.termux/files/usr/bin/$ID"
if [ "\$1" = "-remove" ]; then
    proot-distro remove $ID
	rm /data/data/com.termux/files/home/.${ID}-sound-service
	rm \$PREFIX/bin/$ID
elif [ "\$1" = "-r" ]; then
    proot-distro login $ID
elif [ "\$1" = "-vncstart" ]; then
    proot-distro login --user "$final_user" $ID -- /bin/bash -c 'vncstart'
elif [ "\$1" = "-vncstop" ]; then
    proot-distro login --user "$final_user" $ID -- /bin/bash -c 'vncstop'
else
    proot-distro login --user $final_user $ID
fi
EOF
chmod +x /data/data/com.termux/files/usr/bin/$ID 
    clear   
}

function vlc_installer() {
	banner
if [ "$vlc_answer" == "y" ]; then
	echo "${R} [${W}-${R}]${G}Installing vlc.."${W}
    package_install_and_check "vlc"
else
    echo "${R} [${W}-${R}]${C}Canceling Vlc Installation...."${W}
    sleep 1.5
fi
}

function install_chromium() {
	banner
	echo -e "${R} [${W}-${R}]${G} installing chromium..."${W}
	if [ "$ID" == "ubuntu" ]; then
	wget  https://raw.githubusercontent.com/sabamdarif/gnome-in-termux/main/patch/chromium.sh
	bash chromium.sh
	rm chromium.sh
	else
    package_install_and_check "chromium"
	fi
    sed -i 's/chromium %U/chromium --no-sandbox %U/g' /usr/share/applications/chromium.desktop
}

function firefox_install() {
		clear
		banner
		sleep 1
		clear
        echo "${R} [${W}-${R}]${Y} Installing Firefox..."${W}
		echo
		echo
			if [ "$ID" == "ubuntu" ]; then
			wget https://raw.githubusercontent.com/sabamdarif/gnome-in-termux/main/patch/firefox.sh
			bash firefox.sh
			rm firefox.sh
			else
            package_install_and_check "firefox-esr"
		fi
}

function browser_installer() {
	banner
	if [[ ${answer_browser} == "1" ]]; then 
		firefox_install
	elif [[ ${answer_browser} == "2" ]]; then
		install_chromium
	elif [[ ${answer_browser} == "3" ]]; then
		firefox_install
		install_chromium
	elif [[ ${answer_browser} == "" ]]; then 
		firefox_install
	else 
		firefox_install
	fi
}

function install_gnome_core() {
	echo "${R} [${W}-${R}]${G}Installing Gnome Core.."${W}
	sleep 2
    package_install_and_check "gnome-shell gnome-terminal gnome-tweaks gnome-software nautilus gnome-shell-extension-manager"
	clear
}

function install_gnome_full() {
	echo "${R} [${W}-${R}]${G}Installing Gnome Full.."${W}
	sleep 2
	if [ "${ID}" == "ubuntu" ]; then
        package_install_and_check "ubuntu-gnome-desktop gnome-tweaks gnome-software gnome-shell-extension-manager"
    elif [ "${ID}" == "kali" ]; then
        package_install_and_check "kali-desktop-gnome gnome-software gnome-tweaks gnome-shell-extension-manager"
	elif [ "${ID}" == "debian" ]; then
    package_install_and_check "gnome"
    else
	echo "${G}Installing Gnome Core First"${W}
	sleep 1
        install_gnome_core
        package_install_and_check "gnome"
    fi
	clear
}
function package() {
	banner
    echo -e "${R} [${W}-${R}]${C} Checking required packages..."${W}
    apt update
    package_install_and_check "sudo nano wget software-properties-common gnupg2 tigervnc-standalone-server tigervnc-tools dbus-x11"
}

function install_desktop() {
    banner
    if [[ ${answer_desktop} == "1" ]]; then
        install_gnome_full
    elif [[ ${answer_desktop} == "2" ]]; then
        install_gnome_core
    elif [[ ${answer_desktop} == "" ]]; then
        install_gnome_full
    fi
}

function vncstop() {
 if [[ -e "/bin/vncstop" ]]; then
        rm -rf /bin/vncstop
    fi
    cat <<EOF > "/bin/vncstop"
#!/usr/bin/env bash
if [ "\$1" == "-f" ]; then
    pkill Xtigervnc
else
    vncserver -kill :*
fi
rm -rf /.vnc/localhost:*.pid
rm -rf /tmp/.X1-lock
rm -rf /tmp/.X11-unix/X1
EOF
chmod +x /bin/vncstop
}

function vncstart() {
	if [[ -e "/bin/vncstart" ]]; then
        rm -rf /bin/vncstart
    fi
	 cat <<EOF > "/bin/vncstart"
#!/usr/bin/env bash
sudo service dbus start
vncserver -geometry 2580x1080
EOF
    chmod +x /bin/vncstart
}

function vnc() {
banner
   echo -e "${R} [${W}-${R}]${G} Setting up VNC Server..."${W}
 if [[ ! -d "$HOME/.vnc" ]]; then
    mkdir -p "$HOME/.vnc"
fi

if [[ -e "$HOME/.vnc/xstartup" ]]; then
    rm "$HOME/.vnc/xstartup"
fi

touch "$HOME/.vnc/xstartup"
cat << EOF >> "$HOME/.vnc/xstartup"
export XDG_CURRENT_DESKTOP="GNOME"
gnome-shell --x11
EOF

chmod +x "$HOME/.vnc/xstartup"

if [ "$useradd_answer" == "y" ]; then
if [[ ! -d "/home/$user_name/.vnc" ]]; then
    mkdir -p "/home/$user_name/.vnc"
fi
cp $HOME/.vnc/xstartup /home/$user_name/.vnc/
chmod +x /home/$user_name/.vnc/xstartup
echo "$user_name ALL=(ALL) NOPASSWD: /usr/sbin/service dbus start" | sudo tee -a /etc/sudoers
fi
vncstart
vncstop
 echo -e "${R} [${W}-${R}]${C} Fixing Vnc Login Issue.."${W}
   for file in $(find /usr -type f -iname "*login1*"); do rm -rf $file
   done
}

function add_sound() {
	echo -e "\n${R} [${W}-${R}]${C} Fixing Sound Problem..."${W}
    if [[ ! -e "/data/data/com.termux/files/home/.${ID}-sound-service" ]]; then
        touch /data/data/com.termux/files/home/.${ID}-sound-service
    fi
    echo "pulseaudio --start --exit-idle-time=-1" >> /data/data/com.termux/files/home/.${ID}-sound-service
    echo "pacmd load-module module-native-protocol-tcp auth-ip-acl=127.0.0.1 auth-anonymous=1" >> /data/data/com.termux/files/home/.${ID}-sound-service
	echo "$(echo "bash ~/.${ID}-sound-service" | cat - /data/data/com.termux/files/usr/bin/$ID )" > /data/data/com.termux/files/usr/bin/$ID
	echo "export PULSE_SERVER=127.0.0.1" >> /etc/profile
    source /etc/profile
}

function check_firefox() {
    echo "${R} [${W}-${R}]${Y}Checking if Firefox is installed or not...${W}"
    if ! type -p "firefox" &>/dev/null; then
        sleep 2
        echo "${R} [${W}-${R}]${R}Firefox not installed...${W}"
        firefox_install
    else
        echo "${R} [${W}-${R}]${G}Firefox is already installed.${W}"
    fi
}

function check_chromium() {
    echo "${R} [${W}-${R}]${Y}Checking if Chromium is installed or not...${W}"
    if ! type -p "chromium" &>/dev/null; then
        sleep 2
        echo "${R} [${W}-${R}]${R}Chromium is not installed...${W}"
        install_chromium
    else
        echo "${R} [${W}-${R}]${G}Chromium is already installed.${W}"
    fi
}

function check_install() {
    echo "${R} [${W}-${R}]${Y}Checking if everything is installed or not...${W}"
    sleep 1
    # Desktop check
    echo "${R} [${W}-${R}]${Y}Checking if GNOME installed...${W}"
    if ! type -p "gnome-shell" &>/dev/null; then
	sleep 2
        echo "${R} [${W}-${R}]${R}GNOME Desktop is not installed perfectly...${W}"
		echo "${G}Fixing ..."${W}
        sleep 2
        install_desktop
    else
        echo "${R} [${W}-${R}]${G}GNOME Desktop is Installed Successfully...${W}"
        sleep 2
    fi
    # Browser check
    if [[ "${answer_browser}" == "1" ]]; then
        check_firefox
    elif [[ "${answer_browser}" == "2" ]]; then
        check_chromium
    elif [[ "${answer_browser}" == "3" ]]; then
        check_firefox
        check_chromium
    else
        check_firefox
    fi
    # VLC check
    if [[ "${vlc_answer}" == "y" ]]; then
        echo "${R} [${W}-${R}]${Y}Checking if VLC is installed or not...${W}"
        if ! type -p "vlc" &>/dev/null; then
            sleep 2
            echo "${R} [${W}-${R}]${R}VLC is not installed, installing now...${W}"
            apt install vlc -y
        fi
    fi
}

function custom_gnome() {
banner
    echo -e "${G} Install Themes, Icons & Wallpapers"${W}
    git clone https://github.com/vinceliuice/WhiteSur-gtk-theme.git --depth=1
    cd WhiteSur-gtk-theme
    ./install.sh
    git clone https://github.com/vinceliuice/WhiteSur-icon-theme
    cd WhiteSur-icon-theme
    ./install.sh
    git clone https://github.com/vinceliuice/WhiteSur-wallpapers
    cd WhiteSur-wallpapers
    sudo ./install-gnome-backgrounds.sh
    ./install-wallpapers.sh
clear
     echo -e "${G} Install OpenJDK, Python & PyCharm"${W}
     package_install_and_check "openjdk-17-jdk python3-full"
     wget https://download.jetbrains.com/python/pycharm-community-2024.1.3-aarch64.tar.gz
tar -xf pycharm-community-2024.1.3-aarch64.tar.gz
}

function note() {
banner
    echo -e "${G} Successfully Installed !"${W}
    sleep 3
	echo
    echo -e "${G}Now Restart Termux First And Login Into $ID "${W}
	echo
    echo -e "${G}Type ${C}$ID${G} to login into $ID "${W}
	echo
    echo "${C}Check the NOTE (👇) section in Github Readme to know all commands"${W}
    echo
    echo "https://github.com/sabamdarif/gnome-in-termux/blob/main/README.md#note"
    echo
}

check_root
get_sys_info
questions
update_sys
package
setup_tx11
login
install_desktop
browser_installer
vlc_installer
vnc
add_sound
check_install
custom_gnome
note