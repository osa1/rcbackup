Run `./install_ubuntu_packages.sh`.

- apt-file can be used to find packages that provide an executable. E.g. `sudo
  apt-file update; apt-file search FileCheck`.
- libgmp-dev is needed for stack/GHC, to build the blog

nvim is too old so build from source later:

```
git clone https://github.com/neovim/neovim
(cd neovim; make CMAKE_INSTALL_PREFIX=/home/omer CMAKE_BUILD_TYPE=Release install)
```

## cargo installs

Install Rust:

```
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```

Packages:

```
cargo install cargo-bloat
cargo install cargo-expand
cargo install cargo-flamegraph
cargo install cargo-tarpaulin
cargo install cargo-watch
cargo install sd
```

## Change tabs with mouse wheel in Firefox

Search for `switchByScrolling` in `about:config`
