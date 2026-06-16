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

### Indtall gnome setup
dnf5 install -y --setopt=install_weak_deps=False \
    gnome-initial-setup \
    gdm

### Install gnome addons
dnf5 install -y --setopt=install_weak_deps=False \
    switcheroo-control \
    gnome-disk-utility \
    gnome-bluetooth \
    gnome-backgrounds \
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
    gnome-shell-extension-blur-my-shell \
    gnome-shell-extension-dash-to-dock \
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
    ghostty \
    mousetweaks \
    input-remapper \
    helium-drm \
    code

### Install input methods (ibus)
dnf5 install -y --setopt=install_weak_deps=False \
    ibus \
    ibus-pinyin \
    ibus-rime \
    ibus-sayura \
    ibus-mozc \
    ibus-hangul \
    ibus-chewing \
    gnome-shell-extension-ibus-font \

### Enable system services
systemctl enable gdm
systemctl enable switcheroo-control.service