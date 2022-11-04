#!/bin/sh

# PROTOTYPE

USER="desktop31"
DOTS_DIR=$(pwd)
PACMAN="sudo pacman -S --noconfirm"
YAY="yay -S --noconfirm"

# Install yay
sudo git clone https://aur.archlinux.org/yay.git ~/yay
sudo chown -R $USER:users ~/yay
cd ~/yay && makepkg -si
cd $DOTS_DIR

# Copy configs and themes, install DWM
cp -r config/* ~/.config/

cd ~/.config/dwm31 && sudo make install
if [ ! -d /usr/share/xsessions/ ]; then
	sudo mkdir -p /usr/share/xsessions/
fi
sudo cp ./dwm.desktop /usr/share/xsessions/
cd $DOTS_DIR

cp -r Scripts ~/Scripts

if [ ! -d /usr/share/themes/ ]; then
	sudo mkdir -p /usr/share/themes
fi

if [ ! -d /usr/share/themes/ ]; then
	sudo mkdir -p /usr/share/icons
fi

sudo tar -xzf themes/GTK/Flat-Remix-GTK-Yellow-Dark.tar.gz -C /usr/share/themes/
sudo tar -xzf themes/Icons/Flat-Remix-Grey-Dark.tar.gz -C /usr/share/icons/

# LIGHTDM install
echo "$($PACMAN lightdm)"
echo "$($YAY web-greeter lightdm-theme-neon-git)"
sudo cp lightdm/web-greeter.yml /etc/lightdm/web-greeter.yml
sudo systemctl enable lightdm

# Copy Wallpapers and Logos where they belong
$($PACMAN xdg-user-dirs)
xdg-user-dirs-update
cp -r Wallpapers ~/Pictures/
sudo cp -r Wallpapers /usr/share/backgrounds
cp Logos/Pirate_Duck_round.png ~/.face

# OH-MY-ZSH install and config
echo "$($PACMAN zsh)"
chsh -s $(which zsh)
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

mv ~/.oh-my-zsh/ ~/.config/oh-my-zsh/
cp .zshrc ~/.zshrc
cp oh-my-zsh/custom/themes/*.zsh-theme ~/.config/oh-my-zsh/custom/themes/
cp oh-my-zsh/custom/*.zsh ~/.config/oh-my-zsh/custom/
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.config/oh-my-zsh/custom/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.config/oh-my-zsh/custom/plugins/zsh-syntax-highlighting

# Pipewire install
echo "$($PACMAN pipewire pipewire-alsa pipewire-pulse pipewire-jack wireplumber qpwgraph)"
systemctl --user enable --now pipewire.socket
systemctl --user enable --now pipewire-pulse.socket
systemctl --user enable --now wireplumber.service

# Install packages
echo "$($YAY $(cat packages))"

# Xorg config
sudo cp X11/xorg.conf /etc/X11/xorg.conf
if [ ! -d /etc/X11/xorg.conf.d/ ]; then
	sudo mkdir -p /etc/X11/xorg.conf.d/
fi
sudo cp X11/xorg.conf.d/* /etc/X11/xorg.conf.d/

# TODO: add packages (xorg, ...)
