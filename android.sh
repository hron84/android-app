#!/bin/bash

ME=$0
MYDIR=$(dirname $0)
SDK_HOME=$(cd ${MYDIR}/../Frameworks/AndroidSDK.framework/Versions/Current/Resources && pwd -P)

exec ${SDK_HOME}/tools/android
