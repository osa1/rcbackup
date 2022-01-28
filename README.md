## apt installs

```
sudo apt install \
    apt-file \
    arandr \
    build-essential \
    cheese \
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
    htop \
    i3 \
    iotop \
    kdiff3 \
    libgmp-dev \
    libgtk-4-dev \
    libtool-bin \
    locate \
    meld \
    ncal \
    ncdu \
    neofetch \
    neovim \
    nomacs \
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
```

- tumbler needed for image preview in thunar
- nomacs is an image viewer
- apt-file can be used to find packages that provide an executable. E.g. `sudo
  apt-file update; apt-file search FileCheck`.
- libgmp-dev is needed for stack/GHC, to build the blog
- file-roller is GNOME archive manager (GUI for tarballs etc.)

nvim is too old so build from source later:

```
git clone https://github.com/neovim/neovim
(cd neovim; make CMAKE_INSTALL_PREFIX=/home/omer CMAKE_BUILD_TYPE=Release install)
```

## Garbage required for coc.nvim

```
sudo apt install \
    nodejs \
    yarnpkg \
    npm
```

Note: yarn executable is called `yarnpkg`.

Install coc.nvim with `yarnpgk install --frozen-lockfile`.

## apt removes

```
sudo apt remove \
    tracker-extract \
    tracker-miner-fs
    imagemagick
```

## cargo installs

Install Rust:

```
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```

Packages:

```
cargo install cargo-flamegraph
cargo install cargo-watch
cargo install cargo-bloat
```

## i3 tray bar fix


1. `tray_output primary` does not work, run `xrandr` to find out the primary
   output, use it in `tray_output`. E.g.

   ```
   bar {
       ...
       tray_output HDMI-0
   }
   ```

   or on laptop:

   ```
   bar {
       ...
       tray_output eDP-1
   }
   ```

   Alternatively, set primary output in `arandr`.

2. Remove all plugins from xfce4 panel settings.

3. ```
   apt purge xfce4-indicator-plugin xfce4-statusnotifier-plugin
   apt autoremove
   ```

## Change tabs with mouse wheel in Firefox

Search for `switchByScrolling` in `about:config`
