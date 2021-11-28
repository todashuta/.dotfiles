# profile

LANG="ja_JP.UTF-8"
export LANG

EDITOR="vim"
export EDITOR

PAGER="less"
export PAGER

if [ -n "$WSL_DISTRO_NAME" ] ; then
    SCREENDIR="$HOME/.screen"
    export SCREENDIR
fi

GOPATH="$HOME/go"
export GOPATH

if [ -z "$dotprofile_loaded" ] ; then
    if [ -z "$PATH" ] ; then
        PATH="/usr/sbin:/usr/bin:/sbin:/bin"
    fi

    if [ -d "$GOPATH/bin" ] ; then
        PATH="$PATH:$GOPATH/bin"
    fi

    if [ -d "$HOME/bin" ] ; then
        PATH="$HOME/bin:$PATH"
    fi

    if [ -d "$HOME/.local/bin" ] ; then
        PATH="$HOME/.local/bin:$PATH"
    fi

    if [ -d "$HOME/.dotfiles/bin" ] ; then
        PATH="$HOME/.dotfiles/bin:$PATH"
    fi

    export PATH

    dotprofile_loaded=true
    export dotprofile_loaded
fi

# vim: set et ts=4 sts=4 sw=4:
# end of profile
