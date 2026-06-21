#!/bin/bash

set -ouex pipefail

### Install xdg base
dnf5 install -y --setopt=install_weak_deps=False \
    xdg-utils \
    xdg-user-dirs \
    xdg-user-dirs-gtk \
    xdg-terminal-exec \
    xdg-desktop-portal \
    xdg-desktop-portal-gtk \
    xdg-desktop-portal-gnome \

## Install Gnome
dnf5 install -y --setopt=install_weak_deps=False \
    libsecret \
    gnome-shell \
    gnome-session \
    gnome-keyring \
    gnome-bluetooth \
    gnome-keyring-pam \
    gnome-control-center \
    gnome-remote-desktop \
    gnome-online-accounts \
    gnome-settings-daemon

## Install Ghostty
dnf install -y --setopt=install_weak_deps=False \
    ghostty \
    ghostty-kio \
    ghostty-neovim \
    ghostty-terminfo \
    ghostty-nautilus \
    ghostty-bat-syntax \
    ghostty-zsh-completion \
    ghostty-shell-integration

## GSconnect
dnf install -y --setopt=install_weak_deps=False \
    gnome-menus \
    nautilus-gsconnect \
    webextension-gsconnect

## Install Nautilus
dnf5 install -y --setopt=install_weak_deps=False \
    sushi \
    nautilus \
    nautilus-python \
    nautilus-extensions \

## Install glycin
dnf5 install -y --setopt=install_weak_deps=False \
    glycin-libs \
    glycin-loaders \
    glycin-gtk4-libs \
    glycin-thumbnailer

### Indtall gnome setup
dnf5 install -y --setopt=install_weak_deps=False \
    gdm \
    gnome-initial-setup

### Install Network Manager Addons
dnf5 install -y --setopt=install_weak_deps=False \
    NetworkManager-ssh-gnome \
    NetworkManager-openvpn-gnome \
    NetworkManager-openconnect-gnome

### Gnome Integrations
dnf5 install -y --setopt=install_weak_deps=False \
    orca \
    espeak-ng \
    mousetweaks \
    speech-dispatcher \
    adwaita-fonts-all \
    switcheroo-control

### Install gnome extensions
dnf5 install -y --setopt=install_weak_deps=False \
    gnome-shell-extension-mosaic \
    gnome-shell-extension-paperwm \
    gnome-shell-extension-arcmenu \
    gnome-shell-extension-caffeine \
    gnome-shell-extension-gsconnect \
    gnome-shell-extension-apps-menu \
    gnome-shell-extension-drive-menu \
    gnome-shell-extension-user-theme \
    gnome-shell-extension-places-menu \
    gnome-shell-extension-tiling-shell \
    gnome-shell-extension-status-icons \
    gnome-shell-extension-dash-to-dock \
    gnome-shell-extension-blur-my-shell \
    gnome-shell-extension-dash-to-panel \
    gnome-shell-extension-burn-my-windows \
    gnome-shell-extension-just-perfection \
    gnome-shell-extension-coverflow-alt-tab \
    gnome-shell-extension-auto-accent-colour \
    gnome-shell-extension-accent-directories \
    gnome-shell-extension-launch-new-instance \
    gnome-shell-extension-clipboard-indicator \
    gnome-shell-extension-vertical-workspaces \
    gnome-shell-extension-compiz-windows-effect \
    gnome-shell-extension-rounded-window-corners-reborn

### Install gnome core apps
dnf5 install -y --setopt=install_weak_deps=False \
    loupe \
    papers \
    snapshot \
    celluloid \
    gnome-logs \
    file-roller \
    gnome-clocks \
    gnome-weather \
    gnome-firmware \
    gnome-calendar \
    gnome-calculator \
    gnome-connections \
    gnome-disk-utility

### Install gnome circle apps
dnf5 install -y --setopt=install_weak_deps=False \
    bazaar \
    bustle \
    flatseal \
    resources \
    pika-backup

### Install user apps
dnf5 install -y --setopt=install_weak_deps=False \
    pods \
    code \
    wardrobe \
    helium-drm \
    extension-manager

### Gnome Theming
dnf5 install -y --setopt=install_weak_deps=False \
    adw-gtk3-theme \
    breeze-cursor-theme \
    morewaita-icon-theme

### Install input methods (ibus)
dnf5 install -y --setopt=install_weak_deps=False \
    ibus \
    ibus-rime \
    ibus-mozc \
    ibus-pinyin \
    ibus-sayura \
    ibus-hangul \
    ibus-chewing

### Update Dconf
dconf update

### Remove Extra .desktop icons
rm -rf /usr/share/applications/nvim.desktop
rm -rf /usr/share/applications/btop.desktop

### Enable system services
systemctl enable gdm
systemctl enable switcheroo-control.service
