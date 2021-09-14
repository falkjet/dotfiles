[[ $- != *i* ]] && return
PS1='\u@\h \W $ '

### source .profile
[[ -e ~/.profile ]] && source ~/.profile

### Starship ###
source <(starship init bash --print-full-init)

### autocompletion ###
[ -r /usr/share/bash-completion/bash_completion ] && . /usr/share/bash-completion/bash_completion
complete -cf sudo
