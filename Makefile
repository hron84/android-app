VERSION = 20.0.3
SDK_ZIP = android-sdk_r$(VERSION)-macosx.zip
SDK_URL = http://dl.google.com/android/$(SDK_ZIP)
TOPDIR = $(shell pwd -P)
BUILD_DIR = $(TOPDIR)/build
DIST_DIR = $(TOPDIR)/dist

all: clean app dist

app: android.sh sdk-zip
	@echo " >>> Unpacking ... " && \
	unzip -qq $(SDK_ZIP)
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
	-rm -fr $(BUILD_DIR) $(DIST_DIR) android-sdk-macosx

dist: app-zip

distclean: clean
	-rm -f $(SDK_ZIP)

app-zip:
	@echo " >>> Compressing release ..." && \
	install -c -d $(DIST_DIR) && \
	cd $(BUILD_DIR) && \
	zip -qqr $(DIST_DIR)/Android.app-$(VERSION).zip Android.app

sdk-zip: $(SDK_ZIP)

$(SDK_ZIP):
	curl -fOLksS $(SDK_URL)
