#!/bin/bash

set -ouex pipefail

### Install xdg base
dnf5 install -y --setopt=install_weak_deps=False \
    xdg-utils \
    xdg-user-dirs \
    xdg-user-dirs-gtk \
    xdg-desktop-portal \
    xdg-desktop-portal-gtk \
    xdg-desktop-portal-gnome \

## Install Gnome
dnf5 install -y --setopt=install_weak_deps=False \
    libsecret \
    gnome-shell \
    gnome-tweaks \
    gnome-session \
    gnome-keyring \
    gnome-bluetooth \
    gnome-keyring-pam \
    gnome-control-center \
    gnome-remote-desktop \
    gnome-online-accounts \
    gnome-settings-daemon

## Install Nautilus
dnf5 install -y --setopt=install_weak_deps=False \
    sushi \
    nautilus \
    nautilus-python \
    nautilus-gsconnect \
    nautilus-extensions \
    ghostty-nautilus

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
    gnome-classic-session \
    gnome-shell-extension-caffeine \
    gnome-shell-extension-gsconnect \
    gnome-shell-extension-apps-menu \
    gnome-shell-extension-drive-menu \
    gnome-shell-extension-user-theme \
    gnome-shell-extension-places-menu \
    gnome-shell-extension-light-style \
    gnome-shell-extension-status-icons \
    gnome-shell-extension-blur-my-shell \
    gnome-shell-extension-launch-new-instance \
    gnome-shell-extension-all-in-one-clipboard \
    gnome-shell-extension-native-window-placement \

### Install gnome apps
dnf5 install -y --setopt=install_weak_deps=False \
    pods \
    bazaar \
    bustle \
    ghostty \
    wardrobe \
    resources \
    helium-drm \
    gnome-logs \
    pika-backup \
    file-roller \
    gnome-firmware \
    extension-manager \
    gnome-disk-utility

### Gnome Theming
dnf5 install -y --setopt=install_weak_deps=False \
    adw-gtk3-theme \
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

### Enable system services
systemctl enable gdm
systemctl enable switcheroo-control.service
