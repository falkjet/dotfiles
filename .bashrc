[[ $- != *i* ]] && return
PS1='\u@\h \W $ '

### source .profile
[[ -e ~/.profile ]] && source ~/.profile

### Starship ###
if command -v starship >/dev/null; then
  source <(starship init bash --print-full-init)
fi

### autocompletion ###
[ -r /usr/share/bash-completion/bash_completion ] && . /usr/share/bash-completion/bash_completion
complete -cf sudo
