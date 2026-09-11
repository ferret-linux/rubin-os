#!/bin/bash
set -euxo pipefail

# ---------------------------------------------------------------------------
# Package groups (arrays). Keep these separated/commented for readability;
# they all get flattened into ONE dnf transaction below.
#
# This script runs AFTER mx-setup.sh (which runs for every variant,
# including this one). Do NOT re-list anything already installed by
# mx-setup.sh's GNOME_SHELL, NAUTILUS, GLYCIN, GNOME_SETUP,
# NETWORKMANAGER_ADDONS, GNOME_INTEGRATIONS, GNOME_CORE_APPS,
# GNOME_CIRCLE_APPS, or INPUT_METHODS arrays.
# ---------------------------------------------------------------------------

# Extra GNOME shell tooling beyond mx's core (gnome-shell/session/keyring/etc.)
GNOME_SHELL_EXTRAS=(
  gnome-tweaks
  gnome-online-accounts
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

# Extra Nautilus add-ons beyond mx's core 'nautilus' package
NAUTILUS_EXTRAS=(
  sushi
  nautilus-python
  nautilus-extensions
)

NETWORKMANAGER_ADDONS_EXTRAS=(
  NetworkManager-openvpn-gnome
  NetworkManager-openconnect-gnome
)

ACCESSIBILITY=(
  orca
  espeak-ng
  mousetweaks
  speech-dispatcher
)

GNOME_EXTENSIONS=(
  gnome-shell-extension-caffeine
  gnome-shell-extension-gsconnect
  gnome-shell-extension-drive-menu
  gnome-shell-extension-user-theme
  gnome-shell-extension-status-icons
  gnome-shell-extension-blur-my-shell
  gnome-shell-extension-coverflow-alt-tab
  gnome-shell-extension-auto-accent-colour
  gnome-shell-extension-accent-directories
  gnome-shell-extension-launch-new-instance
  gnome-shell-extension-clipboard-indicator
)

GNOME_CORE_APPS_EXTRAS=(
  gnome-firmware
)

GNOME_CIRCLE_APPS_EXTRAS=(
  flatseal
  resources
)

USER_APPS=(
  extension-manager
)

GNOME_THEMING=(
  adw-gtk3-theme
  breeze-cursor-theme
  morewaita-icon-theme
)

# ---------------------------------------------------------------------------
# Flatten everything into one package list and install in a single
# dnf transaction. Order in the array doesn't matter to dnf's resolver.
# ---------------------------------------------------------------------------
ALL_PACKAGES=(
  "${GNOME_SHELL_EXTRAS[@]}"
  "${GHOSTTY[@]}"
  "${GSCONNECT[@]}"
  "${NAUTILUS_EXTRAS[@]}"
  "${NETWORKMANAGER_ADDONS_EXTRAS[@]}"
  "${ACCESSIBILITY[@]}"
  "${GNOME_EXTENSIONS[@]}"
  "${GNOME_CORE_APPS_EXTRAS[@]}"
  "${GNOME_CIRCLE_APPS_EXTRAS[@]}"
  "${USER_APPS[@]}"
  "${GNOME_THEMING[@]}"
)

dnf5 install -y --setopt=install_weak_deps=False "${ALL_PACKAGES[@]}"