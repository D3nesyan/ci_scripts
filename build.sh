#!/bin/bash

# Setup
git config --global user.name "Ratoriku"
git config --global user.email "a1063021545@gmail.com"
rm /usr/bin/python
ln -s /usr/bin/python2 /usr/bin/python
mkdir ~/bin
PATH=~/bin:$PATH
curl https://storage.googleapis.com/git-repo-downloads/repo > ~/bin/repo
chmod a+x ~/bin/repo

# Sync
mkdir twrp
cd twrp
repo init --depth=1 -u git://github.com/minimal-manifest-twrp/platform_manifest_twrp_omni.git -b twrp-9.0
repo sync
git clone https://$GITID:$GITPWD@github.com/Ratoriku/android_device_xiaomi_lavender-twrp -b ofox device/xiaomi/lavender
rm -rf bootable/recovery
git clone https://github.com/Jabiyeff/android_bootable_recovery --depth=1 bootable/recovery

# Build
export ALLOW_MISSING_DEPENDENCIES=true
. build/envsetup.sh
lunch omni_lavender-eng
mka recoveryimage

# Upload
curl -s https://api.telegram.org/bot"${bot_token}"/sendDocument -F document=@out/target/product/lavender/recovery.img -F chat_id="${chat_id}"
