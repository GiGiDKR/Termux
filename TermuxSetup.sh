#!/data/data/com.termux/files/usr/bin/bash
R="$(printf '\033[1;31m')"
G="$(printf '\033[1;32m')"
Y="$(printf '\033[1;33m')"
W="$(printf '\033[0m')"
C="$(printf '\033[1;36m')"

banner() {
    clear
printf "\033[33m╭━━━━╮\033[0m\n"
printf "\033[33m┃╭╮╭╮┃\033[0m\n"
printf "\033[33m╰╯┃┃┣┻━┳━┳╮╭┳╮╭┳╮╭╮\033[0m\n"
printf "\033[33m╱╱┃┃┃┃━┫╭┫╰╯┃┃┃┣╋╋╯\033[0m\n"
printf "\033[33m╱╱┃┃┃┃━┫┃┃┃┃┃╰╯┣╋╋╮\033[0m\n"
printf "\033[33m╱╱╰╯╰━━┻╯╰┻┻┻━━┻╯╰╯\033[0m\n"
echo "${C}${BOLD} Full customized Termux setup with optionnal Linux environment"${W}
echo                                                   
}

package_install_and_check() {
	packs_list=($@)
	for package_name in "${packs_list[@]}"; do
    echo "${R}[${W}-${R}]${G}${BOLD} Installing package: ${C}$package_name "${W}
    pkg install "$package_name" -y >/dev/null
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

initial_setup() {
    banner
    echo "${R} [${W}-${R}]${G} Updating Termux... "${W}
    echo
    pkg update -y >/dev/null
    clear
    echo "${R} [${W}-${R}]${G} Setting Up Storage... "${W}
    termux-setup-Storage
    clear
    echo "${R} [${W}-${R}]${G} Installling Required Packages... "${W}
    package_install_and_check "wget git micro python"
    clear
    echo "${R} [${W}-${R}]${G} Configure Termux properties... "${W}
    echo -e "allow-external-apps = true\nuse-black-ui = true\nbell-character = ignore\n" > ~/.termux/termux.properties

questions_customized() {
    banner
    echo
	  read -p "${Y}Do you want to setup Fish shell with Tide prompt(y/n): "${W} answer_customized
}

customized() {
    if [ "$answer_customized" == "y" ]; then
    clear
    banner
    echo "${G}Setup Fish and Tide "${W}
    echo
    package_install_and_check "fish"
    fish -c "curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher"
    fish -c "fisher install IlanCosman/tide@v6"
    echo fish | tee -a /etc/shells
    chsh -s fish
    fish -c "set -U fish_greeting"
    echo -e "if status is-interactive\n# Commands to run in interactive sessions can go here\nend\n\nabbr -a l ls\nabbr -a q exit\nabbr -a c clear\nabbr -a ls ls -la\n" > ~/.config/fish/config.fish
    rm /data/user/0/com.termux/files/usr/etc/motd
    fish -c "tide configure"
    fi
}

questions_prootdistro() {
	banner
	echo 
	echo "${R} [${W}-${R}]${G} Select Distro "${W}
	echo
	echo "${Y}1. Debian (Default)"${W}
	echo
	echo "${Y}2. Ubuntu"${W}
	echo
    echo "${Y}3. Kali"${W}
    echo
    echo "${Y}4. Pardus"${W}
	echo
	read -p "${Y}select a distro: "${W} answer_distro
	echo
    banner
    read -p "${R} [${W}-${R}]${Y}Do you want to setup termux-x11(y/n) "${W} tx11_answer
}

basic_task() {
    banner
    echo "${R} [${W}-${R}]${G} Updating Termux... "${W}
    echo
    pkg update -y >/dev/null
    clear
    echo "${R} [${W}-${R}]${G} Installling Required Packages... "${W}
    package_install_and_check "proot proot-distro pulseaudio"
}

install_distro() {
    banner
    if [[ ${answer_distro} == "1" ]]; then
        proot-distro install debian
    elif [[ ${answer_distro} == "2" ]]; then
        proot-distro install ubuntu
    elif [[ ${answer_distro} == "3" ]]; then
    echo "${R} [${W}-${R}]${G} Uses Modded-Kali Script To Install Kali In Termux..."${W}
    sleep 0.5
    wget -O kaliinstaller.sh https://raw.githubusercontent.com/sabamdarif/modded-kali/main/setup.sh ; bash kaliinstaller.sh 
    rm kaliinstaller.sh
    elif [[ ${answer_distro} == "4" ]]; then
        proot-distro install pardus
    else
        proot-distro install debian
    fi
}

setup_tx11() {
    if [ "$tx11_answer" == "y" ]; then
    banner
    echo "${G}Setup Termux:X11 "${W}
    echo
    package_install_and_check "x11-repo termux-x11-nightly"
    sed -i 's/tx11_setup_answer/y/g' $HOME/gnome-installer.sh
    fi
}

setup_installer() {
    banner
    distro_path="/data/data/com.termux/files/usr/var/lib/proot-distro/installed-rootfs"
    echo "${G} Setup Installer... "${W}
    cd ~
   wget -O $HOME/gnome-installer.sh https://raw.githubusercontent.com/GiGiDKR/Termux/main/install-gnome-desktop.sh
    setup_tx11
    if [[ ${answer_distro} == "1" ]]; then
       mv gnome-installer.sh $distro_path/debian/root
        proot-distro login debian -- /bin/sh -c 'bash gnome-installer.sh'
    elif [[ ${answer_distro} == "2" ]]; then
        mv gnome-installer.sh $distro_path/ubuntu/root
        proot-distro login ubuntu -- /bin/sh -c 'bash gnome-installer.sh'
    elif [[ ${answer_distro} == "3" ]]; then
        mv gnome-installer.sh $distro_path/kali/root
        proot-distro login kali -- /bin/sh -c 'bash gnome-installer.sh'
    elif [[ ${answer_distro} == "4" ]]; then
    wget $HOME/gnome-installer.sh https://raw.githubusercontent.com/sabamdarif/gnome-in-termux/main/install-gnome-pardus-desktop
    setup_tx11
        mv gnome-installer.sh $distro_path/pardus/root
        proot-distro login pardus -- /bin/sh -c 'bash gnome-installer.sh'
    else 
        mv gnome-installer.sh $distro_path/debian/root
        proot-distro login debian -- /bin/sh -c 'bash gnome-installer.sh'
    fi
}

initial_setup
questions_customized
customized
questions_prootdistro
basic_task
install_distro
setup_installer

