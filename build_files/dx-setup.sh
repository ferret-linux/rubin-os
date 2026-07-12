#!/bin/bash
set -euxo pipefail

# ---------------------------------------------------------------------------
# Package groups (arrays). Keep these separated/commented for readability;
# they all get flattened into ONE dnf transaction below.
#
# This script runs AFTER mx-setup.sh (all variants) and essentials.sh (all
# non-mx variants) — both already run for *-dx. Do NOT re-list anything from
# either of those files here.
# ---------------------------------------------------------------------------

GNOME_EXTENSIONS_EXTRAS=(
  gnome-shell-extension-mosaic
  gnome-shell-extension-tiling-shell
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
  "${GNOME_EXTENSIONS_EXTRAS[@]}"
  "${USER_APPS[@]}"
)

dnf5 install -y --setopt=install_weak_deps=False "${ALL_PACKAGES[@]}"