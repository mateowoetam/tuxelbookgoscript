#!/bin/bash -x

echo '
  _______             _ _                 _     _____  ____
 |__   __|           | | |               | |   / ____|/ __ \
    | |_   ___  _____| | |__   ___   ___ | | _| |  __| |  | |
    | | | | \ \/ / _ \ |  _ \ / _ \ / _ \| |/ / | |_ | |  | |
    | | |_| |>  <  __/ | |_) | (_) | (_) |   <| |__| | |__| |
    |_|\__ _/_/\_\___|_|_.__/ \___/ \___/|_|\_\\_____|\____/

'

# Function to prompt user with given message
prompt_user() {
    local message=$1
    local options=$2
    local response
    while true; do
        read -p "$message $options: " response
        case $response in
            [Yy]* ) return 0;;
            [Ss]* ) return 1;;
            [EeXx]* ) exit;;
            * ) echo "Please answer yes (y), skip (s), or exit (e/x).";;
        esac
    done
}

# Function to copy Halmak files and handle errors
copy_halmak_files() {
    local halmak_dir="$1"
    local config_symbols_dir="/home/$USER/.config/xkb/symbols"
    local config_rules_dir="/home/$USER/.config/xkb/rules"
    local src_symbols="$halmak_dir/zz"
    local src_rules="$halmak_dir/evdev.xml"
    local dest_symbols="$config_symbols_dir/zz"
    local dest_rules="$config_rules_dir/evdev.xml"

    mkdir -p "$config_symbols_dir" "$config_rules_dir"

    if ! cp "$src_symbols" "$dest_symbols" || ! cp "$src_rules" "$dest_rules"; then
        echo "Failed to copy files to $dest_symbols and $dest_rules."
        exit 1
    fi

    echo "After restarting, open your system's keyboard settings."
    echo "Add a new input source, select 'Other', and then choose 'Halmak' from the list."
}

# Setup Keyboard
if prompt_user "The following script will setup the keyboard on the Pixelbook Go, would you like to continue?" "(yes/y, skip/s, exit/e/x)"; then
    sudo cp 60-keyboard.hwdb /lib/udev/hwdb.d
    cd
    git clone https://github.com/rvaiya/keyd
    cd keyd
    make && sudo make install
    sudo systemctl enable --now keyd
    cd
    git clone https://github.com/WeirdTreeThing/cros-keyboard-map
    cd cros-keyboard-map
    ./install.sh
fi

# Setup Audio
if prompt_user "The following script will setup the audio on the Pixelbook Go, would you like to continue?" "(yes/y, skip/s, exit/e/x)"; then
    cd
    git clone https://github.com/WeirdTreeThing/chromebook-linux-audio.git
    cd chromebook-linux-audio/
    ./setup-audio
fi

# Setup Halmak Keyboard Layout
if prompt_user "The following script will setup the Halmak keyboard layout, would you like to continue?" "(yes/y, skip/s, exit/e/x)"; then
    cd
    git clone https://github.com/mateowoetam/halmaklinuxsupport.git
    cd halmaklinuxsupport/halmak-linux/
    copy_halmak_files "$(pwd)"
fi

# Firmware Update/Removal
if prompt_user "The following script will run the firmware updater/remover, would you like to continue?" "(yes/y, skip/s, exit/e/x)"; then
    cd
    git clone https://github.com/MrChromebox/scripts
    cd scripts/
    sudo sh firmware-util.sh
fi
