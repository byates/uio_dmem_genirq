################################################################################
#
# uio_dmem_genirq
#
################################################################################

UIO_DMEM_GENIRQ_VERSION = 1.0.0
UIO_DMEM_GENIRQ_SITE_METHOD = wget
UIO_DMEM_GENIRQ_SOURCE = $(UIO_DMEM_GENIRQ_VERSION).tar.gz
UIO_DMEM_GENIRQ_SITE = https://github.com/byates/uio_dmem_genirq/archive
UIO_DMEM_GENIRQ_LICENSE = GPL-2.0
UIO_DMEM_GENIRQ_INSTALL_STAGING = NO
UIO_DMEM_GENIRQ_INSTALL_TARGET = YES

# ------------------------------------------------------------------------
# THESE VARIABLES ARE REQUIRED BY THE KMOD MAKEFILE
#
# Kernel location is calculated form the base location assuming the
# standard directory layout and that buildroot takes care of building
# the kernel. The BASE_DIR is the overlay (external) location.
export SOC_LINUX_KERNEL_LOC=$(abspath $(wildcard $(BASE_DIR)/../buildroot/output/build/linux-socfpga-*))
export ARCH=arm

define UIO_DMEM_GENIRQ_BUILD_CMDS
	$(MAKE) $(TARGET_CONFIGURE_OPTS) -C $(@D) all
endef

# Files that may exists on target and SDK. Typically all libraries (static and
# shared), all config files, etc.
define UIO_DMEM_GENIRQ_INSTALL_STAGING_CMDS
endef

# Files that only need to be on the target. Compared to staging/,
# target/ contains only the files and libraries needed to run the
# selected target applications: the development files (headers,
# etc.) are not present, the binaries are stripped.
define UIO_DMEM_GENIRQ_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0755 $(@D)/uio_dmem_genirq.ko $(TARGET_DIR)/lib/modules/uio_dmem_genirq.ko
	$(INSTALL) -D -m 0755 $(@D)/S30_uio_dmem_genirq $(TARGET_DIR)/etc/init.d/S30_uio_dmem_genirq
endef

$(eval $(generic-package))
