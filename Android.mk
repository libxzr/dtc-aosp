# Copyright (C) 2023 LibXZR <i@xzr.moe>. All Rights Reserved.
# Usage: ndk-build NDK_PROJECT_PATH=. APP_BUILD_SCRIPT=Android.mk

LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)
include $(LOCAL_PATH)/libfdt/Makefile.libfdt
LOCAL_MODULE := libfdt
LOCAL_SRC_FILES := $(patsubst %,$(LOCAL_PATH)/libfdt/%,$(LIBFDT_SRCS))
LOCAL_C_INCLUDES := $(LOCAL_PATH)/libfdt
include $(BUILD_STATIC_LIBRARY)

include $(CLEAR_VARS)
include $(LOCAL_PATH)/Makefile.dtc
LOCAL_MODULE := dtc
LOCAL_SRC_FILES := $(DTC_SRCS) $(DTC_GEN_SRCS)
LOCAL_C_INCLUDES := $(LOCAL_PATH)/libfdt
LOCAL_STATIC_LIBRARIES := libfdt
LOCAL_LDFLAGS := -static
include $(BUILD_EXECUTABLE)

dtc-lexer.lex.c: dtc-lexer.l dtc-parser.tab.h
	flex -o$@ $<

%.tab.c %.tab.h %.output: %.y
	bison -d $<
