ARG BASE_IMAGE

# Allow build scripts to be referenced without being copied into the final image
FROM scratch AS ctx
COPY build_files /

# ── Base image ──────────────────────────────────────────────
FROM ${BASE_IMAGE}

ARG IMAGE_NAME
ARG IMAGE_VENDOR="ferret-linux"
ARG IMAGE_TAG="latest"

# Make /opt a real directory before package install
RUN rm -rf /opt && mkdir -p /opt

# ── Repo setup: ferret-pkgs + Copr's ─────────────────────────
RUN dnf config-manager addrepo --from-repofile=https://ferretlinux.org/repo/ferret-pkgs.repo && \
    dnf config-manager setopt ferret-pkgs.enabled=1 && \
    dnf config-manager setopt ferret-pkgs.priority=90 && \
    dnf --refresh makecache

# ── OS release info ──────────────────────────────────────────
RUN sed -i 's/^NAME=.*/NAME="RubinOS"/' /usr/lib/os-release && \
    sed -i 's/^PRETTY_NAME=.*/PRETTY_NAME="RubinOS Linux"/' /usr/lib/os-release

# ── Package installation ─────────────────────────────────────
# Make modifications desired in your image and install packages by
# editing build_files/packages.sh — the RUN directive below executes
# it with the recommended cache/tmpfs mounts.
RUN --mount=type=bind,from=ctx,source=/,target=/ctx \
    --mount=type=cache,dst=/var/cache \
    --mount=type=cache,dst=/var/log \
    --mount=type=tmpfs,dst=/tmp \
    bash /ctx/packages.sh

# ── Package version lock ─────────────────────────────────────
# Lock all installed packages to their current versions/releases,
# making rebase/upgrade behavior deterministic for this image.
# (dnf5 writes this to /etc/dnf/versionlock.toml — part of the
# committed OS tree, not /var — so it persists correctly.)
RUN dnf versionlock add $(rpm -qa --qf '%{NAME}\n')

# ── Enable services ──────────────────────────────────────────
RUN systemctl enable switcheroo-control.service && \
    systemctl enable gdm

# ── Dconf update ──────────────────────────────────────────────
RUN dconf update

# ── /opt → immutable tree migration ───────────────────────────
# Move /opt contents into the immutable /usr tree, create
# tmpfiles.d entries to symlink them back at runtime, then replace
# /opt with a symlink into /var so it stays writable.
RUN mkdir -p /usr/lib/opt && \
    mv /opt/* /usr/lib/opt/ 2>/dev/null || true && \
    for dir in /usr/lib/opt/*/; do \
        opt=$(basename "$dir"); \
        echo "L+?  \"/opt/${opt}\"  -  -  -  -  /usr/lib/opt/${opt}" > /usr/lib/tmpfiles.d/99-optfix-${opt}.conf; \
    done && \
    rm -rf /opt && ln -s /var/opt /opt && \
    mkdir -p /var/roothome && \
    mkdir -p /var/tmp && \
    chmod -R 1777 /var/tmp

# ── System files ─────────────────────────────────────────────
COPY system_files/ /

# ── Cleanup ───────────────────────────────────────────────────
RUN dnf config-manager setopt ferret-pkgs.enabled=0 && \
    rm -f /etc/yum.repos.d/ferret-pkgs.repo && \
    dnf5 autoremove -y && \
    dnf5 clean all && \
    dnf5 clean packages

# ── Installed package count ──────────────────────────────────
# Just a quick sanity check/log of how many packages ended up
# in the image — no version locking applied.
RUN echo "📦 Total installed packages: $(rpm -qa | wc -l)"

# ── InitRAMFS build ────────────────────────────────────────────
RUN --mount=type=bind,from=ctx,source=/,target=/ctx \
    --mount=type=cache,dst=/var/cache \
    --mount=type=cache,dst=/var/log \
    --mount=type=tmpfs,dst=/tmp \
    bash /ctx/initramfs.sh

# ── Image Cleanup (for Bootc compatibility) ──────────────────
RUN find /var/* -maxdepth 0 -type d ! -name cache ! -name log -exec rm -rf {} \; && \
    find /var/cache/* -maxdepth 0 -type d ! -name libdnf5 -exec rm -rf {} \; && \
    rm -rf /boot && mkdir -p /boot && \
    rm -rf /usr/etc

# ── Linting ─────────────────────────────────────────────────────
# Verify final image and contents are correct.
RUN bootc container lint