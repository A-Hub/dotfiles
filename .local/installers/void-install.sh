#!/usr/bin/env bash
### INSTALL PROGRAMS FROM REPOS ###
 
#update
sudo xbps-install -Suv
sudo xbps-install -S wget curl

#enable repos
#clear
echo "enable nonfree repo?(y/N)"
read NONFREE 
if [ "$NONFREE" = "y" ]; then
    sudo xbps-install -Sy void-repo-nonfree
fi

clear
echo "enable multilib repo?(y/N)"
read MULTILIB 
if [ "$MULTILIB" = "y" ]; then
    sudo xbps-install -Sy void-repo-multilib   
fi

clear
echo "enable nonfree multilib repo?(y/N)"
read NFMULTILIB 
if [ "$NFMULTILIB" == "y" ]; then
    sudo xbps-install -Sy void-repo-multilib-nonfree
fi


#make directories
mkdir ~/docs/
mkdir ~/dl/
mkdir ~/media/
mkdir -p ~/.local/share/gnupg/
mkdir -p ~/.config/mpd/playlists
sudo mkdir -p /etc/X11/xorg.conf.d/


### install system programs/libraries ###

echo "install basic system utilities and libs I use(xorg, devel reqs for suckless, pulseaudio?(y/N)"
read input
if [ $input == 'y' ] || [ $input == 'Y' ]; then

#install xorg
#sudo xbps-install -Sy xorg xterm
sudo xbps-install -Sy xorg-minimal xrdb xsetroot xterm xprop xrandr xclip xkill 

#sound programs
sudo xbps-install -Sy alsa-utils apulse #pulseaudio pulsemixer 

#install system tools
sudo xbps-install -Sy freetype apparmor elogind gst-libav xdg-utils GConf wget curl chrony #ConsoleKit2 

["$NONFREE" = "y" ] && sudo xbps-install -Sy unrar


sudo xbps-install -Sy feh udevil picom redshift ffmpegthumbnailer sxhkd dunst scron rsync


# appimage needed this
sudo xbps-install -Sy dbus-glib #nss startup-notification

#void stuff
sudo xbps-install -Sy outils void-release-keys #provides signify and void release .pub file to verify iso

fi


#tlp for battery management
clear
echo "install tlp for better battery life?(y/N)"
read input
if [ $input == 'y' ] || [ $input == 'Y' ]; then
	sudo xbps-install -Sy tlp
    sudo ln -s /etc/sv/tlp /var/service
fi

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

sudo ufw enable
fi

fi

#install nvidia-drivers
clear
echo "install nvidia proprietary drivers? (Y/n)"
read nvidiain

if [ $nvidiain == 'y' ] || [ $nvidiain == 'Y' ]; then

    sudo xbps-install -Sy void-repo-nonfree void-repo-multilib void-repo-multilib-nonfree 
	sudo xbps-install -Sy xf86-video-nouveau nvidia nvidia-libs-32bit
    sudo xbps-install vulkan-loader vulkan-loader-32bit
fi


clear
echo "setup amd graphics drivers?(y/N)"
read amdin

if [ $amdin == 'y' ] || [ $amdin == 'Y' ]; then
#install amd libraries
	sudo xbps-install -Sy xf86-video-amdgpu mesa-vulkan-radeon
	sudo xbps-install -Sy radeontop

    sudo mkdir -p /etc/X11/xorg.conf.d/
	sudo ln -s ~/.sysconf/etc/X11/xorg.conf.d/20-amdgpu.conf /etc/X11/xorg.conf.d/

fi

clear
echo "setup intel graphics drivers?(y/N)"
read intelin

if [ $intelin == 'y' ] || [ $intelin == 'Y' ]; then
	sudo xbps-install -Sy xf86-video-intel mesa-dri intel-video-accel	
	sudo ln -s ~/.config/.sysconf/etc/X11/xorg.conf.d/20-intel.conf /etc/X11/xorg.conf.d

	#to fix issues running steam
	#xi -S vulkan-loader vulkan-loader-32bit mesa-dri mesa-dri-32bit

fi

sudo xbps-install -Sy vulkan-loader

[ "$MULTILIB" = "y" ] && sudo xbps-install -Sy vulkan-loader-32bit

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

###themes and fonts
#most themes are stored in my dotfiles repo
#sudo xbps-install -S nerd-fonts-otf


### install user programs ###

clear
echo "install my cli programs? (y/N)"
read input
if [ $input == 'y' ] || [ $input == 'Y' ]; then

#cli programs to isntall
sudo xbps-install -Sy neovim htop 
#pulsemixer pamixer
sudo xbps-install -Sy mpv mpd ncmpcpp mpc #cmus cmus-ffmpeg cava  #audio cava -> console audio visualizer for alsa 
sudo xbps-install -Sy lf mtm  #file browser terminal multiplexor 
sudo xbps-install -Sy ImageMagick ffmpegthumbnailer viu #jp2a #for ascii image previews and video thumbnails in lf
sudo xbps-install -Sy zathura zathura-cb zathura-pdf-mupdf #pdfs manga
sudo xbps-install -Sy youtube-dl #download youtube videos
sudo xbps-install -Sy transmission transmission-remote-cli  #torrents
sudo xbps-install -Sy pywal #generate themes from pictures
sudo xbps-install -Sy tealdeer ufetch termdown  # misc utils
sudo xbps-install -Sy scrot newsboat
#sudo xbps-install -Sy trackma

fi

clear
echo "install my gui programs? (y/N)"
read input
if [ $input == 'y' ] || [ $input == 'Y' ]; then
    sudo xbps-install -Sy luakit
fi

clear
echo "install gaming programs(wine lutris steam)? (y/N)"
echo "this will enable nonfree repos"
read input
if [ $input == 'y' ] || [ $input == 'Y' ]; then
    sudo xbps-install -Sy void-repo-nonfree void-repo-multilib void-repo-multilib-nonfree 
	sudo xbps-install -Sy wine-32bit wine-gecko wine-mono winetricks protontricks 
	sudo xbps-install -Sy lutris steam
	sudo xbps-install -Sy libdrm-32bit
fi

#Haskell
#sudo xbps-install -Sy ghc cabal-install stack
#sudo ln -s /lib/libncurses.so.6.1 /lib/libtinfo.so.6

#my devel
#sudo xbps-install -Sy base-devel make gcc gdb 

#sudo xbps-install -Sy lua love luarocks

#muttwizard
clear
echo "install muttwizard dependencies? (y/N)"
read input
if [ $input == 'y' ] || [ $input == 'Y' ]; then
	sudo xbps-install -Sy neomutt isync msmtp pass urlview lynx
fi

### SYSTEM SETUP ### 

### setup services ###
sudo ln -s /etc/sv/dbus /var/service
#sudo ln -s /etc/sv/cgmanager /var/service/
sudo ln -s /etc/sv/elogind /var/service/
sudo ln -s /etc/sv/chronyd /var/service/

### set limits.conf for esync
sudo sh -c "echo '$USER hard nofile 524288' >> /etc/security/limits.conf"


### modify udevil config to add exec to mount options
sudo sed -i 's/^allowed_options .*$/&, exec/g' /etc/udevil/udevil.conf

echo "create modified hosts file from someonewhocares.org?\n do this at any time by running the ~/scripts/update-hosts script (y/N)"
read input
if [ $input == 'y' ] || [ $input == 'Y' ]; then
	cd ~/.local/scripts/
	~/.local/scripts/update-hosts
fi


echo "disable mouse acceleration? (y/N)"
read input
if [ $input == 'y' ] || [ $input == 'Y' ]; then
	sudo ln -s ~/.config/.sysconf/etc/X11/xorg.conf.d/50-mouse-acceleration.conf /etc/X11/xorg.conf.d/
fi

###suckless-install.sh dependancies
sudo xbps-install -S base-devel make libXft-devel libX11-devel libXinerama-devel patch

  #surf dependencies
sudo xbps-install -S gtk+-devel webkit2gtk-devel gcr-devel

  #straw-viewer dependencies
sudo xbps-install -S perl-Module-Build


echo "change mirror to alpha.us.voidlinux.org? (y/N)"
read input
if [ $input == 'y' ] || [ $input == 'Y' ]; then
	sudo mkdir -p /etc/xbps.d
	sudo cp /usr/share/xbps.d/*-repository-*.conf /etc/xbps.d/
	sudo sed -i 's|https://alpha.de.repo.voidlinux.org|https://alpha.us.repo.voidlinux.org|g' /etc/xbps.d/*-repository-*.conf
	sudo xbps-install -S
fi


sh ~/.local/installers/suckless-install.sh
