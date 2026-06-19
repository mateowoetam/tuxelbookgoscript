#!/bin/sh
printf '%s\n' '
  _______             _ _                 _     _____  ____
 |__   __|           | | |               | |   / ____|/ __ \
    | |_   ___  _____| | |__   ___   ___ | | _| |  __| |  | |
    | | | | \ \/ / _ \ |  _ \ / _ \ / _ \| |/ / | |_ | |  | |
    | | |_| |>  <  __/ | |_) | (_) | (_) |   <| |__| | |__| |
    |_|\__ _/_/\_\___|_|_.__/ \___/ \___/|_|\_\\_____|\____/

'
prompt_user(){
message=$1
options=$2
while :;do
printf '%s %s: ' "$message" "$options"
IFS= read -r response||exit 1
case $response in
[Yy]*)return 0;;
[Ss]*)return 1;;
[EeXx]*)exit 0;;
*)printf '%s\n' "Please answer yes (y), skip (s), or exit (e/x)."
esac
done
}
copy_halmak_files(){
halmak_dir=$1
user=${USER:-$(id -un 2>/dev/null)}
config_symbols_dir="/home/$user/.config/xkb/symbols"
config_rules_dir="/home/$user/.config/xkb/rules"
src_symbols=$halmak_dir/zz
src_rules=$halmak_dir/evdev.xml
dest_symbols=$config_symbols_dir/zz
dest_rules=$config_rules_dir/evdev.xml
mkdir -p "$config_symbols_dir" "$config_rules_dir"||exit 1
if ! cp "$src_symbols" "$dest_symbols"||! cp "$src_rules" "$dest_rules";then
printf '%s\n' "Failed to copy files to $dest_symbols and $dest_rules."
exit 1
fi
printf '%s\n' "After restarting, open your system's keyboard settings."
printf '%s\n' "Add a new input source, select 'Other', and then choose 'Halmak' from the list."
}
if prompt_user "The following script will setup the keyboard on the Pixelbook Go, would you like to continue?" "(yes/y, skip/s, exit/e/x)";then
sudo cp 60-keyboard.hwdb /lib/udev/hwdb.d||exit 1
cd "$HOME"||exit 1
git clone https://github.com/rvaiya/keyd||exit 1
cd keyd||exit 1
make||exit 1
sudo make install||exit 1
sudo systemctl enable --now keyd||exit 1
cd "$HOME"||exit 1
git clone https://github.com/WeirdTreeThing/cros-keyboard-map||exit 1
cd cros-keyboard-map||exit 1
sh ./install.sh||exit 1
fi
if prompt_user "The following script will setup the audio on the Pixelbook Go, would you like to continue?" "(yes/y, skip/s, exit/e/x)";then
cd "$HOME"||exit 1
git clone https://github.com/WeirdTreeThing/chromebook-linux-audio.git||exit 1
cd chromebook-linux-audio/||exit 1
sh ./setup-audio||exit 1
fi
if prompt_user "The following script will setup the Halmak keyboard layout, would you like to continue?" "(yes/y, skip/s, exit/e/x)";then
cd "$HOME"||exit 1
git clone https://github.com/mateowoetam/halmaklinuxsupport.git||exit 1
cd halmaklinuxsupport/halmak-linux/||exit 1
copy_halmak_files "$(pwd)"
fi
if prompt_user "The following script will run the firmware updater/remover, would you like to continue?" "(yes/y, skip/s, exit/e/x)";then
cd "$HOME"||exit 1
git clone https://github.com/MrChromebox/scripts||exit 1
cd scripts/||exit 1
sudo sh firmware-util.sh||exit 1
fi
