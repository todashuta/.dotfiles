# bash_aliases

alias f=fg
alias j='jobs -l'
alias h=history

alias ..='cd ..'
alias -- -='cd -'

alias lt='ls -AFlrt'

alias vi='vim -u NONE -i NONE -N'
alias lang-c='env LC_ALL=C LANG=C'
alias xo=xdg-open

alias c='printf "\017\033c"; stty sane; reset'
alias date-iso8601='LANG=C date +%Y%m%dT%H%M%S%z'
