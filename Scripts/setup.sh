#!/bin/bash
cd || exit

function log_stage {
    echo -e "\e[32m$@\e[0m"
}

#######################
## Download Dotfiles ##
#######################
if [ ! -d "$HOME/dotfiles" ]
then
    log_stage "Downloading Dotfiles"
    git clone "https://github.com/falkjet/dotfiles" --bare "$HOME/dotfiles"
    git --git-dir="$HOME/dotfiles" --work-tree="$HOME" config status.showUntrackedFiles no
    git --git-dir="$HOME/dotfiles" --work-tree="$HOME" sparse-checkout set '/*' '!*.md'
    git --git-dir="$HOME/dotfiles" --work-tree="$HOME" checkout -f
    source .profile
    exec bash Scripts/setup.sh
fi

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
        packages=(
            git
            git-delta
            starship
            bat
            fzf
            neovim
            unzip
        )
        if [ "$XDG_CURRENT_DESKTOP" = GNOME ]; then
            packages+=(gnome-extensions-app gnome-tweaks papirus-icon-theme)
        fi
        packages=($(comm -23 <(for package in "${packages[@]}"; do echo "$package"; done | sort -u) <(dnf list installed | cut -d. -f1 | sort)))
        if [ ${#packages[@]} != 0 ]; then
            log_stage Installing Packages
            sudo dnf install ${packages[@]}
        fi;;
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
    log_stage Installing nvim plugins
	git clone --depth 1 https://github.com/wbthomason/packer.nvim "$packer_dir"
    nvim --headless -u <(echo 'lua require("plugins")
autocmd User PackerComplete quitall
PackerInstall')
fi

font=JetBrainsMono
if [ -n ${XDG_CURRENT_DESKTOP:+x} ] && [ ! -f "$HOME/.local/share/fonts/JetBrains Mono Regular Nerd Font Complete.ttf" ]
then
    log_stage Download Fonts
    tmp="$(mktemp -d)"
    echo "$tmp"
    curl -fLo "$tmp/$font.zip" https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/JetBrainsMono.zip
    unzip "$tmp/$font.zip" -d "$tmp"
    mkdir -p "$HOME/.local/share/fonts/"
    mv -f "$tmp"/*.ttf "$HOME/.local/share/fonts/"
    rm -rf "$tmp"
fi

if [ ! -d "$NVM_DIR" ]
then
    log_stage Installing NVM
    mkdir -p "$NVM_DIR"
    PROFILE=/dev/null bash -c "$(curl https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh)"
    source "$NVM_DIR"/nvm.sh
    nvm install --lts
    nvm use --lts
fi


########################
## Desktop environmet ##
########################
case "$XDG_CURRENT_DESKTOP" in
    GNOME)
        log_stage Configuring Gnome Keybindings
        gkeybind add browser Browser '<Super>b' firefox
        gkeybind add terminal "GNOME Terminal" '<Super>Return' gnome-terminal
        gsettings set org.gnome.desktop.wm.keybindings switch-windows "['<Alt>Tab']"
        gsettings set org.gnome.desktop.wm.keybindings switch-windows-backward  "['<Shift><Alt>Tab']"
        gsettings set org.gnome.desktop.wm.keybindings switch-applications "['<Super>Tab']"
        gsettings set org.gnome.desktop.wm.keybindings switch-applications-backward "['<Shift><Super>Tab']"
        gsettings set org.gnome.desktop.wm.preferences resize-with-right-button true;;
esac

#########
## Git ##
#########
log_stage Configuring git
git config --global core.pager delta
git config --global interactive.diffFilter delta --color-only
git config --global delta.navigate true
git config --global delta.light false
git config --global merge.conflictstyle diff3
git config --global diff.colorMoved default

if [ -z "$(git config --global --get user.email)" ]; then
    echo -n "whats your email (git)? "
    read email;
    git config --global user.email "$email";
fi

if [ -z "$(git config --global --get user.name)" ]; then
    echo -n "whats your name (git)? "
    read name;
    git config --global user.name "$name";
fi
