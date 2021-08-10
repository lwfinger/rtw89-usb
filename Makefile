# SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause

KERNELDIR ?= /lib/modules/$(shell uname -r)/build
PWD       := $(shell pwd)

CONFIG_RTW89=m
CONFIG_RTW89_CORE=m
CONFIG_RTW89_USB=m
CONFIG_RTW89_PCI=m
CONFIG_RTW89_8852AE=m
CONFIG_RTW89_DEBUG=y
CONFIG_RTW89_DEBUGMSG=y
CONFIG_RTW89_DEBUGFS=y

########### section below is for upstream kernel ###########

obj-$(CONFIG_RTW89_CORE) += rtw89_core.o
rtw89_core-y += core.o \
		mac80211.o \
		mac.o \
		phy.o \
		fw.o \
		rtw8852a.o \
		rtw8852a_table.o \
		rtw8852a_rfk.o \
		rtw8852a_rfk_table.o \
		cam.o \
		efuse.o \
		regd.o \
		sar.o \
		coex.o \
		ps.o \
		util.o \
		ser.o

rtw89_core-$(CONFIG_RTW89_DEBUG) += debug.o

obj-$(CONFIG_RTW89_USB) += rtw89_usb.o
rtw89_usb-y := usb.o

obj-$(CONFIG_RTW89_PCI) += rtw89pci.o
rtw89pci-y := pci.o


########### section above is for upstream kernel ###########

SUBARCH := $(shell uname -m | sed -e s/i.86/i386/)
ARCH ?= $(SUBARCH)

all:
	$(MAKE) ARCH=$(ARCH) CROSS_COMPILE=$(CROSS_COMPILE) -C $(KERNELDIR) M=$(PWD)

cscope:
	find ./ -name "*.[ch]" > cscope.files
	cscope -Rbq -i cscope.files
	ctags -R --exclude=.git

.PHONY: clean

clean:
	rm -f *.o .*.d *.a *.ko .*.cmd *.mod* *.order *.symvers *.tmp_versions

