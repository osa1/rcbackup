## apt installs

```
sudo apt install \
    arandr \
    build-essential \
    cheese \
    cmake \
    curl \
    direnv \
    feh \
    fonts-jetbrains-mono \
    git \
    gnome-devel \
    htop \
    i3 \
    iotop \
    kdiff3 \
    libgtk-4-dev \
    libtool-bin \
    locate \
    meld \
    ncdu \
    neofetch \
    neovim \
    powertop \
    ranger \
    redshift \
    silversearcher-ag \
    transmission \
    vlc \
    xdotool \
    zsh
```

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

2. Remove all plugins from xfce4 panel settings.

3. ```
   apt purge xfce4-indicator-plugin xfce4-statusnotifier-plugin
   apt autoremove
   ```

## Change tabs with mouse wheel in Firefox

Search for `switchByScrolling` in `about:config`
