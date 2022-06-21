#!/bin/bash
########	Enable for step by step debugging	######
# set -x
# trap read debug
######################################################

flutter config --android-studio-dir ~/android-studio/
export PATH="$PATH:~/snap/flutter/common/flutter/bin"
echo $PATH
which flutter dart
flutter doctor -v
flutter devices
flutter run
