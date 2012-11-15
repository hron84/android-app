VERSION = 21
SDK_ZIP = android-sdk_r$(VERSION)-macosx.zip
SDK_URL = http://dl.google.com/android/$(SDK_ZIP)
PT_ZIP = $(shell ruby fetch-plattools.rb -n)
TOPDIR = $(shell pwd)
BUILD_DIR = $(TOPDIR)/build
DIST_DIR = $(TOPDIR)/dist

all: clean app dist

app: android.sh sdk-zip plat-zip
	@echo " >>> Unpacking ... " && \
	unzip -qq $(SDK_ZIP) && \
	unzip -qq -d android-sdk-macosx $(PT_ZIP)
	@echo " >>> Bootstrapping application ..." && \
	install -c -d $(BUILD_DIR)/Android.app/Contents/MacOS && \
	install -c -d $(BUILD_DIR)/Android.app/Contents/Resources && \
	install -c -d $(BUILD_DIR)/Android.app/Contents/Frameworks/AndroidSDK.framework/Versions/$(VERSION)/Resources && \
	ln -s $(VERSION) $(BUILD_DIR)/Android.app/Contents/Frameworks/AndroidSDK.framework/Versions/Current && \
	ln -s Versions/$(VERSION)/Resources $(BUILD_DIR)/Android.app/Contents/Frameworks/AndroidSDK.framework/Resources && \
	install -c -m 0755 android.sh $(BUILD_DIR)/Android.app/Contents/MacOS && \
	install -c -m 0644 Info.plist $(BUILD_DIR)/Android.app/Contents && \
	install -c -m 0644 android.icns $(BUILD_DIR)/Android.app/Contents/Resources
	@echo " >>> Copying SDK ..." && \
	cp -pPR android-sdk-macosx/* $(BUILD_DIR)/Android.app/Contents/Frameworks/AndroidSDK.framework/Versions/$(VERSION)/Resources/

clean:
	-rm -fr $(BUILD_DIR) $(DIST_DIR) android-sdk-macosx image

dist: app-dmg

distclean: clean
	-rm -f $(SDK_ZIP) $(PT_ZIP)

app-dmg:
	@echo " >>> Building disk image ..." && \
	rm -f $(DIST_DIR)/"Android.app-$(VERSION).dmg" && \
	install -c -d image && \
	install -c -d $(DIST_DIR) && \
	cp -pPR android-sdk-macosx/SDK\ Readme.txt build/Android.app image/ && \
	ln -s /Applications image/Applications && \
	hdiutil create -volname "Android SDK App $(VERSION)" -srcfolder image $(DIST_DIR)/"Android.app-$(VERSION).dmg" && \
	rm -fr image

app-zip:
	@echo " >>> Compressing release ..." && \
	install -c -d $(DIST_DIR) && \
	cd $(BUILD_DIR) && \
	zip -qqr $(DIST_DIR)/Android.app-$(VERSION).zip Android.app

sdk-zip: $(SDK_ZIP)

plat-zip: $(PT_ZIP)

$(SDK_ZIP):
	@echo " >>> Downloading $(SDK_ZIP) ..." && \
	curl -fOLksS $(SDK_URL)

$(PT_ZIP):
	@echo " >>> Downloading $(PT_ZIP) ..." && \
	/usr/bin/ruby fetch-plattools.rb
