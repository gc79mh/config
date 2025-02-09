#!/bin/bash

name=$1
shift

lxc rm -f $name 2> /dev/null

# CREATING THE CONTAINER
lxc launch images:archlinux $name

# ENV VARIABLES
lxc config set $name environment.DISPLAY ":0"
lxc config set $name environment.WAYLAND_DISPLAY "wayland-1"
lxc config set $name environment.XDG_RUNTIME_DIR "/run/user/1000"

# SOCKETS
lxc config device add $name wayland-socket proxy \
  bind=container \
  connect=unix:/run/user/1000/wayland-1 \
  gid="1000" \
  listen=unix:/mnt/wayland-1 \
  mode="0777" \
  security.gid="1000" \
  security.uid="1000" \
  uid="1000"

lxc config device add $name X-socket proxy \
  bind=container \
  connect=unix:/tmp/.X11-unix/X0 \
  gid="1000" \
  listen=unix:/mnt/X0 \
  mode="0777" \
  security.gid="1000" \
  security.uid="1000" \
  uid="1000"

lxc config device add $name pulse-socket proxy \
  bind=container \
  connect=unix:/run/user/1000/pulse/native \
  gid="1000" \
  listen=unix:/mnt/native \
  mode="0777" \
  security.gid="1000" \
  security.uid="1000" \
  uid="1000"

# GPU

lxc config device add $name gpu gpu

# SOUNDCARD

lxc config device add $name soundcard disk \
  path=/dev/snd \
  source=/dev/snd

# SETUP SCRIPT

lxc exec $name -- sh -c "echo '#!/bin/bash' >> /usr/local/bin/setup"
lxc exec $name -- sh -c "echo 'mkdir /run/user/1000 2> /dev/null' >> /usr/local/bin/setup"
lxc exec $name -- sh -c "echo 'ln -s /mnt/wayland-1 /run/user/1000 2> /dev/null' >> /usr/local/bin/setup"
lxc exec $name -- sh -c "echo 'mkdir /run/user/1000/pulse 2> /dev/null' >> /usr/local/bin/setup"
lxc exec $name -- sh -c "echo 'ln -s /mnt/native /run/user/1000/pulse 2> /dev/null' >> /usr/local/bin/setup"
lxc exec $name -- sh -c "echo 'ln -s /mnt/X0 /tmp/.X11-unix/ 2> /dev/null' >> /usr/local/bin/setup"

lxc exec $name -- sh -c "chmod +x /usr/local/bin/setup"

# SYSTEMD

lxc exec $name -- sh -c "echo '[Unit]' >> /etc/systemd/system/setup.service"
lxc exec $name -- sh -c "echo 'Description=My Script on Startup' >> /etc/systemd/system/setup.service"
lxc exec $name -- sh -c "echo '[Service]' >> /etc/systemd/system/setup.service"
lxc exec $name -- sh -c "echo 'ExecStart=/usr/local/bin/setup' >> /etc/systemd/system/setup.service"
lxc exec $name -- sh -c "echo '[Install]' >> /etc/systemd/system/setup.service"
lxc exec $name -- sh -c "echo 'WantedBy=default.target' >> /etc/systemd/system/setup.service"

lxc exec $name -- sh -c "systemctl enable setup"

lxc exec $name -- sh -c "sed -i 's/#Color/Color/' /etc/pacman.conf"
lxc exec $name -- sh -c "sed -i 's/#NoProgressBar/ILoveCandy/' /etc/pacman.conf"
lxc exec $name -- sh -c "sed -i 's/#VerbosePkgLists/VerbosePkgLists/' /etc/pacman.conf"
lxc exec $name -- sh -c "sed -i 's/#ParallelDownloads = 5/ParallelDownloads = 5/' /etc/pacman.conf"

lxc restart $name

lxc exec $name -- sh -c "pacman -Syu zsh neovim base-devel git mesa mesa-utils gnu-free-fonts pipewire pipewire-alsa pipewire-pulse pipewire-jack wl-clipboard --noconfirm"
lxc exec $name -- sh -c "pacman -S $@ --noconfirm"

lxc exec $name -- sh -c "echo 'zstyle :compinstall filename '/root/.zshrc'' >> /root/.zshrc"
lxc exec $name -- sh -c "echo 'autoload -Uz compinit' >> /root/.zshrc"
lxc exec $name -- sh -c "echo 'compinit' >> /root/.zshrc"
lxc exec $name -- sh -c "echo 'export TERM=xterm-256color' >> /root/.zshrc"

lxc restart $name

lxc exec $name -- zsh
