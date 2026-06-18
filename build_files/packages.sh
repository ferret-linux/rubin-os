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
    ffmpegthumbs

## Install glycin
dnf5 install -y --setopt=install_weak_deps=False \
    glycin-loaders \
    glycin-thumbnailer \
    glycin-libs \
    glycin-gtk4-libs

### Indtall gnome setup
dnf5 install -y --setopt=install_weak_deps=False \
    gnome-initial-setup \
    gdm

### Install gnome addons
dnf5 install -y --setopt=install_weak_deps=False \
    switcheroo-control \
    gnome-disk-utility \
    gnome-bluetooth \
    morewaita-icon-theme \
    gnome-firmware \
    gnome-keyring \
    gnome-logs \
    gnome-tweaks \
    gnome-remote-desktop \

### Install gnome optionals
dnf5 install -y --setopt=install_weak_deps=False \
    NetworkManager-openconnect-gnome \
    NetworkManager-ssh-gnome \
    NetworkManager-openconnect-gnome \
    gnome-shell-extension-caffeine \
    gnome-shell-extension-gsconnect \
    gnome-shell-extension-appindicator \
    gnome-shell-extension-no-overview \
    extension-manager \
    gnome-shell-extension-ibus-font \
    gnome-shell-extension-blur-my-shell \
    gnome-shell-extension-dash-to-dock \
    adwaita-fonts-all \
    orca \
    speech-dispatcher \
    espeak-ng \

### Install gnome apps
dnf5 install -y --setopt=install_weak_deps=False \
    nautilus \
    bazaar \
    nautilus-python \
    bustle \
    resources \
    ghostty \
    ghostty-nautilus \
    nautilus-python \
    mousetweaks \
    input-remapper \
    file-roller \
    brave-origin \
    pika-backup

### Install input methods (ibus)
dnf5 install -y --setopt=install_weak_deps=False \
    ibus \
    ibus-pinyin \
    ibus-rime \
    ibus-sayura \
    ibus-mozc \
    ibus-hangul \
    ibus-chewing

### Enable system services
systemctl enable gdm
systemctl enable switcheroo-control.service
