#!/usr/bin/env bash
### INSTALL PROGRAMS FROM REPOS ###
 
#update
sudo xbps-install -Suv
sudo xbps-install -S wget curl

#enable repos
#clear
echo "enable nonfree repo?(y/N)"
read input
if [ $input == 'y' ] || [ $input == 'Y' ]; then
    sudo xbps-install -Sy void-repo-nonfree
	sudo xbps-install -Sy unrar
fi

#clear
#echo "enable multilib repo?(y/N)"
#read input
#if [ $input == 'y' ] || [ $input == 'Y' ]; then
#    sudo xbps-install -Sy void-repo-multilib   
#fi

#clear
#echo "enable nonfree multilib repo?(y/N)"
#read input
#if [ $input == 'y' ] || [ $input == 'Y' ]; then
#    sudo xbps-install -Sy void-repo-multilib-nonfree
#fi


#make directories
mkdir ~/documents/
mkdir ~/downloads/
mkdir ~/pictures/
mkdir ~/programs


### install system programs/libraries ###

echo "install basic system utilities and libs I use(xorg, devel reqs for suckless, pulseaudio?(y/N)"
read input
if [ $input == 'y' ] || [ $input == 'Y' ]; then

#install xorg
#sudo xbps-install -Sy xorg xterm
sudo xbps-install -Sy xorg-minimal xrdb xsetroot xterm xprop 

#install devel tools
sudo xbps-install -Sy base-devel make libXft-devel libX11-devel libXinerama-devel patch

#sound programs
sudo xbps-install -Sy alsa-utils apulse pamixer pulsemixer  

#install system tools
sudo xbps-install -Sy feh udevil picom redshift ffmpegthumbnailer ConsoleKit2 apparmor sxhkd dunst scron rsync
sudo xbps-install -Sy gst-libav xdg-utils GConf

# appimage needed this
sudo xbps-install -Sy dbus-glib #nss startup-notification

#void stuff
sudo xbps-install -y outils void-release-keys #provides signify and void release .pub file to verify iso

fi


#tlp for battery management
clear
echo "install tlp for better battery life?(y/N)"
read input
if [ $input == 'y' ] || [ $input == 'Y' ]; then
	sudo xbps-install -Sy tlp
    sudo ln -s /etc/sv/tlp /var/service
fi

#install NetworkManager
#sudo xbps-install -S NetworkManager

clear
echo "install and setup ufw firewall? (y/N)"
read input
if [ $input == 'y' ] || [ $input == 'Y' ]; then
#install and setup firewall
sudo xbps-install -Sy ufw
sudo ufw enable

echo "use my defaults? (deny incoming, allow outgoing, add rules for steam and transmission ) (y/N)"
read input
if [ $input == 'y' ] || [ $input == 'Y' ]; then
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw allow http
sudo ufw allow https
#sudo ufw allow ssh
sudo ufw allow ntp
sudo ufw allow 67:68/tcp
sudo ufw allow 53

#allow torrent client traffic
sudo ufw allow 56881:56889/tcp

#rules to allow steam
sudo ufw allow 27000:27036/udp
sudo ufw allow 27036:27037/tcp
sudo ufw allow 4380/udp
fi

fi

#install nvidia-drivers
clear
echo "install nvidia proprietary drivers? (Y/n)"
read nvidiain

if [ $nvidiain == 'y' ] || [ $nvidiain == 'Y' ]; then

    sudo xbps-install -Sy void-repo-nonfree void-repo-multilib void-repo-multilib-nonfree 
	sudo xbps-install -Sy xf86-video-nouveau nvidia nvidia-libs-32bit
#sudo xbps-install vulkan-loader vulkan-loader-32bit
fi


clear
echo "setup amd graphics drivers?(y/N)"
read amdin

if [ $amdin == 'y' ] || [ $amdin == 'Y' ]; then
#install amd libraries
	#sudo xbps-install -Sy libGL libGL-32bit mesa-ati-dri mesa-ati-dri-32bit
	sudo xbps-install -Sy xf860-video-amdgpu
#sudo xbps-install -S vulkan-loader vulkan-loader-32bit
	sudo xbps-install -Sy radeontop

	sudo ln -s ~/.sysconf/etc/X11/xorg.conf.d/20-amdgpu.conf /etc/X11/xorg.conf.d/

fi

sudo xbps-install -Sy vulkan-loader vulkan-loader-32bit

clear
echo "install flatpak and setup flathub?(y/N)"
read input
if [ $input == 'y' ] || [ $input == 'Y' ]; then
#install flatpak and enable flathub
sudo xbps-install -Sy xdg-desktop-portal xdg-desktop-portal-gtk xdg-user-dirs xdg-user-dirs-gtk xdg-utils
sudo xbps-install -Sy flatpak
sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
fi

#enable usage statistics
clear
echo "enable usage statistics for Void Linux? (y/N)"
read input
if [ $input == 'y' ] || [ $input == 'Y' ]; then
	sudo xbps-install -Sy PopCorn
	sudo ln -s /etc/sv/popcorn /var/service/
fi


### install themes ###

sudo xbps-install -Sy adwaita-icon-theme Adapta gtk-engine-murrine

#install qt for apps that need it
#sudo xbps-install -Sy qt5

#install fonts
sudo xbps-install -Sy freetype
#sudo xbps-install -S noto-fonts-cjk noto-fonts-emoji noto-fonts-ttf noto-fonts-ttf-extra
sudo xbps-install -Sy font-libertine-otf font-inconsolata-otf font-symbola font-hack-ttf nerd-fonts-otf 
sudo xbps-install -Sy ipafont-fonts-otf

#install fish shell
clear
echo "install and use fish shell? (y/N)"
read input
if [ $input == 'y' ] || [ $input == 'Y' ]; then
	sudo xbps-install -Sy fish-shell
	chsh -s /usr/bin/fish $USER
fi

#install zsh shell
clear
echo "install and use zsh? (y/N)"
read input
if [ $input == 'y' ] || [ $input == 'Y' ]; then
	sudo xbps-install -Sy zsh zsh-syntax-highlighting
	chsh -s /bin/zsh $USER
	

    #setup .zprofile and zsh history file
	cd ~
	ln -s ~/.profile ~/.zprofile
	mkdir -p ~/.cache/zsh
	touch ~/.cache/zsh/history

fi



### install user programs ###

clear
echo "install my cli programs? (y/N)"
read input
if [ $input == 'y' ] || [ $input == 'Y' ]; then

#cli programs to isntall
sudo xbps-install -Sy neovim htop curl wget tealdeer ufetch
sudo xbps-install -Sy mpv cmus lf pulsemixer pamixer mtm
sudo xbps-install -Sy ImageMagick jp2a ffmpegthumbnailer #for ascii image previews and video thumbnails in lf
sudo xbps-install -Sy zathura zathura-cb zathura-pdf-mupdf
sudo xbps-install -Sy youtube-viewer youtube-dl
sudo xbps-install -Sy transmission transmission-remote-cli
sudo xbps-install -Sy trackma

sudo xbps-install -Sy termdown spt
#install vim plug for neovim
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi


clear
echo "install my gui programs?(y/N)"
read input
if [ $input == 'y' ] || [ $input == 'Y' ]; then
#gui programs to install
sudo xbps-install -Sy lxappearance #firefox #gnome-disk-utility  
fi

#gaming
#echo "install wine, steam and lutris for gaming? (y/N)"
#read input
#if [ $input == 'y' ] || [ $input == 'Y' ]; then
#sudo xbps-install -Sy libpulseaudio-32bit libtxc_dxtn-32bit fontconfig-32bit libavcodec-32bit libavformat-32bit libavresample-32bit libavutil-32bit 
#sudo xbps-install -Sy lutris
#sudo xbps-install -Sy wine-32bit libwine-32bit wine-gecko wine-mono winetricks protontricks
#sudo xbps-install mono #stardew valley (smapi)
#fi


#development
#sudo xbps-install -Sy ncurses-devel mdBook tcc

#Haskell
#sudo xbps-install -Sy ghc cabal-install stack
#sudo ln -s /lib/libncurses.so.6.1 /lib/libtinfo.so.6

#sudo xbps-install -Sy lua love luarocks

#muttwizard
sudo xbps-install -Sy neomutt isync msmtp pass urlview


### SYSTEM SETUP ### 

### setup services ###
sudo ln -s /etc/sv/dbus /var/service
sudo ln -s /etc/sv/cgmanager /var/service/
sudo ln -s /etc/sv/consolekit /var/service/

### set limits.conf for esync
sudo sh -c "echo '$USER hard nofile 524288' >> /etc/security/limits.conf"


### modify udevil config to add exec to mount options
sudo sed -i 's/^allowed_options .*$/&, exec/g' /etc/udevil/udevil.conf

echo "create modified hosts file from someonewhocares.org?\n do this at any time by running the ~/scripts/update-hosts script (y/N)"
read input
if [ $input == 'y' ] || [ $input == 'Y' ]; then
	cd ~/scripts/
	~/scripts/update-hosts
fi



#add directories if they dont exist
sudo mkdir /etc/X11/xorg.conf.d/


echo "disable mouse acceleration? (y/N)"
read input
if [ $input == 'y' ] || [ $input == 'Y' ]; then
	sudo ln -s ~/.config/.sysconf/etc/X11/xorg.conf.d/50-mouse-acceleration.conf /etc/X11/xorg.conf.d/
fi

#suckless dependancies
sudo xbps-install -S base-devel make libXft-devel libX11-devel libXinerama-devel patch

#surf dependancies
sudo xbps-install -S gtk+-devel webkit2gtk-devel gcr-devel


sh ~/.local/installers/suckless-install.sh
