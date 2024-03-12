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

# Setup Keyboard
if prompt_user "The following script will setup the keyboard on the Pixelbook Go, would you like to continue?" "(yes/y, skip/s, exit/e/x)"; then
    sudo cp pc /usr/share/X11/xkb/symbols/
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
    git clone https://github.com/mirrorsonthewall/halmaklinuxsupport.git
    cd halmaklinuxsupport/halmak-linux/
    sudo cp zz /usr/share/X11/xkb/symbols/ && cp evdev.xml /usr/share/X11/xkb/rules/
fi

# Firmware Update/Removal
if prompt_user "The following script will run the firmware updater/remover, would you like to continue?" "(yes/y, skip/s, exit/e/x)"; then
    cd
    git clone https://github.com/MrChromebox/scripts
    cd scripts/
    sh sudo firmware-util.sh
fi
