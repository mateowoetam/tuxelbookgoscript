## Pixelbook Go Linux Setup Script / TuxelbookGo script

This Bash script automates the setup process for audio configuration, keyboard layout, and firmware updates on the Google Pixelbook Go when running Linux.

### Features:

- **Audio Setup**: Configures audio settings for optimal performance on the Pixelbook Go.
- **Keyboard Setup**: Sets up the keyboard layout, including remapping keys for better usability.
- **Halmak Keyboard Layout**: Optionally installs the Halmak keyboard layout for users preferring this alternative layout.
- **Firmware Management**: Provides options to update or revert to default firmware using MrChromebox's firmware utility.

### Usage:

1. Clone this repository:

    ```bash
    git clone https://github.com/mateowoetam/tuxelbookgoscript.git
    ```

2. Run the script:

    ```bash
    cd tuxelbookgoscript/
    sh tuxelbook.sh
    ```

3. Follow the prompts to configure audio, keyboard layout, and firmware according to your preferences.


### Known Issues:
I still haven't figured out how to map the assistant key so for now it does nothing, maybe there's a way on X11 with xf86tools or equivalent but I have no way to know because all my devices are on Wayland
I recomment runing MrChromebox's firmware utility by itself rather than with this script as it fails (in a non-destructive way, it just fails to download)

#### warnings:
This code has only been tested on Pixelbook Go running Nobara 39, but presumably works on other Fedora/RHEL based distos, and distros that use the same mapings for kebyard (xkb) like Debian, Arch, Ubuntu, Pop!_OS, (this is rather dependant ont he Destkop Environment/Window Manager I believe though, it works with, it has been tested to work with KDE Plasma 6 and GNOME 45

### Contributions:

Contributions are welcome! If you find any issues or have suggestions for improvements, feel free to open an issue or submit a pull request.


### Special Thanks:
thank you to all the developers who created the scripts this runs, [WeirdTreeThing](https://github.com/WeirdTreeThing) for [Chromebook Linux Audio](https://github.com/WeirdTreeThing/](https://github.com/WeirdTreeThing/chromebook-linux-audio)https://github.com/WeirdTreeThing/chromebook-linux-audio), [mirrorsonthewall](https://github.com/mirrorsonthewall) for [Halmak Linux Support](https://github.com/mirrorsonthewall/halmaklinuxsupport), and [MrChromebox](https://github.com/MrChromebox) for [MrChromebox Scripts](https://github.com/MrChromebox/scriptsy)
