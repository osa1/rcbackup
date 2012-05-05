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
plugins=(git lein)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...

alias 'documents=cd /media/pardus/home/sinan/Documents'
alias 'downloads=cd /home/sinan/Downloads'
alias 'music=cd /home/sinan/Music'


# Django
alias 'runserver=python manage.py runserver'
alias 'syncdb=python manage.py syncdb'


alias 'recorddesktop=recordmydesktop --fps 25 --v_bitrate 2000000 --no-sound'

alias 'lsd=ls -l | grep "^d"'

alias 'setxrandr=xrandr --newmode "1920x1080" 173.00  1920 2048 2248 2576  1080 1083 1088 1120 -hsync +vsync'
alias 'addxrandrmod=xrandr --addmode VGA1 "1920x1080"'
alias 'setupxrandr=xrandr --newmode "1920x1080" 173.00  1920 2048 2248 2576  1080 1083 1088 1120 -hsync +vsync && xrandr --addmode VGA1 "1920x1080"'

alias 'clojure=java -cp /home/sinan/cclojure/lib/clojure-1.2.1.jar:/home/sinan/cclojure/lib/clojure-contrib-1.2.0.jar clojure.main '
alias 'cljsc=/home/sinan/opt/clojurescript/bin/cljsc'

alias 'resetcabal=rm -rf /home/sinan/.cabal && rm -rf /home/sinan/.ghc && cp -r /home/sinan/.cabal_yedek /home/sinan/.cabal && cp -r /home/sinan/.ghc_yedek /home/sinan/.ghc'

alias 'create_timelapse=ffmpeg -r 10 -f image2 -i %09d.jpg -vcodec mpeg4 -b:v 8000k timelapse.avi'

export TERM=xterm-256color
export PATH=/home/sinan/opt/apache-maven-3.0.4/bin:$PATH
export JAVA_HOME=/home/sinan/jdk1.7.0_03
export PATH=/home/sinan/jdk1.7.0_03/bin:$PATH
export PATH=/home/sinan/Downloads/racket/bin:$PATH
export PATH=/home/sinan/.cabal/bin:$PATH
export PATH=/home/sinan/node_modules/.bin:$PATH
export CLASSPATH=/home/sinan/CLASSPATH

