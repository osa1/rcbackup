# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
    # Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="robbyrussell"
#ZSH_THEME="alanpeabody"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want disable red dots displayed while waiting for completion
# DISABLE_COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...

alias 'documents=cd /media/pardus/home/omer/Documents'
alias 'downloads=cd /home/omer/Downloads'
alias 'music=cd /home/omer/Music'


# Django
alias 'runserver=python manage.py runserver'
alias 'syncdb=python manage.py syncdb'


alias 'recorddesktop=recordmydesktop --fps 25 --v_bitrate 2000000 --no-sound'

alias 'lsd=ls -l | grep "^d"'

alias 'setxrandr=xrandr --newmode "1920x1080" 173.00  1920 2048 2248 2576  1080 1083 1088 1120 -hsync +vsync'
alias 'addxrandrmod=xrandr --addmode VGA1 "1920x1080"'
alias 'setupxrandr=xrandr --newmode "1920x1080" 173.00  1920 2048 2248 2576  1080 1083 1088 1120 -hsync +vsync && xrandr --addmode VGA1 "1920x1080"'

alias 'resetcabal=rm -rf /home/omer/.cabal && rm -rf /home/omer/.ghc && cp -r /home/omer/.cabal_yedek /home/omer/.cabal && cp -r /home/omer/.ghc_yedek /home/omer/.ghc'

alias 'create_timelapse=ffmpeg -r 10 -f image2 -i %09d.png -vcodec mpeg4 -b:v 8000k timelapse.avi'

alias 'ocaml=rlwrap ocaml -I $OCAML_TOPLEVEL_PATH'

export TERM=xterm-256color
export PATH=/home/omer/Downloads/racket/bin:$PATH
export PATH=/home/omer/.cabal/bin:$PATH
export PATH=/home/omer/node_modules/.bin:$PATH
export PATH=/home/omer/.opam/system/bin:$PATH
export CLASSPATH=/home/omer/CLASSPATH
export MANPATH=/home/omer/.opam/system/man:/usr/local/man:/usr/local/share/man:/usr/share/man:$MANPATH
alias 'setkb=xset r rate 289 50'


export CAML_LD_LIBRARY_PATH=/home/omer/.opam/4.00.1/lib/stublibs:/usr/local/lib/ocaml
export OCAML_TOPLEVEL_PATH=/home/omer/.opam/4.00.1/lib/toplevel
export MANPATH=/home/omer/.opam/4.00.1/man:/usr/local/man:$MANPATH
export PATH=/home/omer/.opam/4.00.1/bin:$PATH

unset SSH_ASKPASS
export JDK_HOME=/home/omer/jdk1.7.0_21/
export PATH=/home/omer/jdk1.7.0_21/bin:$PATH

export LD_LIBRARY_PATH=/home/omer/lib
