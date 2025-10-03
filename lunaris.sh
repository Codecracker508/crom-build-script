#!/bin/bash

repo init -u https://github.com/Lunaris-AOSP/android -b 16 --git-lfs
repo sync -c --force-sync --optimized-fetch --no-tags --no-clone-bundle --prune -j$(nproc --all)

./keys.sh

sed -i \
-e 's#<string name="lunaris_device_message">.*</string>#<string name="lunaris_device_message">Realme GT Neo 3T</string>#' \
-e 's#<string name="lunaris_processor_code_message">.*</string>#<string name="lunaris_processor_code_message">Snapdragon 870</string>#' \
-e 's#<string name="lunaris_battery_type_message">.*</string>#<string name="lunaris_battery_type_message">5000 mAh</string>#' \
-e 's#<string name="lunaris_screen_message">.*</string>#<string name="lunaris_screen_message">AMOLED 120Hz</string>#' \
packages/apps/Settings/res/values/lunaris_strings.xml

echo "Cloning device trees"
/.clone-device-trees.sh

echo "Continue adding the build flags etc.. check https://github.com/Lunaris-AOSP/android"