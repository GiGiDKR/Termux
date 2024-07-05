# TERMUX Custom🖌 

###### Work in progress
# 🏁 First steps <a name=first-steps></a>
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
echo -e "allow-external-apps = true\nuse-black-ui = true\nbell-character = ignore\n\nextra-keys = [['ESC','/','-','HOME','UP','END','PGUP'],['TAB','CTRL','ALT','LEFT','DOWN','RIGHT','PGDN']]" >> ~/.termux/termux.properties; termux-reload-settings;
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
echo -e "# Custom alias\nabbr -a l ls\nabbr -a ls ls -a\nabbr -a q exit\nabbr -a c clear\nabbr -a update "pkg update -y && pkg upgrade -y"\nabbr -a upd "pkg update -y"\nabbr -a upg "pkg upgrade -y"\nabbr -a in pkg install\nabbr -a un pkg uninstall\nabbr -a py python!\nabbr -a pipin "pip install --upgrade"\nabbr -a m micro\nabbr -a s source\aabbr -a ex exec\nabbr -a f fish\nabbr -a b bash\nabbr -a md mkdir\nabbr -a alias "micro ~/.config/fish/config.fish"\nabbr -a conf "cd ~/.config"\nabbr -a "?" pwd\nabbr -a ip ifconfig\nabbr -a termux "micro ~/.termux/termux.properties"\nabbr -a venv "source ./venv/bin/activate.fish"" >> ~/.config/fish/config.fish; exec fish;
```

Delete message at startup 
```
rm /data/user/0/com.termux/files/usr/etc/motd; fish -c "set -U fish_greeting";
```

Configure Tide with : `fish -c "tide configure"`


#### Install proot-disto

```
pkg update
pkg install proot-distro
```
Install Debian (or other distro)
```
proot-distro install debian
```
Log in to the distro 
```
proot-distro login debian
```

#### Create user with sudo privileges

Install needed packages
```
apt update -y
apt install sudo micro adduser -y
```
Create an user
```
adduser admin
```
Give the user sudo privileges
```
micro /etc/sudoers
```
Add the following line to the file
```
admin ALL=(ALL:ALL) ALL
```
Check you can execute sudo commands
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
proot-distro login debian --user admin
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

<br>

*****

<details>
<summary><strong> Interactive installation  </strong></summary>
<br>

```
pkg update -y ; pkg install wget -y ; wget https://raw.githubusercontent.com/GiGiDKR/Termux/main/termuxsetup.sh ; bash termuxsetup.sh 

```
</details>

*****
<br>


## 💻 Running the Desktops for use with Termux X11 <a name=running-desktops></a>
All the scripts in this repository are prepared to run the different Desktops with audio in an easy way. 


### Install Termux-X11

```
wget https://github.com/termux/termux-x11/releases/download/nightly/app-arm64-v8a-debug.apk
mv app-arm64-v8a-debug.apk $HOME/storage/downloads/
termux-open $HOME/storage/downloads/app-arm64-v8a-debug.apk
```

You need to install the following packages in Termux: 
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

<br>

## 🎨 Customizations <a name=customizations></a>

### Fonts and Themes

* How to install nerd fonts (this allows you to have icons in the terminal):
```
bash -c  "$(curl -fsSL https://raw.githubusercontent.com/officialrajdeepsingh/nerd-fonts-installer/main/install.sh)"
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
cd gtk-theme-collections
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
cd Xfwm4-Theme-Collections
rm -rf README.md
rm -rf LICENCE
rm -rf *.jpg
cd ..
mv Xfwm4-Theme-Collections/* ./
rm -rf Xfwm4-Theme-Collections
```

### Panel and Status bar

* Whisker menu and MugShot (to improve default desktop default menu) 

```
sudo apt install xfce4-whiskermenu-plugin mugshot
```

* Install status bar
```
sudo apt install polybar
```

* Install alternative dock (bottom panel)
```
sudo apt install plank
```
Configure with : `plank --preferences`

### Shell

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
alias install='sudo apt install'
alias upgrade='sudo apt upgrade'
alias update='sudo apt update'
alias remove='sudo apt remove'

#Set Starship at default prompt
eval "$(starship init bash)"
```

* Install Fish (alternatve shell) and Tide (Fish prompt)

```
fish -c "curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher"
fish -c "fisher install IlanCosman/tide@v6"
```
```
fish -c "set -U fish_greeting"
```
```
echo -e "if status is-interactive\n# Commands to run in interactive sessions can go here\nend\n\nabbr -a l ls\nabbr -a q exit\nabbr -a c clear\nabbr -a ls ls -la\n" > ~/.config/fish/config.fish
```
Configure Tide with : `fish -c "tide configure"`

### Launcher

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

Start with : `ulauncher`

* Install Rofi

```bash
apt install rofi
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

<br>

## 🖥️ Softwares <a name=softwrarse></a>

### Pycharm

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
tar -xf pycharm-community-2024.1.3-aarch64.tar.gz
```
```
rm pycharm-community-2024.1.3-aarch64.tar.gz
mv pycharm-community-2024.1.3 ~/.local/share/
```

* Create desktop launcher
```
echo -e "[Desktop Entry]\nVersion=1.0\nType=Application\nName=Pycharm\nComment=\nExec=bash pycharm.sh\nIcon=pycharm\nPath=$HOME/.local/share/pycharm-community-2024.1.3/bin\nTerminal=false\nStartupNotify=true" > $HOME/Desktop/pycharm.desktop
chmod +x $HOME/Desktop/pycharm.desktop
mv $HOME/Desktop/pycharm.desktop $HOME/../usr/share/applications
```

### Web Browser

* Install Chromium
```
sudo apt install chromium
echo -e "[Desktop Entry]\nVersion=1.0\nName=Chromium Web Browser\nnExec=/usr/bin/chromium %U --no-sandbox\nnTerminal=false\nnX-MultipleArgs=false\nnType=Application\nIcon=chromium\nnCategories=Network;WebBrowser;\nMimeType=text/html;text/xml;application/xhtml_xml;application/x-mimearchive;x-scheme-handler/http;x-scheme-handler/https;\nnStartupWMClass=chromium\nnStartupNotify=true\nnKeywords=browser" > $HOME/chromium.desktop
mv $HOME/Desktop/chromium.desktop $HOME/../usr/share/applications
```

* Install Firefox 
```
sudo apt install firefox-esr firefox-esr-l10n-fr
```

-----

# TERMUX native desktop 

```
pkg update -y
pkg install x11-repo -y
pkg install termux-x11-nightly -y
pkg install pulseaudio -y
```
```
pkg install xfce4 -y
```
```
pkg install tur-repo -y
pkg install chromium -y
```
```
pkg install tur-repo -y
pkg install code-oss -y
```
```
pkg install polybar -y
cp $HOME/../usr//etc/polybar/config.ini ~/.config/polybar/config.ini
```
```
pkg install rofi -y
```



## ⬇️ Download scripts: <a name=easy-download-termux></a> 
```
pkg install wget -y
wget https://raw.githubusercontent.com/LinuxDroidMaster/Termux-Desktops/main/scripts/termux_native/startxfce4_termux.sh
```
```
chmod +x ~/startxfce4_termux.sh
mv ~/startxfce4_termux.sh ~/TermuxDesktop.sh
```
```
mkdir -p /data/data/com.termux/files/home/.shortcuts
chmod 700 -R /data/data/com.termux/files/home/.shortcuts
```
```
cp ~/TermuxDesktop.sh ~/.shortcuts/TermuxDesktop.sh
```
```
cp ~/TermuxDesktop.sh $PREFIX/bin/debian && chmod +x $PREFIX/bin/termuxdesktop
```

## ⬇️ Setup folders
```
mkdir $HOME/Desktop
mkdir $HOME/Templates
mkdir $HOME/Public
mkdir $HOME/Pictures
mkdir $HOME/Videos
```
```
termux-setup-storage
```
```
ln -s $HOME/storage/music Music
ln -s $HOME/storage/document Documents
ln -s $HOME/storage/downloads Downloads
```
