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
  gnome-tweaks
  gnome-session
  gnome-keyring
  gnome-bluetooth
  gnome-keyring-pam
  gnome-control-center
  gnome-remote-desktop
  gnome-online-accounts
  gnome-settings-daemon
)

GHOSTTY=(
  ghostty
  ghostty-kio
  ghostty-neovim
  ghostty-terminfo
  ghostty-nautilus
  ghostty-bat-syntax
  ghostty-zsh-completion
  ghostty-shell-integration
)

GSCONNECT=(
  gnome-menus
  nautilus-gsconnect
  webextension-gsconnect
)

NAUTILUS=(
  sushi
  nautilus
  nautilus-python
  nautilus-extensions
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
  NetworkManager-openvpn-gnome
  NetworkManager-openconnect-gnome
)

GNOME_INTEGRATIONS=(
  orca
  espeak-ng
  mousetweaks
  speech-dispatcher
  adwaita-fonts-all
  switcheroo-control
)

GNOME_EXTENSIONS=(
  gnome-shell-extension-mosaic
  gnome-shell-extension-caffeine
  gnome-shell-extension-gsconnect
  gnome-shell-extension-drive-menu
  gnome-shell-extension-user-theme
  gnome-shell-extension-tiling-shell
  gnome-shell-extension-status-icons
  gnome-shell-extension-blur-my-shell
  gnome-shell-extension-coverflow-alt-tab
  gnome-shell-extension-auto-accent-colour
  gnome-shell-extension-accent-directories
  gnome-shell-extension-launch-new-instance
  gnome-shell-extension-clipboard-indicator
  gnome-shell-extension-vertical-workspaces
)

GNOME_CORE_APPS=(
  loupe
  papers
  snapshot
  celluloid
  file-roller
  gnome-weather
  gnome-firmware
  gnome-calculator
  gnome-disk-utility
)

GNOME_CIRCLE_APPS=(
  bazaar
  flatseal
  resources
  pika-backup
)

USER_APPS=(
  pods
  code
  extension-manager
)

GNOME_THEMING=(
  adw-gtk3-theme
  breeze-cursor-theme
  morewaita-icon-theme
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
  "${GHOSTTY[@]}"
  "${GSCONNECT[@]}"
  "${NAUTILUS[@]}"
  "${GLYCIN[@]}"
  "${GNOME_SETUP[@]}"
  "${NETWORKMANAGER_ADDONS[@]}"
  "${GNOME_INTEGRATIONS[@]}"
  "${GNOME_EXTENSIONS[@]}"
  "${GNOME_CORE_APPS[@]}"
  "${GNOME_CIRCLE_APPS[@]}"
  "${USER_APPS[@]}"
  "${GNOME_THEMING[@]}"
  "${INPUT_METHODS[@]}"
)

dnf5 install -y --setopt=install_weak_deps=False "${ALL_PACKAGES[@]}"