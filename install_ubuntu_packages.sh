#/bin/bash

sudo apt install \
    apt-file \
    arandr \
    build-essential \
    cheese \
    cloc \
    cmake \
    curl \
    direnv \
    evince \
    feh \
    file-roller \
    fonts-jetbrains-mono \
    gimp \
    git \
    gitg \
    gnome-devel \
    graphviz \
    htop \
    i3 \
    iotop \
    kdiff3 \
    libgmp-dev \
    libgtk-4-dev \
    libtool-bin \
    libxcb-render0-dev \
    libcxb-shape0-dev \
    libxcb-xfixes0-dev \
    libxft-dev \
    locate \
    meld \
    ncal \
    ncdu \
    neofetch \
    neovim \
    nomacs \
    pavucontrol \
    peek \
    powertop \
    ranger \
    redshift \
    silversearcher-ag \
    tig \
    transmission \
    tumbler \
    vlc \
    xdotool \
    zsh

#
# Install garbage required by coc.nvim
#

sudo apt install \
    nodejs \
    npm \
    yarnpkg

#
# Remove garbage
#

sudo apt remove \
    tracker-extract \
    tracker-miner-fs \
    imagemagick
