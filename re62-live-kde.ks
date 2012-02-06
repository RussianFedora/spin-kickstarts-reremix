########################################################################
#
#  LiveDVD with gnome (default), kde and icewm desktop
#
#  Urs Beyerle, ETHZ
#
########################################################################

part / --size 8192 --fstype ext4

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
# package added to @network-tools
nmap
@desktop-platform
@fonts
@kde-desktop
konversation
thunderbird
firefox
libreoffice-calc
libreoffice-draw
libreoffice-impress
libreoffice-math
libreoffice-writer
@print-client
@system-admin-tools
k3b-extras-freeworld
kdm
system-config-firewall
vlc
vlc-extras
transmission-qt
-system-config-kdump

# more groups added 
lftp

%end

%post
cat >> /etc/rc.d/init.d/livesys << EOF_initscript

# make liveuser use KDE
echo "startkde" > /home/liveuser/.xsession
chmod a+x /home/liveuser/.xsession
chown liveuser:liveuser /home/liveuser/.xsession

# set up autologin for user liveuser
sed -i 's/#AutoLoginEnable=true/AutoLoginEnable=true/' /etc/kde/kdm/kdmrc
sed -i 's/#AutoLoginUser=fred/AutoLoginUser=liveuser/' /etc/kde/kdm/kdmrc

# set up user liveuser as default user and preselected user
sed -i 's/#PreselectUser=Default/PreselectUser=Default/' /etc/kde/kdm/kdmrc
sed -i 's/#DefaultUser=johndoe/DefaultUser=liveuser/' /etc/kde/kdm/kdmrc

# add liveinst.desktop to favorites menu
#mkdir -p /home/liveuser/.kde/share/config/
#cat > /home/liveuser/.kde/share/config/kickoffrc << MENU_EOF
#[Favorites]
#FavoriteURLs=/usr/share/applications/kde4/konqbrowser.desktop,/usr/share/applications/kde4/dolphin.desktop,/usr/share/applications/kde4/systemsettings.desktop,/usr/share/applications/liveinst.desktop
#MENU_EOF

# show liveinst.desktop on desktop and in menu
sed -i 's/NoDisplay=true/NoDisplay=false/' /usr/share/applications/liveinst.desktop

# chmod +x ~/Desktop/liveinst.desktop to disable KDE's security warning
chmod +x /usr/share/applications/liveinst.desktop

# copy over the icons for liveinst to hicolor
cp /usr/share/icons/gnome/16x16/apps/system-software-install.png /usr/share/icons/hicolor/16x16/apps/
cp /usr/share/icons/gnome/22x22/apps/system-software-install.png /usr/share/icons/hicolor/22x22/apps/
cp /usr/share/icons/gnome/24x24/apps/system-software-install.png /usr/share/icons/hicolor/24x24/apps/
cp /usr/share/icons/gnome/32x32/apps/system-software-install.png /usr/share/icons/hicolor/32x32/apps/
cp /usr/share/icons/gnome/scalable/apps/system-software-install.svg /usr/share/icons/hicolor/scalable/apps/
touch /usr/share/icons/hicolor/

# make kdm russian
if [ -f /etc/kde/kdm/kdmrc ]; then
    if [ "\`echo \$LANG | awk -F_ '{print \$1}'\`" == "ru" ]; then
sed -i 's!#Language=de_DE!Language=ru_RU!' /etc/kde/kdm/kdmrc
    fi
fi

EOF_initscript

%end
