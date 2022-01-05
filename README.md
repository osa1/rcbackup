## apt installs

```
arandr
build-essential
cheese
cmake
curl
direnv
feh
fonts-jetbrains-mono
git
gnome-devel
htop
i3
iotop
kdiff3
libgtk-4-dev
libtool-bin
locate
meld
ncdu
neofetch
neovim
powertop
ranger
redshift
silversearcher-ag
transmission
vlc
xdotool
zsh
```

nvim is too old so build from source later:

```
make CMAKE_INSTALL_PREFIX=/home/omer CMAKE_BUILD_TYPE=Release install
```


## garbage required for coc.nvim

```
nodejs
yarnpkg
npm
```

Note: yarn executable is called `yarnpkg`.

Install coc.nvim with `yarnpgk install --frozen-lockfile`.

## apt removes

```
tracker-extract
tracker-miner-fs
```

## i3 tray bar fix

`tray_output primary` does not work, run `xrandr` to find out the primary
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

## Change tabs with mouse wheel in Firefox

Search for `switchByScrolling` in `about:config`
