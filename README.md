Android SDK Launcher
====================

This application is just a launcher for Android SDK and AVD manager application.

For building launcher, please read INSTALL.md file.

Known Limitations
-----------------

Current version does not take care about multi-user environment, it installs
downloaded tools/platforms/others directly into app inside. This is not a best
behavior but it has a positive side-effect: if you take care about backup of
the app it will always contain your required stuffs, so you do not need re-download
them when you moving to another Mac.

Currently the SDK itself does not take care about multi-user environment too and there
is no easy way to support this limitation. So if you need support multi-user environment
you have to install the app into every user's own Applications directory.

Questions, ideas
----------------

If you have any question, problem or enhancing idea regarding to this app, please file
an issue under the Issues tab of the repo of the project (or just [click here](https://github.com/hron84/android-app/issues)).

License
-------

This program is licensed under the terms of CreativeCommons BY 3.0 license, read
LICENSE file for details.

The Android trademark and the green robot mascot is owned by Google Inc. and, of course,
they reserve all rights.

The Android SDK is licensed under the terms of [Apache Software License 2.0](http://www.apache.org/licenses/LICENSE-2.0).

Copyright (c) 2011-2012 Gabor Garami
