# Arch Install Notes
## Base Install
```shell
pacstrap /mnt linux linux-firmware vim intel-ucode
```

## Arch-Chroot Packages
```shell
pacman -S grub efibootmgr networkmanager network-manager-applet dialog wpa_supplicant mtools dosfstools git reflector bluez bluez-utils cups hplip xdg-user-dirs alsa-utils pulseaudio pulseaudio-bluetooth inetutils base-devel linux-headers bash-completion
```
## Pacman Packages
### List
1. xorg
2. lightdm
3. lightdm-gtk-greeter
4. qtile
5. xf86-input-libinput
6. xterm
7. alacritty
8. pcmanfm
9. firefox
10. sxhkd
11. nitrogen
12. unzip
13. lxappearance-gtk3
14. neofetch
15. rofi
16. python-psutil
17. ttf-roboto
18. volumeicon
19. blueberry
20. lxsession
21. gvfs
22. gparted
23. telegram-desktop
25. code
26. audacity
27. kdenlive
28. obs-studio
29. gnome-keyring
30. xf86-video-intel (video driver)
31. xfce4-appfinder
32. htop
33. flameshot
34. ncdu
35. gvfs-google
36. bleachbit
37. linux-lts
38. linux-lts-headers
39. linux-zen
40. linux-zen-headers
41. arandr
42. strawberry
43. galculator
44. sxiv
### Command
```shell
sudo pacman -S xorg lightdm lightdm-gtk-greeter qtile xf86-input-libinput xterm alacritty pcmanfm firefox sxhkd nitrogen unzip lxappearance neofetch rofi python-psutil ttf-roboto volumeicon blueberry lxsession gvfs gparted telegram-desktop code audacity kdenlive obs-studio gnome-keyring xf86-video-intel xfce4-appfinder htop flameshot ncdu gvfs-google bleachbit linux-lts linux-lts-headers linux-zen linux-zen-headers arandr strawberry galculator sxiv
```
## AUR Packages
### List
1. ttf-input
2. picom-jonaburg-git
3. pamac-aur
4. gruvbox-material-gtk-theme-git
5. gruvbox-material-icon-theme-git
6. multilockscreen-git
7. timeshift
8. mailspring
9. spotify
10. scid_vs_pc
11. obsidian
12. system76-power (sudo systemctl enable system76-power)
13. system76-acpi-dkms
14. system76-dkms
15. system76-io-dkms
16. bitwarden
17. google-chrome
18. everdo
19. zoom
20. onlyoffice-bin
21. ttf-ms-fonts
22. ofono (helps with bluetooth audio - sudo systemctl enable ofono)
23. zotero
24. gnome-control-center-nocheese
25. gnome-calendar-git
26. brave-bin
27. lightdm-slick-greeter
28. lightdm-settings
29. code-marketplace
### Command
```shell
sudo yay -S ttf-input picom-jonaburg-git pamac-aur gruvbox-material-gtk-theme-git gruvbox-material-icon-theme-git multilockscreen-git timeshift mailspring spotify scid_vs_pc obsidian system76-power system76-acpi-dkms system76-dkms system76-io-dkms bitwarden google-chrome everdo zoom onlyoffice-bin ttf-ms-fonts ofono zotero gnome-control-center-nocheese gnome-calendar-git brave-bin lightdm-slick-greeter lightdm-settings code-marketplace
```
## Installed from Source
1. [yay](https://github.com/Jguer/yay)
2. [fontawesome](https://use.fontawesome.com/releases/v5.15.3/fontawesome-free-5.15.3-desktop.zip) 
3. [system76-firmware](https://support.system76.com/articles/system76-driver)
4. [system76-driver](https://support.system76.com/articles/system76-driver)
5. [Rofi Power Menu](https://github.com/jluttine/rofi-power-menu)
6. [SnapD](https://snapcraft.io/install/journey/arch)
7. [expressvpn](https://www.expressvpn.com/)
## Snaps
### List
1. journey
2. deja-dup
### Command
```shell
sudo snap install journey deja-dup --classic
```
## Other Notes
Comment out lines 41-44 in /usr/lib/blueberry/blueberry-tray.py to fix dark icon problem in the systray. The lines are shown below:
```python
if self.settings.get_boolean("use-symbolic-icons"):
            self.tray_icon = "blueberry-tray-symbolic"
            self.tray_active_icon = "blueberry-tray-active-symbolic"
            self.tray_disabled_icon = "blueberry-tray-disabled-symbolic"
```

Change ControllerMode = bredr in /etc/bluetooth/main.conf in order to pair AirPods:
```c
ControllerMode = bredr
```
### Improve Font Rendering
Follow this guide: https://wiki.manjaro.org/index.php/Improve_Font_Rendering