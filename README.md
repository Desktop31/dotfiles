# Dots
My Arch linux configuration

## Basic info
- lightdm (web-greeter + neon theme)
- custom patched DWM
- polybar (polybar-dwm-module)
- picom-animations-git
- zsh shell (with oh-my-zsh)
- pipewire + wireplumber
- micro editor 

## Automatic installation (WIP!)
Run **autoinstall.sh** for automatic deployment. <br>
The script only deploys the config files and installs my preffered packages, <br>
it is meant to be run after Arch is fully installed, with network already set up. <br>
<br>
Make sure to run the script **as a user** and **from the directory** where it is located!

## Screenshot
![Rice preview](preview.png)

## Fonts used
- https://archlinux.org/packages/community/any/ttf-liberation/
- https://archlinux.org/packages/community/any/ttf-font-awesome/
- https://archlinux.org/packages/community/any/ttf-iosevka-nerd/
- https://archlinux.org/packages/extra/any/noto-fonts/
- https://archlinux.org/packages/extra/any/noto-fonts-emoji/
- https://aur.archlinux.org/packages/ttf-material-design-icons
- https://aur.archlinux.org/packages/nerd-fonts-hermit
- https://aur.archlinux.org/packages/ttf-unifont

```
yay -S ttf-liberation ttf-font-awesome ttf-iosevka-nerd noto-fonts noto-fonts-emoji ttf-material-design-icons nerd-fonts-hermit ttf-unifont
```
