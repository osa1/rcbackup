#! /usr/bin/env sh

# https://github.com/chisui/zsh-nix-shell/blob/master/scripts/buildShellShim.zsh

if [ "$1" = "--rcfile" ]; then
  # the rcfile flag indicates that the --command option was used.
  # This means the shell should stay open after executing. So we remove the last line which contains 'exit'
  shift
  tmp="$(cat $1)"
  echo ${tmp%exit} > $1
  echo $NIX_EXECUTING_SHELL >> $1
  bash $1
else
  bash "$@"
fi
