#!/bin/bash

# Ask for ROM name
read -p "Enter ROM name: " rom_name

# If rom is lunaris, run lunaris.sh
if [[ "$rom_name" == "lunaris" ]]; then
    echo "Running lunaris.sh..."
    ./lunaris.sh
fi

# Run the key generation script and pass rom_name as argument
./make-keys.sh "$rom_name"
