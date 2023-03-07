LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

LOCAL_MODULE := kirikiri2
LOCAL_MODULE_FILENAME := libkirikiri2


LOCAL_SRC_FILES := $(LOCAL_PATH)/hellocpp/main.cpp \
                   $(LOCAL_PATH)/../../../src/cocos/AppDelegate.cpp \
                   $(LOCAL_PATH)/../../../src/cocos/HelloWorldScene.cpp
LOCAL_C_INCLUDES := $(LOCAL_PATH)/../../../src/cocos

LOCAL_STATIC_LIBRARIES := cc_static
include $(BUILD_SHARED_LIBRARY)
$(call import-module, cocos)