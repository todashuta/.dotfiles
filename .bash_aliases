# bash_aliases

alias f=fg
alias j='jobs -l'
alias h=history

alias ..='cd ..'
alias -- -='cd -'

alias ls='command ls --color=auto'
alias ll='command ls --color=auto -alF'
alias la='command ls --color=auto -A'
alias  l='command ls --color=auto -CF'
alias lt='command ls --color=auto -AFlrt'

alias  grep='command grep --color=auto'
alias fgrep='command grep --color=auto -F'
alias egrep='command grep --color=auto -E'

alias vi='vim -u NONE -i NONE -N'
alias lang-c='env LC_ALL=C LANG=C'
alias xo=xdg-open

alias c='printf "\017\033c"; stty sane; reset'
alias cls='printf "\017\033c"; stty sane; reset'
alias date-iso8601='LANG=C date +%Y%m%dT%H%M%S%z'

alias update-SSH_AUTH_SOCK="eval \$(tmux show-environment -s SSH_AUTH_SOCK 2>/dev/null); ssh-add -l"
alias update-DISPLAY="export DISPLAY=\$(awk '/^nameserver/ {print \$2}' /etc/resolv.conf):0.0; echo \$DISPLAY"

alias Man='env MANWIDTH=$(( COLUMNS < ${maxmanwidth:-80} ? COLUMNS : ${maxmanwidth:-80} )) man'
complete -F _man Man

alias Journalctl='journalctl -o short-full'
complete -F _journalctl Journalctl
