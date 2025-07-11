#!/bin/bash

set -ouex pipefail

### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/39/x86_64/repoview/index.html&protocol=https&redirect=1

# remove Gnome
dnf5 -y group remove gnome-desktop

# this installs a package from fedora repos
dnf5 install -y tmux 

dnf5 -y remove gdm gnome-shell gnome-session

dnf5 copr enable -y ryanabx/cosmic-epoch
dnf5 -y install @cosmic-desktop @cosmic-desktop-apps

#  remove duplicate applications
dnf5 -y remove gnome-calculator  \
    gnome-software  \
    gnome-tweaks \
    gnome-system-monitor \
    nautilus \
    thunderbird \

dnf5 clean all

# Use a COPR Example:
#
# dnf5 -y copr enable ublue-os/staging
# dnf5 -y install package
# Disable COPRs so they don't end up enabled on the final image:
# dnf5 -y copr disable ublue-os/staging

#### Example for enabling a System Unit File

systemctl enable podman.socket
