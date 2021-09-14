### Enable Powerlevel10k instant prompt. ###
emulate -LR zsh
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

### source .profile
[[ -e ~/.profile ]] && emulate sh -c 'source ~/.profile'

### input ###
bindkey -e
bindkey "\e[3~" delete-char
bindkey "^[[1;3D" backward-word
bindkey "^[[1;5D" backward-word
bindkey "^[[1;3C" forward-word
bindkey "^[[1;5C" forward-word
WORDCHARS=''

### Powerlevel10k ###
USE_POWERLINE="true"
if [[ -e /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme ]]; then
  source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme
fi
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

### autocompletion ###
autoload compinit
compinit -y
