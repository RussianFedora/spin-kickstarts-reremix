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

# make kdm russian
if [ -f /etc/kde/kdm/kdmrc ]; then
    if [ "\`echo \$LANG | awk -F_ '{print \$1}'\`" == "ru" ]; then
sed -i 's!#Language=de_DE!Language=ru_RU!' /etc/kde/kdm/kdmrc
    fi
fi

EOF_initscript

%end
