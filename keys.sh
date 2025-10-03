#!/bin/bash

# Ask which OS you are building
read -p "Enter the OS you are building (e.g., crDroid, lineage, aosp): " os_name

# Predefined values
country="IN"
state="AndhraPradesh"
locality="Nellore"
organization="$os_name"
organizational_unit="$os_name"
common_name="$os_name"
email="venkatasuresh752@gmail.com"

# Construct the subject line
subject="/C=${country}/ST=${state}/L=${locality}/O=${organization}/OU=${organizational_unit}/CN=${common_name}/emailAddress=${email}"

# Show subject line
echo "Using Subject Line:"
echo "$subject"
sleep 2
clear

# Create Key directory
echo "Press ENTER TWICE to skip password (about 10-15 enter hits total). Cannot use a password for inline signing!"
mkdir -p ~/.android-certs

for x in bluetooth media networkstack nfc platform releasekey sdk_sandbox shared testkey verifiedboot; do
    ./development/tools/make_key ~/.android-certs/$x "$subject"
done

# Create vendor keys folder
mkdir -p vendor/lineage-priv
mv ~/.android-certs vendor/lineage-priv/keys

echo "PRODUCT_DEFAULT_DEV_CERTIFICATE := vendor/lineage-priv/keys/releasekey" > vendor/lineage-priv/keys/keys.mk

cat <<EOF > vendor/lineage-priv/keys/BUILD.bazel
filegroup(
    name = "android_certificate_directory",
    srcs = glob([
        "*.pk8",
        "*.pem",
    ]),
    visibility = ["//visibility:public"],
)
EOF

echo "Done! Now build as usual. If builds aren't being signed, add '-include vendor/lineage-priv/keys/keys.mk' to your device mk file"
echo "Make copies of your vendor/lineage-priv folder as it contains your keys!"
sleep 3
