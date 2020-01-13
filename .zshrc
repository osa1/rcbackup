####################
# History settings #
####################

HISTFILE=~/.history-zsh
HISTSIZE=10000
SAVEHIST=10000
# Allow multiple sessions to append to one history
setopt append_history
# Treat ! special during command expansion
setopt bang_hist
# Write history in :start:elasped;command format
setopt extended_history
# Expire duplicates first when trimming history
setopt hist_expire_dups_first
# When searching history, don't repeat
setopt hist_find_no_dups
# ignore duplicate entries of previous events
setopt hist_ignore_dups
# prefix command with a space to skip it's recording
setopt hist_ignore_space
# Remove extra blanks from each command added to history
setopt hist_reduce_blanks
# Don't execute immediately upon history expansion
setopt hist_verify
# Write to history file immediately, not when shell quits
setopt inc_append_history
# Share history among all sessions
setopt share_history

# More duplication stuff .. while I don't know what exactly these do, it seems
# like they're necessary to be able to get no dups whatsoever in C-r.
setopt hist_find_no_dups
setopt hist_ignore_all_dups

setopt extended_glob

# Per-directory history
source $HOME/rcbackup/per-directory-history.zsh

####################
# Completion stuff #
####################

# Copied from https://github.com/fatih/dotfiles/blob/master/zshrc

autoload -Uz compinit
compinit

zmodload -i zsh/complist

unsetopt menu_complete   # do not autoselect the first completion entry
unsetopt flowcontrol
setopt auto_menu         # show completion menu on successive tab press
setopt complete_in_word
setopt always_to_end

zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' list-colors ''
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'
zstyle '*' single-ignored show

# Automatically update PATH entries
zstyle ':completion:*' rehash true

# Keep directories and files separated
zstyle ':completion:*' list-dirs-first true

##########
# Prompt #
##########

# Adapted from https://github.com/fatih/dotfiles/blob/master/zshrc

autoload -U colors && colors
setopt promptsubst

local ret_status="%(?:%{$fg_bold[green]%}$:%{$fg_bold[red]%}$)"
PROMPT='%{$fg[cyan]%}%c%{$reset_color%} $(git_prompt_info)${ret_status}%{$reset_color%} '

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[blue]%}git:(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$fg[blue]%})%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[green]%}"

# Outputs current branch info in prompt format
function git_prompt_info() {
    local ref
    if [[ "$(command git config --get customzsh.hide-status 2>/dev/null)" != "1" ]]; then
        ref=$(command git symbolic-ref HEAD 2> /dev/null) || \
        ref=$(command git rev-parse --short HEAD 2> /dev/null) || return 0
        echo "$ZSH_THEME_GIT_PROMPT_PREFIX$(parse_git_dirty)${ref#refs/heads/}$ZSH_THEME_GIT_PROMPT_SUFFIX"
    fi
}

# Checks if working tree is dirty
function parse_git_dirty() {
    local STATUS=''
    local FLAGS
    FLAGS=('--porcelain')

    if [[ "$(command git config --get customzsh.hide-dirty)" != "1" ]]; then
        FLAGS+='--ignore-submodules=dirty'
        STATUS=$(command git status ${FLAGS} 2> /dev/null | tail -n1)
    fi

    if [[ -n $STATUS ]]; then
        echo "$ZSH_THEME_GIT_PROMPT_DIRTY"
    else
        echo "$ZSH_THEME_GIT_PROMPT_CLEAN"
    fi
}

##########

# C-w deletes these characters
WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'

# Don't remember what this is
stty -ixon

# Change dirs without cd
setopt auto_cd

unsetopt correct_all

export GHC_BIN=$HOME/ghc_bins/ghc-8.6.5-bin/bin

export EDITOR='nvim'
export TERM=xterm-256color

unset SSH_ASKPASS

export LD_LIBRARY_PATH=$HOME/lib:$HOME/lib64:/usr/local/lib64:$LD_LIBRARY_PATH
export LIBRARY_PATH=$HOME/lib:$HOME/lib64:$LIBRARY_PATH
export CPLUS_INCLUDE_PATH=$HOME/include:$CPLUS_INCLUDE_PATH
export C_INCLUDE_PATH=$HOME/include:$C_INCLUDE_PATH
export PKG_CONFIG_PATH=$HOME/lib/pkgconfig:$HOME/lib64/pkgconfig:$PKG_CONFIG_PATH
export PYTHONPATH=$HOME/pythonpath

alias open=xdg-open
alias xclip="xclip -selection c"

alias gd="git diff --color"
alias gdc="git diff --color --cached"
alias gc="git clean -xfd && git submodule foreach --recursive git clean -xfd"
alias gb="git checkout"
alias gcb="git checkout -b"
alias gpom="git push origin master"
alias gp="git push"
alias gs="git status"
alias ga="git commit --amend --no-edit"
alias gam="git commit --amend"

alias gdb="gdb -q"
alias ls="ls --color"

# edit-command-line, requires zsh-contrib
autoload edit-command-line
zle -N edit-command-line
bindkey "^X^E" edit-command-line

# start a new terminal at the same directory
bindkey -s "^N^N" '/home/omer/bin/st &!\n'

# Fix ctrl-left/ctrl-right
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

# Fix delete (use C-v + key to get the sequence)
bindkey "^[[P" delete-char

# Emacs style C-a, C-e, C-k etc.
bindkey -e

add_path() {
    export PATH=$1:$PATH
}

reset_path() {
    export PATH=$ORIG_PATH
}

add_ghc() {
    export PATH=$HOME/haskell/$1/inplace/bin:$PATH
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

tag_root() {
    git rev-parse --show-toplevel || echo "."
}

tags() {
    time (cd `tag_root` && \
        rm -f tags && fast-tags --no-module-tags driver ghc compiler -R +RTS -N)
}

rtstags() {
    tags
    time (cd `tag_root` && \
        ctags --append -R rts/**/*.c rts/**/*.h includes/**/*.h)
}

# like tags but tags libs too
alltags() {
    time (cd `tag_root` && \
        rm -f tags && fast-tags --no-module-tags driver ghc compiler libraries -R +RTS -N)
}

allrtstags() {
    alltags
    time (cd `tag_root` && \
        ctags --append -R rts/**/*.c rts/**/*.h includes/**/*.h)
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

dt() {
    find . -type f \
        -name "*.hi" -o \
        -name "*.o" -o \
        -name "*.dyn_hi" -o \
        -name "*.dyn_o" -o \
        -name "*.hi-boot" -o \
        -name "*.o-boot" -o \
        -name "*.dump-*" | xargs rm
}

zshrc() {
    # Move to rcbackup first otherwise git/fugitive commands don't work
    cd $HOME/rcbackup && nvim .zshrc
}

vimrc() {
    # Move to rcbackup first otherwise git/fugitive commands don't work
    cd $HOME/rcbackup && nvim .vim/init.vim
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
$HOME/.cabal/bin:\
$HOME/.cargo/bin:\
$GHC_BIN:\
$PATH
export PATH=$ORIG_PATH

eval "$(direnv hook zsh)"
