#!/bin/sh

if [ -z "$1" ]; then
  echo "SDK HOME is missing"
  exit 1
fi

if [ ! -x "$1/tools/android" ]; then
  echo "Android SDK manager missing"
  exit 1
fi

sed "s,@@SDK_HOME@@,$1," android.sh.in > android.sh
