#!/bin/bash
set -euxo pipefail

# ---------------------------------------------------------------------------
# Package groups (arrays). Keep these separated/commented for readability;
# they all get flattened into ONE dnf transaction below.
# ---------------------------------------------------------------------------

GNOME_EXTENSIONS=(
  gnome-shell-extension-mosaic
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

USER_APPS=(
  pods
  code
)

# ---------------------------------------------------------------------------
# Flatten everything into one package list and install in a single
# dnf transaction. Order in the array doesn't matter to dnf's resolver.
# ---------------------------------------------------------------------------
ALL_PACKAGES=(
  "${GNOME_EXTENSIONS[@]}"
  "${USER_APPS[@]}"
)

dnf5 install -y --setopt=install_weak_deps=False "${ALL_PACKAGES[@]}"