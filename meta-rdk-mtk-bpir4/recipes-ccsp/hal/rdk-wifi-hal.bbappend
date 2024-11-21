CFLAGS_append = " -D_PLATFORM_BANANAPI_R4_  -DBANANA_PI_PORT -Wno-return-type -Wno-error=missing-field-initializers -Wno-error=unused-variable -Wno-error=sizeof-pointer-div -Wno-error=sizeof-pointer-memaccess -Wno-unused-function"
CFLAGS_append_kirkstone = " -fcommon"
EXTRA_OECONF_append = " ${@bb.utils.contains('DISTRO_FEATURES', 'OneWifi', ' ONE_WIFIBUILD=true ', '', d)}"
EXTRA_OECONF_append = " ${@bb.utils.contains('DISTRO_FEATURES', 'OneWifi', ' BANANA_PI_PORT=true ', '', d)}"

FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

SRC_URI += " \
  file://InterfaceMap.json \
"

# Install InterfaceMap.json in /nvram
do_install_append() {
  install -d ${D}/nvram
  install -m 0644 ${WORKDIR}/InterfaceMap.json ${D}/nvram/InterfaceMap.json
}

FILES_${PN} += " \
  /nvram/InterfaceMap.json \
"
