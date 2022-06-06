#!/bin/sh
cd || exit

##########################
## Package Installation ##
##########################
if [ ! -f /etc/os-release ]
then
    echo This distro is not supported
    exit 1
fi

os=$(. /etc/os-release; echo "$ID")
case "$os" in
    fedora)
        sudo dnf install starship starship bat papirus-icon-theme gnome-tweaks gnome-extensions-app fzf;;
    *)
        echo This distro is not supported
        exit 1;;
esac

###############
## Downloads ##
###############
packer_dir="${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/pack/packer/start/packer.nvim
if [ ! -d "$packer_dir" ];
then
	git clone --depth 1 https://github.com/wbthomason/packer.nvim "$packer_dir"
fi

if [ ! -d "$HOME/dotfiles" ]
then
    git clone "https://github.com/falkjet/dotfiles" --bare "$HOME/dotfiles"
    git --git-dir="$HOME/dotfiles" --work-tree="$HOME" config status.showUntrackedFiles no
    git --git-dir="$HOME/dotfiles" --work-tree="$HOME" sparse-checkout set '/*' '!*.md'
    git --git-dir="$HOME/dotfiles" --work-tree="$HOME" checkout -f
fi

font=JetBrainsMono
if [ ! -f "$HOME/.local/share/fonts/JetBrains Mono Regular Nerd Font Complete.ttf" ]
then
    tmp="$(mktemp -d)"
    echo "$tmp"
    curl -fLo "$tmp/$font.zip" https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/JetBrainsMono.zip
    unzip "$tmp/$font.zip" -d "$tmp"
    mkdir -p "$HOME/.local/share/fonts/"
    mv -f "$tmp"/*.ttf "$HOME/.local/share/fonts/"
    rm -rf "$tmp"
fi


########################
## Desktop environmet ##
########################
case "$XDG_CURRENT_DESKTOP" in
    GNOME)
        gsettings set org.gnome.desktop.wm.keybindings switch-windows "['<Alt>Tab']"
        gsettings set org.gnome.desktop.wm.keybindings switch-windows-backward  "['<Shift><Alt>Tab']"
        gsettings set org.gnome.desktop.wm.keybindings switch-applications "['<Super>Tab']"
        gsettings set org.gnome.desktop.wm.keybindings switch-applications-backward "['<Shift><Super>Tab']"
        gsettings set org.gnome.desktop.wm.preferences resize-with-right-button true;;
esac
