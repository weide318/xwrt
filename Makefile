# Main makefile for the packages
include $(TOPDIR)/rules.mk

package-:=tcp_wrappers
package-y:=nvram
package-$(BR2_PACKAGE_AICCU) += aiccu
package-$(BR2_PACKAGE_ARPTABLES) += arptables
package-$(BR2_PACKAGE_ARPWATCH) += arpwatch
package-$(BR2_PACKAGE_ASTERISK) += asterisk
package-$(BR2_PACKAGE_BRIDGE) += bridge
package-$(BR2_PACKAGE_BUSYBOX) += busybox
package-$(BR2_PACKAGE_BWM) += bwm
package-$(BR2_PACKAGE_CHILLISPOT) += chillispot
package-$(BR2_PACKAGE_CIFSMOUNT) += cifsmount
package-$(BR2_PACKAGE_CPU) += cpu
package-$(BR2_PACKAGE_INT2HUMAN) += int2human
package-$(BR2_PACKAGE_CTORRENT) += ctorrent
package-$(BR2_PACKAGE_CURL) += curl
package-$(BR2_PACKAGE_CUPS) += cups
package-$(BR2_PACKAGE_CYRUS_SASL) += cyrus-sasl
package-$(BR2_PACKAGE_DHCP_FORWARDER) += dhcp-forwarder
package-$(BR2_PACKAGE_DNSMASQ) += dnsmasq
package-$(BR2_PACKAGE_DROPBEAR) += dropbear
package-$(BR2_PACKAGE_DSL_QOS_QUEUE) += dsl-qos-queue
package-$(BR2_PACKAGE_DSNIFF) += dsniff
package-$(BR2_PACKAGE_EBTABLES) += ebtables
package-$(BR2_PACKAGE_EZIPUPDATE) += ez-ipupdate
package-$(BR2_PACKAGE_FAKEIDENTD) += fakeidentd
package-$(BR2_PACKAGE_TARFS) += tarfs
package-$(BR2_PACKAGE_FPING) += fping
package-$(BR2_PACKAGE_FPROBE) += fprobe
package-$(BR2_PACKAGE_FREERADIUS) += freeradius
package-$(BR2_PACKAGE_FRICKIN) += frickin
package-$(BR2_PACKAGE_FUSE) += fuse
package-$(BR2_PACKAGE_COMGT) += comgt
package-$(BR2_PACKAGE_GLIB) += glib
package-$(BR2_PACKAGE_GMP) += gmp
package-$(BR2_PACKAGE_HASERL) += haserl
package-$(BR2_PACKAGE_HOWL) += howl
package-$(BR2_PACKAGE_HTPDATE) += htpdate
package-$(BR2_PACKAGE_IPKG) += ipkg
package-$(BR2_PACKAGE_IPKG_UPGRADE_FIX) += ipkg-upgrade-fix
package-$(BR2_PACKAGE_IPROUTE2) += iproute2
package-$(BR2_PACKAGE_IPTABLES) += iptables
package-$(BR2_PACKAGE_KISMET) += kismet
package-$(BR2_PACKAGE_L2TPD) += l2tpd
package-$(BR2_PACKAGE_LCD4LINUX) += lcd4linux
package-$(BR2_PACKAGE_LIBDB) += libdb
package-$(BR2_PACKAGE_LIBELF) += libelf
package-$(BR2_PACKAGE_LIBEVENT) += libevent
package-$(BR2_PACKAGE_LIBFFI_SABLE) += libffi-sable
package-$(BR2_PACKAGE_LIBGD) += libgd
package-$(BR2_PACKAGE_LIBGDBM) += libgdbm
package-$(BR2_PACKAGE_LIBNET) += libnet
package-$(BR2_PACKAGE_LIBNIDS) += libnids
package-$(BR2_PACKAGE_LIBOSIP2) += libosip2
package-$(BR2_PACKAGE_LIBPCAP) += libpcap
package-$(BR2_PACKAGE_LIBPNG) += libpng
package-$(BR2_PACKAGE_LIBPTHREAD) += libpthread
package-$(BR2_PACKAGE_LIBTOOL) += libtool
package-$(BR2_PACKAGE_LIBUSB) += libusb
package-$(BR2_PACKAGE_LIBXML2) += libxml2
package-$(BR2_PACKAGE_LIGHTTPD) += lighttpd
package-$(BR2_PACKAGE_LUA) += lua
package-$(BR2_PACKAGE_LZO) += lzo
package-$(BR2_PACKAGE_MARADNS) += maradns
package-$(BR2_PACKAGE_MATRIXSSL) += matrixssl
package-$(BR2_PACKAGE_MATRIXTUNNEL) += matrixtunnel
package-$(BR2_PACKAGE_MADWIFI_TOOLS) += madwifi-tools
package-$(BR2_PACKAGE_MICROCOM) += microcom
package-$(BR2_PACKAGE_MICROPERL) += microperl
package-$(BR2_PACKAGE_MINIUPNPD) += miniupnpd
package-$(BR2_PACKAGE_MONIT) += monit
package-$(BR2_PACKAGE_MTD) += mtd
package-$(BR2_PACKAGE_MYSQL) += mysql
package-$(BR2_PACKAGE_NANO) += nano
package-$(BR2_PACKAGE_NAS) += nas
package-$(BR2_PACKAGE_NZBGET) += nzbget
package-$(BR2_PACKAGE_NCURSES) += ncurses
package-$(BR2_PACKAGE_NDISC) += ndisc
package-$(BR2_PACKAGE_NET_SNMP) += net-snmp
package-$(BR2_PACKAGE_NFS_SERVER) += nfs-server
package-$(BR2_PACKAGE_NMAP) += nmap
package-$(BR2_PACKAGE_NOCATSPLASH) += nocatsplash
package-$(BR2_PACKAGE_NTPCLIENT) += ntpclient
package-$(BR2_PACKAGE_OLSRD) += olsrd
package-$(BR2_PACKAGE_OPENLDAP) += openldap
package-$(BR2_PACKAGE_OPENNTPD) += openntpd
package-$(BR2_PACKAGE_OPENSER) += openser
package-$(BR2_PACKAGE_OPENSSH) += openssh
package-$(BR2_PACKAGE_OPENSSL) += openssl
package-$(BR2_PACKAGE_OPENSWAN) += openswan
package-$(BR2_PACKAGE_OPENVPN) += openvpn
package-$(BR2_PACKAGE_OSIRIS) += osiris
package-$(BR2_PACKAGE_PCIUTILS) += pciutils
package-$(BR2_COMPILE_PCMCIA_CS) += pcmcia-cs
package-$(BR2_PACKAGE_PCRE) += pcre
package-$(BR2_PACKAGE_PICOCOM) += picocom
package-$(BR2_PACKAGE_PMACCT) += pmacct
package-$(BR2_PACKAGE_POPT) += popt
package-$(BR2_PACKAGE_PORTMAP) += portmap
package-$(BR2_PACKAGE_POSTGRESQL) += postgresql
package-$(BR2_PACKAGE_PPP) += ppp
package-$(BR2_PACKAGE_PPTP) += pptp
package-$(BR2_PACKAGE_PPTPD) += pptpd
package-$(BR2_PACKAGE_PROCPS) += procps
package-$(BR2_PACKAGE_PSMISC) += psmisc
package-$(BR2_PACKAGE_QOS_SCRIPTS) += qos-scripts
package-$(BR2_PACKAGE_QUAGGA) += quagga
package-$(BR2_PACKAGE_RADVD) += radvd
package-$(BR2_COMPILE_RADIUSCLIENT_NG) += radiusclient-ng
package-$(BR2_PACKAGE_READLINE) += readline
package-$(BR2_PACKAGE_ROBOCFG) += robocfg
package-$(BR2_PACKAGE_RSYNC) += rsync
package-$(BR2_PACKAGE_SABLEVM) += sablevm
package-$(BR2_PACKAGE_SABLEVM_CLASSPATH) += sablevm-classpath
package-$(BR2_PACKAGE_SCREEN) += screen
package-$(BR2_PACKAGE_SDK) += sdk
package-$(BR2_PACKAGE_SETSERIAL) += setserial
package-$(BR2_PACKAGE_SHAT) += shat
package-$(BR2_PACKAGE_SHFS) += shfs
package-$(BR2_PACKAGE_SIPROXD) += siproxd
package-$(BR2_PACKAGE_SIPSAK) += sipsak
package-$(BR2_PACKAGE_SNORT) += snort
package-$(BR2_PACKAGE_SPEEX) += speex
package-$(BR2_PACKAGE_SQLITE) += sqlite
package-$(BR2_PACKAGE_STRACE) += strace
package-$(BR2_PACKAGE_STUNNEL) += stunnel
package-$(BR2_PACKAGE_TCPDUMP) += tcpdump
package-$(BR2_PACKAGE_TINC) += tinc
package-$(BR2_PACKAGE_TOR) += tor
package-$(BR2_PACKAGE_TTCP) += ttcp
package-$(BR2_PACKAGE_UCLIBCXX) += uclibc++
package-$(BR2_PACKAGE_ULOGD) += ulogd
package-$(BR2_PACKAGE_USBUTILS) += usbutils
package-$(BR2_PACKAGE_VTUN) += vtun
package-$(BR2_PACKAGE_VSFTPD) += vsftpd
package-$(BR2_PACKAGE_WEBIF) += webif
package-$(BR2_PACKAGE_WEPKEYGEN) += wepkeygen
package-$(BR2_PACKAGE_WIFICONF) += wificonf
package-$(BR2_COMPILE_WIRELESS_TOOLS) += wireless-tools
package-$(BR2_PACKAGE_WOL) += wol
package-$(BR2_PACKAGE_WPA_SUPPLICANT) += wpa_supplicant
package-$(BR2_PACKAGE_WPUT) += wput
package-$(BR2_PACKAGE_XINETD) += xinetd
package-$(BR2_PACKAGE_ZLIB) += zlib
#package-$(BR2_PACKAGE_ZLIB) += webfone

DEV_LIBS:=tcp_wrappers glib ncurses openssl pcre popt zlib libnet libpcap mysql postgresql iptables matrixssl lzo gmp fuse portmap libelf uclibc++ speex libpng libgd wireless-tools nvram libusb net-snmp
DEV_LIBS_COMPILE:=$(patsubst %,%-compile,$(DEV_LIBS))
SDK_DEFAULT_PACKAGES:=busybox dnsmasq iptables wireless-tools dropbear bridge ipkg ppp
SDK_DEFAULT_COMPILE:=$(patsubst %,%-compile,$(SDK_DEFAULT_PACKAGES))
COMPILE_PACKAGES:=$(patsubst %,%-compile,$(package-y) $(package-m))
INSTALL_PACKAGES:=$(patsubst %,%-install,$(package-y))

all: compile
clean: $(patsubst %,%-clean,$(package-) $(package-y) $(package-m))
compile: $(COMPILE_PACKAGES)
install: base-files-install $(INSTALL_PACKAGES)

$(COMPILE_PACKAGES): base-files-compile
$(INSTALL_PACKAGES): base-files-install

arpwatch-compile: libpcap-compile
cyrus-sasl-compile: openssl-compile
dsniff-compile: libnids-compile openssl-compile libgdbm-compile
fprobe-compile: libpcap-compile
gdb-compile: ncurses-compile
kismet-compile: uclibc++-compile libpcap-compile ncurses-compile
lcd4linux-compile: ncurses-compile
libgd-compile: libpng-compile
libnet-compile: libpcap-compile
libnids-compile: libnet-compile
lighttpd-compile: openssl-compile pcre-compile
mysql-compile: ncurses-compile zlib-compile
net-snmp-compile: libelf-compile
nfs-server-compile: portmap-compile
nmap-compile: uclibc++-compile pcre-compile libpcap-compile
nocatsplash-compile: glib-compile
openldap-compile: cyrus-sasl-compile openssl-compile
openser-compile: radiusclient-ng-compile mysql-compile
openssh-compile: zlib-compile openssl-compile
openssl-compile: zlib-compile
openswan-compile: gmp-compile
osiris-compile: openssl-compile
portmap-compile: tcp_wrappers-compile
postgresql-compile: zlib-compile
ppp-compile: libpcap-compile
quagga-compile: readline-compile ncurses-compile
rsync-compile: popt-compile
screen-compile: ncurses-compile
siproxd-compile: libosip2-compile
sipsak-compile: openssl-compile
sqlite-compile: ncurses-compile readline-compile
tcpdump-compile: libpcap-compile
tinc-compile: zlib-compile openssl-compile lzo-compile
tor-compile: libevent-compile openssl-compile zlib-compile
usbutils-compile: libusb-compile
vtun-compile: zlib-compile openssl-compile lzo-compile
wificonf-compile: wireless-tools-compile nvram-compile
wpa_supplicant-compile: openssl-compile

stunnel-compile: openssl-compile tcp_wrappers-compile

asterisk-compile: ncurses-compile openssl-compile
ifneq ($(BR2_PACKAGE_ASTERISK_CODEC_SPEEX),)
asterisk-compile: speex-compile
endif
ifneq ($(BR2_PACKAGE_ASTERISK_PGSQL),)
asterisk-compile: postgresql-compile
endif
ifneq ($(BR2_PACKAGE_ASTERISK_MYSQL),)
asterisk-compile: mysql-compile
endif

freeradius-compile: libtool-compile openssl-compile
ifneq ($(BR2_PACKAGE_FREERADIUS_MOD_LDAP),)
freeradius-compile: openldap-compile
endif
ifneq ($(BR2_PACKAGE_FREERADIUS_MOD_SQL_MYSQL),)
freeradius-compile: mysql-compile
endif
ifneq ($(BR2_PACKAGE_FREERADIUS_MOD_SQL_PGSQL),)
freeradius-compile: postgresql-compile
endif

openvpn-compile: openssl-compile
ifeq ($(BR2_PACKAGE_OPENVPN_LZO),y)
openvpn-compile: lzo-compile
endif

pmacct-compile: libpcap-compile
ifneq ($(BR2_PACKAGE_PMACCT_MYSQL),)
pmacct-compile: mysql-compile
endif
ifneq ($(BR2_PACKAGE_PMACCT_PGSQL),)
pmacct-compile: postgresql-compile
endif
ifneq ($(BR2_PACKAGE_PMACCT_SQLITE),)
pmacct-compile: sqlite-compile
endif

snort-compile: libnet-compile libpcap-compile pcre-compile
ifeq ($(BR2_PACKAGE_SNORT_MYSQL),y)
snort-compile: mysql-compile
endif
ifeq ($(BR2_PACKAGE_SNORT_PGSQL),y)
snort-compile: postgresql-compile
endif
ifeq ($(BR2_PACKAGE_SNORT_ENABLE_INLINE),y)
snort-compile: iptables-compile
endif

ulogd-compile: iptables-compile
ifneq ($(BR2_PACKAGE_ULOGD_MYSQL),)
ulogd-compile: mysql-compile
endif
ifneq ($(BR2_PACKAGE_ULOGD_PCAP),)
ulogd-compile: libpcap-compile
endif
ifneq ($(BR2_PACKAGE_ULOGD_PGSQL),)
ulogd-compile: postgresql-compile
endif

sdk-compile: $(DEV_LIBS_COMPILE) $(SDK_DEFAULT_COMPILE)

$(STAMP_DIR):
	mkdir -p $@

%-prepare: $(STAMP_DIR)
	@[ -f $(STAMP_DIR)/.$@ ] || $(MAKE) -C $(patsubst %-prepare,%,$@) prepare
	@touch $(STAMP_DIR)/.$@

%-compile: %-prepare 
	@[ -f $(STAMP_DIR)/.$@ ] || $(MAKE) -C $(patsubst %-compile,%,$@) compile
	@touch $(STAMP_DIR)/.$@

%-install: %-compile
	@$(MAKE) -C $(patsubst %-install,%,$@) \
		TARGET_DIR="$(TARGET_DIR)" \
		IPKG_CONF="$(IPKG_CONF)" \
		BOARD="$(BOARD)" \
		install

%-rebuild: 
	@rm -f $(STAMP_DIR)/.$(patsubst %-rebuild,%,$@)-*
	$(MAKE) -C $(patsubst %-rebuild,%,$@) rebuild

%-clean:
	@$(MAKE) -C $(patsubst %-clean,%,$@) clean
	@rm -f $(STAMP_DIR)/.$(patsubst %-clean,%,$@)-*

