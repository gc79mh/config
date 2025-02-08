#!/bin/bash

name=$1
shift

lxc rm -f $name 2> /dev/null

# CREATING THE CONTAINER
lxc launch images:archlinux $name

lxc exec $name -- sh -c "sed -i 's/#Color/Color/' /etc/pacman.conf"
lxc exec $name -- sh -c "sed -i 's/#NoProgressBar/ILoveCandy/' /etc/pacman.conf"
lxc exec $name -- sh -c "sed -i 's/#VerbosePkgLists/VerbosePkgLists/' /etc/pacman.conf"
lxc exec $name -- sh -c "sed -i 's/#ParallelDownloads = 5/ParallelDownloads = 5/' /etc/pacman.conf"

lxc restart $name

sleep 2

lxc exec $name -- sh -c "pacman -Syu zsh neovim --noconfirm"
lxc exec $name -- sh -c "pacman -S $@ --noconfirm"


lxc exec $name -- sh -c "echo 'zstyle :compinstall filename '/root/.zshrc'' >> /root/.zshrc"
lxc exec $name -- sh -c "echo 'autoload -Uz compinit' >> /root/.zshrc"
lxc exec $name -- sh -c "echo 'compinit' >> /root/.zshrc"
lxc exec $name -- sh -c "echo 'export TERM=xterm-256color' >> /root/.zshrc"

lxc restart $name

lxc exec $name -- zsh
