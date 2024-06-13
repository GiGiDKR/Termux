# Termux
## 🏁 First steps <a name=first-steps></a>
#### Install packages
```
pkg update -y
pkg install root-repo x11-repo -y
pkg upgrade -y
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
termux-setup-storage
```
```
echo -e "allow-external-apps = true\nuse-black-ui = true\nbell-character = ignore\n" > ~/.termux/termux.properties
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

# Add the following line to the file
debian ALL=(ALL:ALL) ALL
```
Check you can execute sudo commands (it should return `root`)
```
sudo whoami 
```  

</details>  

## ⚙️ Installing Desktops <a name=installing-desktops></a> 


```
proot-distro login debian --user debian
```
```
sudo apt install xfce4 xfce4-terminal
```

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
wget https://github.com/GiGiDKR/Termux/blob/main/scripts/proot_debian/startxfce4_debian.sh
```
```
chmod +x startxfce4_debian.sh
./startxfce4_debian.sh
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

WIP :
```
echo 'termux-x11 :1 -xstartup "dbus-launch --exit-with-session xfce4-session"' > $PREFIX/bin/start-termux-x11 && chmod +x $PREFIX/bin/start-termux-x11
```
Now you can start Termux:x11 by running this command :-
```
start-termux-x11
```
Don't worry about warnings and let Termux run the command in background then open Termux:11 app and give it some time to load and Voilà !!!

Note that dbus-launch does not work for some users so you have to do this instead :-
```
echo 'termux-x11 :1 -xstartup "xfce4-session"' > $PREFIX/bin/start-termux-x11 && chmod +x $PREFIX/bin/start-termux-x11
```
And you will be able to start Termux:x11 with start-termux-x11 command.
