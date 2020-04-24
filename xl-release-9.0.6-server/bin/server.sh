#!/bin/bash

echo "The use of server.sh has been deprecated, starting XL Release from run.sh"
absdirname ()
{
  _dir="`dirname \"$1\"`"
  cd "$_dir"
  echo "`pwd`"
}

resolvelink() {
  _dir=`dirname "$1"`
  _dest=`readlink "$1"`
  case "$_dest" in
  /* ) echo "$_dest" ;;
  *  ) echo "$_dir/$_dest" ;;
  esac
}

self="$0"
if [ -h "$self" ]; then
    self=`resolvelink "$self"`
fi

BIN_DIR=`absdirname "$self"`

"$BIN_DIR/run.sh" "$@"
