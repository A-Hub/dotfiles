#!/usr/bin/env sh

###SUCKLESS INSTALL###
clear
echo "install suckless utilities (dwm,dmenu,st,surf) with patches I use?(y/N)"
read input
if [ "$input" = "y" ] || [ "$input" = "Y" ]; then

#clone repos
mkdir ~/repos
mkdir ~/repos/.patches
cd ~/repos
git clone https://git.suckless.org/dwm
git clone https://git.suckless.org/st
git clone https://git.suckless.org/dmenu
git clone https://git.suckless.org/surf

#cd ~/scripts
#git clone https://github.com/joestandring/dwm-bar.git


#DWM patches
mkdir ~/repos/.patches/dwm
cd ~/repos/.patches/dwm


wget dwm.suckless.org/patches/fullgaps/dwm-fullgaps-6.2.diff
wget dwm.suckless.org/patches/alpha/dwm-alpha-20180613-b69c870.diff
#wget dwm.suckless.org/patches/fakefullscreen/dwm-fakefullscreen-20170508-ceac8c9.diff

cd ~/repos/dwm

patch -p1 < ../.patches/dwm/dwm-fullgaps-6.2.diff
patch -p1 < ../.patches/dwm/dwm-alpha-20180613-b69c870.diff
#patch -p1 < ../.patches/dwm/dwm-fakefullscreen-20170508-ceac8c9.diff
rm ~/repos/dwm/config.h

ln -s ~/.config/suckless/dwm-config.h ~/repos/dwm/config.h

sudo make clean install



#ST patches
mkdir ~/repos/.patches/st
cd ~/repos/.patches/st

#wget st.suckless.org/patches/solarized/st-no_bold_colors-0.8.1.diff
#curl st.suckless.org/patches/solarized/st-solarized-dark-20180411-041912a.diff
wget st.suckless.org/patches/alpha/st-alpha-0.8.2.diff

cd ~/repos/st
#patch -p1 < ../.patches/st/st-no_bold_colors-0.8.1.diff
#patch -p1 < ../.patches/st/st-solarized-dark-20180411-041912a.diff
patch -p1 < ../.patches/st/st-alpha-0.8.2.diff

rm ~/repos/st/config.h

ln -s ~/.config/suckless/st-config.h ~/repos/st/config.h
sudo make clean install



#DMENU patches
mkdir ~/repos/.patches/dmenu

rm ~/repos/dmenu/config.h
ln -s ~/.config/suckless/dmenu-config.h ~/repos/dmenu/config.h
sudo make clean install



#Surf patches
mkdir ~/repos/.patches/surf

cd ~/repos/.patches/surf
wget surf.suckless.org/patches/playexternal/surf-playexternal-20190724-b814567.diff
wget surf.suckless.org/patches/popup-on-gesture/surf-popup-2.0.diff

cd ~/repos/surf
patch -p1 < ../.patches/surf/surf-playexternal-20190724-b814567.diff
#patch -p1 < ../.patches/surf/surf-popup-2.0.diff

sudo make clean install

ln -s ~/.local/inits/dwm.sh ~/.xinitrc
fi
