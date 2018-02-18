# crontab entry to run at 3AM every day:
# 0 3 * * * /home/omer/rcbackup/ghc_nightly.sh >>/home/omer/ghc_nightly_log 2>&1

DATE=`date +%d-%m-%Y`
DIR="/home/omer/haskell/ghc_$DATE"

set -e
set -x

git clone --recursive git://git.haskell.org/ghc.git $DIR
cd $DIR
./boot
./configure
time make
