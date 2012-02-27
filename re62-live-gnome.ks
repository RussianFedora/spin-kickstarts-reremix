########################################################################
#
#  LiveCD with gnome desktop
#
#  Urs Beyerle, ETHZ
#
########################################################################

part / --size 4096 --fstype ext4

########################################################################
# Include kickstart files
########################################################################

%include re62-live-base.ks
%include re62-extra-software.ks
%include re62-doc.ks


########################################################################
# Packages
########################################################################

%packages
# packages removed from @base
-bind-utils
-ed
-kexec-tools
-system-config-kdump
-libaio
-libhugetlbfs
-microcode_ctl
-psacct
-quota
-autofs
-smartmontools

@basic-desktop
# package removed from @basic-desktop
-gok

@desktop-platform
# packages removed from @desktop-platform
-redhat-lsb

@dial-up

@fonts

@general-desktop
# package removed from @general-desktop
-gnome-backgrounds
-gnome-user-share
-nautilus-sendto
-orca
rhythmbox
-vino
gparted
totem-mozplugin

@input-methods
@print-client
@internet-applications
# package added to @internet-applications
xchat
# packages removed from @internet-applications
ekiga

@internet-browser


### SL LiveCD specific changes

## packages to remove to save diskspace
thunderbird
-evolution
-evolution-help
-evolution-mapi
-scenery-backgrounds
-redhat-lsb-graphics
-qt3
-qt
-qt-x11
-qt-sqlite
-phonon-backend-gstreamer
-ibus-qt
-xinetd
-pinentry-gtk
seahorse
-hunspell-*
-words
-nano
-pinfo
-vim-common

evince
gimp
totem-mozplugin
transmission-gtk
pidgin
remmina
parcellite

## remove some fonts and input methods
# remove Chinese font (Ming face) (8.9 MB)
# we still have wqy-zenhei-fonts 
-cjkuni-fonts-common
-cjkuni-uming-fonts
# remove Korean input method (2.1 MB)
-ibus-hangul
-libhangul

## packages to add
lftp
#@openafs-client
cups
cups-pk-helper

%end


########################################################################
# Post installation
########################################################################

%post

# remove folders/files that use a lot of diskspace
# and are not really needed for LiveCD
rm -rf /usr/share/doc/openafs-*
rm -rf /usr/share/doc/testdisk-*

%end
