#!/bin/bash
set -euxo pipefail

# ---------------------------------------------------------------------------
# Package groups (arrays). Keep these separated/commented for readability;
# they all get flattened into ONE dnf transaction below.
# ---------------------------------------------------------------------------

XDG_BASE=(
  xdg-utils
  xdg-user-dirs
  xdg-user-dirs-gtk
  xdg-terminal-exec
  xdg-desktop-portal
  xdg-desktop-portal-gtk
  xdg-desktop-portal-gnome
)

GNOME_SHELL=(
  libsecret
  gnome-shell
  gnome-session
  gnome-keyring
  gnome-bluetooth
  gnome-keyring-pam
  gnome-control-center
  gnome-remote-desktop
  gnome-settings-daemon
)

NAUTILUS=(
  nautilus
)

GLYCIN=(
  glycin-libs
  glycin-loaders
  glycin-gtk4-libs
  glycin-thumbnailer
)

GNOME_SETUP=(
  gdm
  gnome-initial-setup
)

NETWORKMANAGER_ADDONS=(
  NetworkManager-ssh-gnome
)

GNOME_INTEGRATIONS=(
  adwaita-fonts-all
  switcheroo-control
)

GNOME_CORE_APPS=(
  file-roller
  gnome-disk-utility
)

GNOME_CIRCLE_APPS=(
  bazaar
)

INPUT_METHODS=(
  ibus
  ibus-rime
  ibus-mozc
  ibus-pinyin
  ibus-sayura
  ibus-hangul
  ibus-chewing
)

# ---------------------------------------------------------------------------
# Flatten everything into one package list and install in a single
# dnf transaction. Order in the array doesn't matter to dnf's resolver.
# ---------------------------------------------------------------------------
ALL_PACKAGES=(
  "${XDG_BASE[@]}"
  "${GNOME_SHELL[@]}"
  "${NAUTILUS[@]}"
  "${GLYCIN[@]}"
  "${GNOME_SETUP[@]}"
  "${NETWORKMANAGER_ADDONS[@]}"
  "${GNOME_INTEGRATIONS[@]}"
  "${GNOME_CORE_APPS[@]}"
  "${GNOME_CIRCLE_APPS[@]}"
  "${INPUT_METHODS[@]}"
)

dnf5 install -y --setopt=install_weak_deps=False "${ALL_PACKAGES[@]}"