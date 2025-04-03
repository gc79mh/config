#!/bin/bash

configure_pacman() {
	sed -i 's/#Color/Color/' /etc/pacman.conf
	sed -i 's/#NoProgressBar/ILoveCandy/' /etc/pacman.conf
	sed -i 's/#VerbosePkgLists/VerbosePkgLists/' /etc/pacman.conf
	sed -i 's/#ParallelDownloads = 5/ParallelDownloads = 5/' /etc/pacman.conf
	pacman --noconfirm -Syu reflector
	reflector --latest 10 --sort rate --save /etc/pacman.d/mirrorlist
	pacman --noconfirm -Rns reflector
}

configure_git() {
  git config --global user.email 'wiktor.bochenski@student.put.poznan.pl'
  git config --global user.name 'gc79mh'
}

configure_zsh() {
 sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" 
}

install_packages() {
	pacman --noconfirm -S linux-lts linux-lts-headers linux-firmware

	pacman --noconfirm -S efibootmgr grub

	pacman --noconfirm -S intel-media-driver mesa 

	pacman --noconfirm -S zsh

	pacman --noconfirm -S \
		pipewire \
		pipewire-alsa \
		pipewire-jack \
		pipewire-pulse \
		sof-firmware

	pacman --noconfirm -S \
		hyprland \
		waybar \
		hyprpaper \
		wl-clipboard \
		kitty

	pacman --noconfirm -S \
		base-devel \
		docker \
		git \
		lxd \
		neovim \
		networkmanager \
		openssh \
		tlp \
		ttf-jetbrains-mono-nerd 
}

configure_pacman
install_packages
configure_git
configure_zsh
