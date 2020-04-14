#!/usr/bin/env sh

###SUCKLESS INSTALL###
mkdir -p ~/devel/repos/

git clone https://github.com/A-Hub/dwm.git ~/devel/repos/dwm
git clone https://github.com/A-Hub/dmenu.git ~/devel/repos/dmenu
git clone https://github.com/A-Hub/st.git ~/devel/repos/st
git clone https://github.com/A-Hub/surf.git ~/devel/repos/surf

cd ~/devel/repos/dwm
sudo make clean install

cd ~/devel/repos/dmenu
sudo make clean install

cd ~/devel/repos/st
sudo make clean install

cd ~/devel/repos/surf
sudo make clean install

#Straw-viewer install (view youtube videos in cli)
cd ~/devel/repos/straw-viewer
perl Build.PL
sudo ./Build installdeps
sudo ./Build install

ln -s ~/.local/inits/dwm.sh ~/.xinitrc
