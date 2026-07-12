#!/bin/bash
set -euxo pipefail

# ---------------------------------------------------------------------------
# Package groups (arrays). Keep these separated/commented for readability;
# they all get flattened into ONE dnf transaction below.
#
# This script runs AFTER mx-setup.sh (all variants), essentials.sh (all
# non-mx variants), and dx-setup.sh (*-dx and *-vx, since vx = dx + vx) —
# all three already run for *-vx. Do NOT re-list anything from any of
# them here. NOTE: rubin-os-vx builds FROM mink-os-vx, which already
# ships libvirt, QEMU, Incus, virt-manager, and GNOME Boxes at the OS
# layer — this script is the GNOME desktop layer on top of that, not a
# re-install of any of it.
# ---------------------------------------------------------------------------


# Lightweight SPICE/VNC console viewer — a lighter-weight companion to
# virt-manager (already on the mink-os-vx base) for quickly opening a
# guest console without the full VM-management UI
VIRT_DESKTOP=(
  gnome-boxes
  virt-viewer
)

# ---------------------------------------------------------------------------
# Flatten everything into one package list and install in a single
# dnf transaction. Order in the array doesn't matter to dnf's resolver.
# ---------------------------------------------------------------------------
ALL_PACKAGES=(
  "${VIRT_DESKTOP[@]}"
)

dnf5 install -y --setopt=install_weak_deps=False "${ALL_PACKAGES[@]}"