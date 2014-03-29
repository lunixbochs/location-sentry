ARCHS = armv7 arm64
include theos/makefiles/common.mk

TWEAK_NAME = location
location_FILES = Tweak.xm XBLocationManager.m
location_FRAMEWORKS = UIKit
# location_CFLAGS = -I/Users/aegis/build/SpringBoard-Dumps

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"
