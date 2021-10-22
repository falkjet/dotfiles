# Dotfiles
this repository contains my personal dotfiles and scripts.

## Install
~~~bash
git clone "https://github.com/falkjet/dotfiles" --bare "$HOME/dotfiles"
git --git-dir="$HOME/dotfiles" --work-tree="$HOME" config status.showUntrackedFiles no
git --git-dir="$HOME/dotfiles" --work-tree="$HOME" sparse-checkout set '/*' '!*.md'
git --git-dir="$HOME/dotfiles" --work-tree="$HOME" checkout -f
~~~

