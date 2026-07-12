#!/bin/bash
set -euxo pipefail

# ---------------------------------------------------------------------------
# Package groups (arrays). Keep these separated/commented for readability;
# they all get flattened into ONE dnf transaction below.
#
# This script runs AFTER mx-setup.sh (all variants) and essentials.sh (all
# non-mx variants) — both already run for *-gx. Do NOT re-list anything from
# either of those files here. NOTE: rubin-os-gx builds FROM mink-os-gx,
# which already ships Steam, Lutris, Wine, Winetricks, Protontricks,
# Bottles, GameMode, MangoHud, vkBasalt, Gamescope, and controller kmods
# at the OS layer — this script is the GNOME desktop layer on top of that,
# not a re-install of any of it.
# ---------------------------------------------------------------------------

# GUI front-ends for the perf/overlay tools already installed at the OS
# layer (gamemode, mangohud, vkBasalt) — turns CLI-only tuning into a
# couple of clicks
GAMING_TUNING_GUI=(
  steam
  lutris
  bottles
  goverlay
  retroarch
  protonplus
  heroic-games-launcher
)

# Broad third-party controller udev coverage (8BitDo, DualSense,
# DualShock, etc.) beyond the specific wheel/HOTAS kmods mink-os-gx
# already ships
GAMING_UDEV=(
  steam-devices
)

# ---------------------------------------------------------------------------
# Flatten everything into one package list and install in a single
# dnf transaction. Order in the array doesn't matter to dnf's resolver.
# ---------------------------------------------------------------------------
ALL_PACKAGES=(
  "${GAMING_TUNING_GUI[@]}"
  "${GAMING_UDEV[@]}"
)

dnf5 install -y --setopt=install_weak_deps=False "${ALL_PACKAGES[@]}"