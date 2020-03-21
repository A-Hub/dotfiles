# My Dotfiles

This repo contains my config files for the programs I use in my linux setup,
as well as any scripts I write for those programs.

Installers are located in ~/.local/installers/ to automate installation.
Currently only available for Void Linux, but could be expanded to other distros
in the future.

## Overview

### Applications used

- Window Manager - dwm
- Terminal Emulator - st
- App Launcher - dmenu
- File Browser - lf

## Installation

Install git

and then clone this repo

`$ cd ~`

`$ git clone --bare https://github.com/A-Hub/dotfiles.git $HOME/dotfiles`

ensure the config alias is defined
`alias config='/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME'`

then checkout contents of bare repository to populate your home directory.
`config checkout`

for more info read [this article](https://www.atlassian.com/git/tutorials/dotfiles)


finally run the install script in ~/.local/installers/void-install.sh

`bash ~/.local/installers/void-install.sh`

## Post Install

### Change Mirrors

Default mirrors for void are located in Europe. Recommend changing them to a closer location.
A list of mirrors can be found at voidlinux.org/download  at the bottom of the page.
Follow instructions on voids documentation at docs.voidlinux.org to change to desired mirror.

### Mount Secondary Drives

Modify /etc/fstab to add any secondary drives. Example entry can be seen below. Replace UUID value with UUID of the device you wish to mount, and the \<dir> entry with the directory you wish to mount to. **Ensure the directory you are mounting to exists**. If the directory does not exist, the system will likely have issues booting.

To see a list of devices and their UUIDs, run: `$ blkid`. Recommend using UUID instead of device files such as /dev/sda1 because drives may not always be mounted to the same /dev/ file. For more information read [the arch wiki entry](https://wiki.archlinux.org/index.php/Fstab).

```
#<device>                                        <dir>            <type>    <options>   <dump>  <fsck>
UUID=b7d683d4-9337-433b-8d33-1035ef7dbcdf       /home/user/HDD   ext4      defaults      0       2
```

### Enable Apparmor
Add `apparmor=1` and `security=apparmor` to GRUB_CMDLINE_LINUX_DEFAULT in /etc/default/grub.

Also edit /etc/default/apparmor and add line:

`APPARMOR=complain` or `APPARMOR=enforce`

Then generate grub config:

`$ sudo grub-mkconfig -o /boot/grub/grub.cfg`




## Notes

### wifi
ensure you enabled the wpa_supplicant service with:

`$ sudo ln -s /etc/sv/wpa_supplicant /var/service`

if you know the name of the network you wish to connect to:

 1. change to root user:
      `$ su`
      
 2. run command:
`$ wpa_supplicant -B -i INTERFACE -c <(wpa_passphrase SSID PASSWORD)`

  INTERFACE = name of wifi interface, likey: wlp3s0 or wlan0
  
  SSID = name of the network
  
  PASSWORD = the password of the network
  
 use command:
    `$ ip link show`
    
  to get a list of network interfaces available


 3. If you can now connect to the internet then you can add this network to your config file so that your computer will automatically connect to it. to do this run:
 
`sudo sh -c 'wpa_passphrase SSID PASSWORD >> /etc/wpa_supplicant/wpa_supplicant.conf'`

Your wifi should now work at startup. It may take a moment to connect. this will need to be done for any wifi network you wish to connect to.

### st
If you have weird issues with st such as a key writing multiple characters, backspace not working etc
try running the following in the st directory (~/repos/st/ if using the installer):

`$ tic -sx st.info`

### add locales
uncomment locale(s) you wish to add in /etc/default/libc-locales then run:

`$ sudo xbps-reconfigure -f glibc-locales`

### set system fonts
modify alias tags within <fontconfig> in ~/.config/fontconfig/fonts.conf

```
<alias>
    <family>FONT TYPE</family>                               #serif, sans-serif,sans, monospace
    <prefer><family>NAME OF FONT TO SET TO</family></prefer> #NotoSerif,NotoSans, Hack, etc.
</alias>
```

### modify visudo
To be able to use reboot, poweroff and shutdown without password(needed for sxhkd bindings to work):

`$ sudo visudo`

Add this line replacing user_name with your user name

`user_name ALL=(ALL) NOPASSWD: /sbin/poweroff, /sbin/reboot, /sbin/shutdown`

### fix low resolution in grub/tty
To get list of available resolutions press c in grub then type `vbeinfo` at the prompt

Then add line to /etc/default/grub

`GRUB_GFXPAYLOAD_LINUX=1920x1080x30`

then generate grub config:

`$ sudo grub-mkconfig -o /boot/grub/grub.cfg`
