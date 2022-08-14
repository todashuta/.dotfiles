## zshenv for Linux

export ZDOTDIR="$HOME/.zsh"

export GOROOT="$HOME/local/go/current"  # official binary
export GOPATH="$HOME/go"

typeset -gx -U path
path=(
    $HOME/bin(N-/^W)
    $HOME/.plenv/shims(N-/^W)
    $HOME/.plenv/bin(N-/^W)
    $HOME/.rbenv/bin(N-/^W)
    $HOME/.cargo/bin(N-/^W)
    $path
    $GOROOT/bin(N-/^W)
    $GOPATH/bin(N-/^W)
    $HOME/local/bin(N-/^W)
    $HOME/.local/bin(N-/^W)

    #/usr/local/sbin
    #/usr/sbin
    #/sbin
)

export PAGER=less
export EDITOR=vim

export LSCOLORS='gxfxcxdxbxegedabagacad'
export LS_COLORS='di=36:ln=35:so=32:pi=33:ex=31:bd=34;46:cd=34;43:su=30;41:sg=36;40:tw=30;42:ow=30;43'
export ZLS_COLORS="$LS_COLORS"

(( $+commands[rbenv] )) && eval "$(rbenv init - zsh)" || :
#(( $+commands[plenv] )) && eval "$(plenv init - zsh)" || :

# Skip Ubuntu system-wide compinit
# See: `/etc/zsh/zshrc' on Ubuntu
skip_global_compinit=1
