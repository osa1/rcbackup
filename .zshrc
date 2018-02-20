# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="robbyrussell"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git, git-extras, per-directory-history)

alias ccat=colorize
alias open=xdg-open
alias xclip="xclip -selection c"

source $ZSH/oh-my-zsh.sh

# User configuration

stty -ixon

export GHC_BIN=$HOME/ghc_bins/ghc-8.2.2-bin/bin

export EDITOR='nvim'

unset SSH_ASKPASS

export TERM=xterm-256color

export LD_LIBRARY_PATH=$HOME/lib:$HOME/lib64:/usr/local/lib64:$LD_LIBRARY_PATH
export LIBRARY_PATH=$HOME/lib:$HOME/lib64:$LIBRARY_PATH
export CPLUS_INCLUDE_PATH=$HOME/include:$CPLUS_INCLUDE_PATH
export C_INCLUDE_PATH=$HOME/include:$C_INCLUDE_PATH
export PKG_CONFIG_PATH=$HOME/lib/pkgconfig:$HOME/lib64/pkgconfig:$PKG_CONFIG_PATH

# This seems to make zsh stop adding empty lines to .zsh_history
export HISTORY_IGNORE=""

alias gd="git diff --color"
alias gdc="git diff --color --cached"
alias gc="git commit -m"
alias gb="git checkout"
alias gcb="git checkout -b"
alias gpom="git push origin master"
alias gp="git push"
alias gs="git status"

alias gdb="gdb -q"

# edit-command-line
bindkey "^X^E" edit-command-line

# start a new terminal at the same directory
bindkey -s "^N^N" 'st &!\n'

load_ghc_dev() {
    export PATH=/home/omer/haskell/ghc/inplace/bin:$PATH
}

add_path() {
    export PATH=$1:$PATH
}

ubx_sum() {
    add_path $HOME/ghc_bins/ghc-ubx-sums-1.6/bin
}

add_ghc() {
    export PATH=$HOME/haskell/$1/inplace/bin:$PATH
}

reset_path() {
    export PATH=$ORIG_PATH
}

ns() {
    $* && notify-send "Done: $*"
}

:r() {
    fg cabal repl || fg ghci || fg stack repl
}

mc() {
    mkdir $1 && cd $1
}

x86() {
    lynx $HOME/Documents/x86/html/index.html -nolog -nomore -nopause -show_cursor -vikeys
}

cref() {
    lynx $HOME/Documents/cppref/reference/en/index.html -nolog -nomore -nopause -show_cursor -vikeys
}

tags() {
    time (rm -f tags && fast-tags --no-module-tags driver ghc compiler -R +RTS -N4 && sed -i.bak '/vectorise/d' ./tags)
}

rtstags() {
    tags
    time (ctags --append -R rts/**/*.c rts/**/*.h includes/**/*.h)
}

gst() {
    git stash show -p stash@{$1}
}

layout() {
    sh $HOME/.screenlayout/$1.sh
}

tops() {
    htop --pid "$(pgrep -x $1 | tr '\n' ',')"
}

# TODO: Write unload_ghc_dev()

if [ -f ~/.fzf.zsh ]; then
    export FZF_DEFAULT_COMMAND='ag -g ""'
    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
    source ~/.fzf.zsh
fi

export ORIG_PATH=\
$HOME/bin:\
$HOME/.local/bin:\
$HOME/arc/arcanist/bin:\
$HOME/.cabal/bin:\
$HOME/.cargo/bin:\
$GHC_BIN:\
$PATH
export PATH=$ORIG_PATH

eval "$(direnv hook zsh)"
