# Termux
## 🏁 First steps <a name=first-steps></a>
### Install proot-disto

1. Open Termux
2. Install proot-distro  
```
pkg update
pkg install proot-distro
```
3. Install Debian (or the distor you prefer)
```
proot-distro install debian
```
4 Log in to the distro 
```
proot-distro login debian
```

### Create an user with sudo privileges

The steps are described in the video linked in the previous point. 

1. Install needed packages
```
apt update -y
apt install sudo micro adduser -y
```
2. Create an user
```
adduser droidmaster
```
3. Give the user sudo privileges
```
micro /etc/sudoers

# Add the following line to the file
droidmaster ALL=(ALL:ALL) ALL
```
4. Check you can execute sudo commands (it should return `root`)
```
sudo whoami 
```  

</details>  

# ⚙️ Installing Desktops <a name=installing-desktops></a> 

# Commands: 

```
proot-distro login debian --user droidmaster
```
```
sudo apt install xfce4
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
