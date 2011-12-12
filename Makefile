MKSCRIPT = ./mkscript.sh
SDK_HOME = 

all: app

app: android.sh
	install -c -d Android.app/Contents/MacOS
	install -c -d Android.app/Contents/Resources
	install -c -m 0755 android.sh Android.app/Contents/MacOS
	install -c -m 0644 Info.plist Android.app/Contents
	install -c -m 0644 android.icns Android.app/Contents/Resources

android.sh: android.sh.in
	$(MKSCRIPT) "$(SDK_HOME)"
