#!/usr/bin/env sh

# Get the aliases and functions
[ -f $HOME/.bashrc ] && . $HOME/.bashrc


# Profile file. Runs on login. Environmental variables are set here.
export SXHKD_SHELL='/bin/sh'

export XDG_CONFIG_HOME=$HOME/.config

#change default location of zsh config
export ZDOTDIR="$HOME/.config/zsh"

#get colored man pages
export LESS_TERMCAP_mb=$'\e[1;32m'
export LESS_TERMCAP_md=$'\e[1;32m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[01;33m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;4;31m'


#set shell variables
export EDITOR=vim
export VISUAL=vim
export BROWSER=surf
export TERMINAL=st

# Add ~/.local/bin/ and ~/scripts/ to PATH
export PATH="$HOME/.local/bin/:$PATH"
export PATH="$HOME/.appimages/:$PATH"
export PATH="$HOME/scripts/:$PATH"

export SSYSTEM="ALSA" #system variable to define sound system?

[[ $XDG_VTNR -le 2 ]] && startx 
#[ "$(tty)" = "/dev/tty1" ]  && exec startx
