#!/usr/bin/make -f

INSTALL = /usr/bin/install

sysconfdir ?= /etc
prefix ?= /usr/local
bindir = $(prefix)/bin
mandir = $(prefix)/share/man
instdir = kernel/install.d

scripts = $(notdir $(wildcard install/*.install))

.PHONY: all install

install:
	@$(INSTALL) -d ${DESTDIR}${bindir}
	@$(INSTALL) kernel-install ${DESTDIR}${bindir}
	@echo "install kernel-install to ${DESTDIR}${bindir}"
	@$(INSTALL) -d ${DESTDIR}${sysconfdir}/${instdir}
	@$(INSTALL) -d ${DESTDIR}${prefix}/lib/${instdir}
	@for i in ${scripts} ; do \
		$(INSTALL) install/$$i ${DESTDIR}${prefix}/lib/${instdir}/$$i ; \
		echo "install '$$(basename $$i .install)' to ${DESTDIR}${prefix}/lib/${instdir}" ; \
	done
	@$(INSTALL) -d ${DESTDIR}${mandir}/man8
	@$(INSTALL) man/kernel-install.8 ${DESTDIR}${mandir}/man8
	@echo "install kernel-install.8 to ${DESTDIR}${mandir}/man8"
