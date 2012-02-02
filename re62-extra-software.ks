########################################################################
#
# re62-extra-software.ks
#
# Extra software for SL LiveCD
#
########################################################################

#repo --name=livecd-extra     --baseurl=http://www.livecd.ethz.ch/download/livecd-extra/6/$basearch/

%packages

# install yum-conf-livecd-extra
#yum-conf-livecd-extra
#livecd-extra-release

# install extra software from rpmforge
flash-plugin
gstreamer-ffmpeg
gstreamer-plugins-ugly
gstreamer-plugins-bad

# install extra software from epel
gparted
NetworkManager-openvpn
NetworkManager-vpnc
NetworkManager-pptp
NetworkManager-openswan
vpnc-consoleuser
ntfs-3g
fuse-sshfs
ntfsprogs
dd_rescue
ddrescue
iperf

# install extra software from elrepo
#kmod-reiserfs
#kmod-ndiswrapper
#reiserfs-utils

# office
libreoffice-langpack-en
libreoffice-writer
libreoffice-math
libreoffice-impress
libreoffice-draw
libreoffice-calc
autocorr-en
totem-mozplugin
java-1.6.0-openjdk
icedtea-web

%end
