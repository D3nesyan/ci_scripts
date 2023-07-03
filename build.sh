#!/bin/bash

# Setup
git config --global user.name "Ratoriku"
git config --global user.email "d3nesyan@jmu.edu.cn"
mkdir ~/bin
PATH=~/bin:$PATH
curl https://storage.googleapis.com/git-repo-downloads/repo > ~/bin/repo
chmod a+x ~/bin/repo

# Sync
mkdir twrp
cd twrp
repo init --depth=1 -u https://github.com/minimal-manifest-twrp/platform_manifest_twrp_aosp.git -b twrp-12.1
repo sync
git clone https://$GITID:$GITPWD@github.com/Ratoriku/android_device_xiaomi_lavender-twrp -b ofox device/xiaomi/lavender

# Build
export ALLOW_MISSING_DEPENDENCIES=true
. build/envsetup.sh
lunch twrp_lavender-eng
mka recoveryimage

# Upload
curl -s https://api.telegram.org/bot"${bot_token}"/sendDocument -F document=@out/target/product/lavender/recovery.img -F chat_id="${chat_id}"
