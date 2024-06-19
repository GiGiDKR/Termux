# Termux
## 🏁 First steps <a name=first-steps></a>
#### Install packages
```
pkg update -y
pkg install root-repo x11-repo -y
pkg upgrade -y
```
```
termux-setup-storage
```
```
echo -e "allow-external-apps = true\nuse-black-ui = true\nbell-character = ignore\n" > ~/.termux/termux.properties
```
```
pkg install wget git micro python fish -y
```
```
pip install qobuz-dl
```
```
fish -c "curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher"
fish -c "fisher install IlanCosman/tide@v6"
```
```
echo fish | tee -a /etc/shells
chsh -s fish
```
```
fish -c "set -U fish_greeting"
```
```
echo -e "if status is-interactive\n# Commands to run in interactive sessions can go here\nend\n\nabbr -a l ls\nabbr -a q exit\nabbr -a c clear\nabbr -a ls ls -la\n" > ~/.config/fish/config.fish
```
```
rm /data/user/0/com.termux/files/usr/etc/motd
```
```
fish -c "tide configure"
```



#### Install proot-disto

```
pkg update
pkg install proot-distro
```
Install Debian (or the distor you prefer)
```
proot-distro install debian
```
Log in to the distro 
```
proot-distro login debian
```

#### Create an user with sudo privileges

Install needed packages
```
apt update -y
apt install sudo micro adduser -y
```
Create an user
```
adduser debian
```
Give the user sudo privileges
```
micro /etc/sudoers
```
Add the following line to the file
```
debian ALL=(ALL:ALL) ALL
```
Check you can execute sudo commands (it should return `root`)
```
sudo whoami 
```  

</details>  


## ⬇️ Download scripts easily: <a name=easy-download-ubuntu-proot></a> 
* startgnome_ubuntu.sh
```
wget https://raw.githubusercontent.com/LinuxDroidMaster/Termux-Desktops/main/scripts/proot_ubuntu/startgnome_ubuntu.sh
```

<br>

## ⚙️ Installing Desktops <a name=installing-desktops></a> 

<br>


```
proot-distro login debian --user debian
```
```
sudo apt install xfce4 xfce4-terminal
```


<details>
<summary><strong> GNOME </strong></summary>

<br>
<br>


```
# Commands: 
proot-distro login ubuntu --user droidmaster
```
```
sudo apt install dbus-x11 ubuntu-desktop -y
```
Run this command after it finishes: 
```
for file in $(find /usr -type f -iname "*login1*"); do rm -rf $file
done
```
Disable snapd as it doesn't work on Termux
```
cat <<EOF | sudo tee /etc/apt/preferences.d/nosnap.pref
# To prevent repository packages from triggering the installation of Snap,
# this file forbids snapd from being installed by APT.
# For more information: https://linuxmint-user-guide.readthedocs.io/en/latest/snap.html
Package: snapd
Pin: release a=*
Pin-Priority: -10
EOF
```

Install firefox: 
```
sudo add-apt-repository ppa:mozillateam/ppa
sudo apt-get update
sudo apt-get install firefox-esr
```

Now you can run Ubuntu with GNOME UI from the script I left in the `Download scripts easily` section: 
```
chmod +x startgnome_ubuntu.sh
./startgnome_ubuntu.sh
```
</details
## 💻 Running the Desktops for use with Termux X11 <a name=running-desktops></a>
All the scripts in this repository are prepared to run the different Desktops with audio in an easy way. 

First you need to install the following packages in Termux: 
```
pkg update
pkg install x11-repo
pkg install termux-x11-nightly
pkg install pulseaudio
```

Then, you just need to download the script corresponding to the Desktop you have installaded, give it permissions to execute it and run it (in Termux, not in proot-distro): 

```
wget https://raw.githubusercontent.com/GiGiDKR/Termux/main/scripts/proot_debian/startxfce4_debian.sh
```
```
chmod +x startxfce4_debian.sh
./startxfce4_debian.sh
```
Start Debian with debian command
```
cp ~/startxfce4_debian.sh $PREFIX/bin/debian && chmod +x $PREFIX/bin/debian
```
Create shortcut Debian 
```
mkdir -p /data/data/com.termux/files/home/.shortcuts
chmod 700 -R /data/data/com.termux/files/home/.shortcuts
```
```
cp ~/startxfce4_debian.sh ~/.shortcuts/Debian.sh
```

## 🎨 Customizations <a name=customizations></a>


* How to install nerd fonts (this allows you to have icons in the terminal):
```
bash -c  "$(curl -fsSL https://raw.githubusercontent.com/officialrajdeepsingh/nerd-fonts-installer/main/install.sh)"
```

* Whisker menu and MugShot (to improve default desktop default menu) 

```
sudo apt install xfce4-whiskermenu-plugin
```
```
sudo apt install mugshot
```

* Install icon themes: 
```
apt search icon-theme
sudo apt install moka-icon-theme
```

* Install GTK themes (system themes)
```
apt search gtk-themes
sudo apt install numix-gtk-theme greybird-gtk-theme
```

* Install alternative dock (bottom panel)
```
sudo apt install plank
```
```
plank --preferences
```

* Install Conky (desktop widgets)
```
sudo apt install conky-all
```

<details>
<summary><strong>One command</summary></strong></summary>
  
```
sudo apt install xfce4-whiskermenu-plugin mugshot moka-icon-theme numix-gtk-theme greybird-gtk-theme plank conky-all -y
```
</details>

## Pycharm <a name=pycharm></a>

* Install Java
```
sudo apt install openjdk-17-jdk
```
* Install Python
```
sudo apt install python3-full
```
* Download and install Pycharm
```
wget https://download.jetbrains.com/python/pycharm-community-2024.1.3-aarch64.tar.gz
```
```
tar -xf pycharm-community-2024.1.3-aarch64.tar.gz
```
* Run Pycharm
```
cd pycharm-community-2024.1.3/bin
bash pycharm.sh
```
* Create desktop lancer
```
echo -e "[Desktop Entry]\nVersion=1.0\nType=Application\nName=Pycharm\nComment=\nExec=bash pycharm.sh\nIcon=pycharm\nPath=/home/debian/pycharm-community-2024.1.3/bin\nTerminal=false\nStartupNotify=false" > ~/Desktop/PyCharm.desktop
```



# 📚 Index

## PROOT-DISTRO (🟠 UBUNTU)
* 🏁 [First steps](#first-steps-ubuntu-proot)
* ⬇️ [Download scripts to run the desktops](#easy-download-ubuntu-proot)
* ⚙️ [Installing Desktops](#installing-desktops-ubuntu-proot)

<br>

---  
---  

<br>

## 🏁 First steps <a name=first-steps-ubuntu-proot></a>

> [!NOTE]  
> All the process is described in more detail in this [video](https://www.youtube.com/watch?v=_vxhzSG2zVQ).

First you need to install the following packages in Termux: 
```
pkg update
pkg install x11-repo
pkg install termux-x11-nightly
pkg install pulseaudio
pkg install proot-distro
```

Then install Ubuntu and login once it finishes: 
```
proot-distro install ubuntu
proot-distro login ubuntu
```

Update repositories and install any package you want: 
```
apt update 
apt upgrade

apt install sudo nano adduser -y
```

---  
<br>

>  

<br>

<details>
<summary><strong> Other desktosp (XFCE4, Mate, LXDE, etc) </strong></summary>
<br>

Follow the same [installation steps](https://github.com/LinuxDroidMaster/Termux-Desktops/blob/main/Documentation/proot/debian_proot.md#installing-desktops) as for Debian.

</details>  

---  
  

