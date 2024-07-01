e# Termux

<details>
<summary><strong> Interactive installation  </strong></summary>

<br>

```
pkg update -y ; pkg install wget -y ; wget https://raw.githubusercontent.com/GiGiDKR/Termux/main/termuxsetup.sh ; bash termuxsetup.sh 

```
</details>

****

<strong> Manual installation  </strong>

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

<br>

## ⚙️ Installing Desktops <a name=installing-desktops></a> 

<details>
<summary><strong> XFCE4 (Debian) </strong></summary>

<br>
<br>

```
proot-distro login debian --user debian
```
```
sudo apt install xfce4 xfce4-terminal
```

</details>



<details>
<summary><strong> GNOME (Ubuntu) </strong></summary>

<br>
<br>

```
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
wget https://raw.githubusercontent.com/LinuxDroidMaster/Termux-Desktops/main/scripts/proot_ubuntu/startgnome_ubuntu.sh
```
```
chmod +x startgnome_ubuntu.sh
mv 
```
</details>

## 💻 Running the Desktops for use with Termux X11 <a name=running-desktops></a>
All the scripts in this repository are prepared to run the different Desktops with audio in an easy way. 

First you need to install the following packages in Termux: 
```
pkg update
pkg install x11-repo
pkg install termux-x11-nightly
pkg install pulseaudio
```

Script for start distro in Termux-X11 (with shortcut for Termux Widget and start with only distro name) : 

<details>

<summary><strong> Debian (XFCE4) </strong></summary>

<br>

```
wget https://raw.githubusercontent.com/GiGiDKR/Termux/main/scripts/proot_debian/startxfce4_debian.sh
```
```
chmod +x startxfce4_debian.sh
mv startxfce4_debian.sh Debian.sh
```
```
mkdir -p /data/data/com.termux/files/home/.shortcuts
chmod 700 -R /data/data/com.termux/files/home/.shortcuts
```
```
cp ~/Debian.sh ~/.shortcuts/Debian.sh
```
```
cp ~/Debian.sh $PREFIX/bin/debian && chmod +x $PREFIX/bin/debian
```
</details>


<details>

<summary><strong> Ubuntu (GNOME) </strong></summary>

<br>

```
wget  https://raw.githubusercontent.com/GiGiDKR/Termux/main/scripts/proot_ubuntu/startgnome_ubuntu.sh
```
```
chmod +x startgnome_ubuntu.sh
mv startgnome_ubuntu.sh Ubuntu.sh
```
```
mkdir -p /data/data/com.termux/files/home/.shortcuts
chmod 700 -R /data/data/com.termux/files/home/.shortcuts
```
```
cp ~/Ubuntu.sh ~/.shortcuts/Ubuntu.sh
```
```
cp ~/Ubuntu.sh $PREFIX/bin/ubuntu && chmod +x $PREFIX/bin/ubuntu
```

</details>

## 🎨 Customizations <a name=customizations></a>


* How to install nerd fonts (this allows you to have icons in the terminal):
```
bash -c  "$(curl -fsSL https://raw.githubusercontent.com/officialrajdeepsingh/nerd-fonts-installer/main/install.sh)"
```

* Whisker menu and MugShot (to improve default desktop default menu) 

```
sudo apt install xfce4-whiskermenu-plugin mugshot
```

* Install icon themes: 
```
apt search icon-theme
sudo apt install moka-icon-theme papirus-icon-theme
```

* Install themes
```
apt search gtk-themes
sudo apt install numix-gtk-theme greybird-gtk-theme
```
```
mkdir ~/.themes
chmod +x ~/.themes
cd ~/.themes
```
```
git clone https://github.com/addy-dclxvi/gtk-theme-collections.git
```
```
rm -rf README.md
rm -rf LICENCE
rm -rf *.jpg
cd ..
mv gtk-theme-collections/* ./
rm -rf gtk-theme-collections
```
```
git clone https://github.com/addy-dclxvi/Xfwm4-Theme-Collections.git
```
```
rm -rf README.md
rm -rf LICENCE
rm -rf *.jpg
cd .. ~/.themes
mv Xfwm4-Theme-Collections/* ./
rm -rf Xfwm4-Theme-Collections
```

* Install alternative dock (bottom panel)
```
sudo apt install plank
```
```
plank --preferences
```

* Install Starship (shell prompt)
```
curl -sS https://starship.rs/install.sh | sh
```
```
starship preset pastel-powerline -o ~/.config/starship.toml
```
```
micro ~/.bashrc
```
Add at the end of .bashrc file :
```
# Custom alias
alias l='ls'
alias ls='ls -la'
alias q='exit'
alias c='clear'

#Set Starship at default prompt
eval "$(starship init bash)"
```

* Install Ulauncher
```
sudo apt update && sudo apt install -y gnupg
gpg --keyserver keyserver.ubuntu.com --recv 0xfaf1020699503176
gpg --export 0xfaf1020699503176 | sudo tee /usr/share/keyrings/ulauncher-archive-keyring.gpg > /dev/null
echo "deb [signed-by=/usr/share/keyrings/ulauncher-archive-keyring.gpg] \
          http://ppa.launchpad.net/agornostal/ulauncher/ubuntu jammy main" \
          | sudo tee /etc/apt/sources.list.d/ulauncher-jammy.list
sudo apt update && sudo apt install ulauncher
```
```
ulauncher
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
rm pycharm-community-2024.1.3-aarch64.tar.gz
mv pycharm-community-2024.1.3 ~/.local/share/
```
* Run Pycharm
```
cd pycharm-community-2024.1.3/bin
bash pycharm.sh
```
* Create desktop launcher
```
echo -e "[Desktop Entry]\nVersion=1.0\nType=Application\nName=Pycharm\nComment=\nExec=bash pycharm.sh\nIcon=pycharm\nPath=/home/debian/.local/share/pycharm-community-2024.1.3/bin\nTerminal=false\nStartupNotify=true" > ~/PyCharm.desktop
```

* Install Chromium
```
sudo apt install chromium
```
```
echo -e "[Desktop Entry]\nVersion=1.0\nName=Chromium Web Browser\nnExec=/usr/bin/chromium %U --no-sandbox\nnTerminal=false\nnX-MultipleArgs=false\nnType=Application\nIcon=chromium\nnCategories=Network;WebBrowser;\nMimeType=text/html;text/xml;application/xhtml_xml;application/x-mimearchive;x-scheme-handler/http;x-scheme-handler/https;\nnStartupWMClass=chromium\nnStartupNotify=true\nnKeywords=browser" > ~/ Chromium.desktop
```
